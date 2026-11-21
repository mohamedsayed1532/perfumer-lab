# Design Document: Closed-Loop Fragrance Formulation & Bench Compounding System

**Date**: 2026-11-21  
**Status**: Pending Approval  
**Scope**: Project (Formulation Mods, IFRA Guard, Atomic Scale-to-Stock Compounding, Inventory Audit Ledger, Printable Batch Sheets)

---

## 1. Intent & The Why
In a professional perfumery lab, fragrance design and physical compounding must operate as a closed loop. Today, the app has disconnected tools: formulas can be written, and batches can be weighed on a bench scale, but compounding does not deduct inventory from raw material stock bottles, there is no audit log of material depletion, formulas cannot be branched into iterative trials ("Mods"), and there is no physical paper trail (printable batch sheet) for the lab clipboard.

This project closes the loop between digital formula composition and physical bench production.

---

## 2. Goals, Non-Goals & Anti-Goals

### Goals
- **Formula Mod Iteration**: 1-tap "Duplicate as Mod" allowing a perfumer to branch variations (e.g. `Mod 1` → `Mod 2`) preserving the original baseline.
- **Live Olfactory & IFRA Guard**: Visual Top/Heart/Base ratio balance bar on formula details, with real-time warning indicators for materials exceeding IFRA guidelines or ideal maximum limits.
- **Atomic Scale-to-Stock Compounding**: Weighed grams in bench compounding atomically update physical `stockGrams` and record an `AgingBatch` in a single SQLite transaction.
- **Inventory Activity Ledger**: Maintain an audit trail (`InventoryLogs`) recording date, material ID, delta grams, transaction type (`compounding`, `manual_adjustment`), and linked batch number.
- **Completion Summary Modal**: Display an immediate post-compounding breakdown of yield, deducted materials, remaining bottle weights, and amber warning badges for low stock (<10g).
- **Printable Lab Binder Sheet**: 1-tap export of a clean, standardized batch compounding worksheet with scale target weights and checkoff lines for the physical clipboard via `SharePlus`.

### Non-Goals
- Real-time Bluetooth scale hardware connectivity (weights remain manually logged or 1-tap confirmed at the bench).
- Commercial multi-warehouse inventory management (this is designed for single-lab / studio bench inventory).
- Automatic IFRA database web scraper (uses existing `idealMaxPercent` and standard Category 4 reference limits).

### Anti-Goals
- Do not require destructive database resets. Existing user formulas, raw materials, and aging batches must be preserved via clean Drift migration (`schemaVersion = 2`).
- Do not silently deplete stock without showing the user the exact remaining amounts and warnings.

---

## 3. Constraints
- **Apple Human Interface Guidelines**: 44pt minimum touch targets, WCAG AA contrast (4.5:1 text), SF-style typography, liquid glass chrome on navigation, high-contrast modal sheets with standardized `Cancel` / `Done` dismissals.
- **Framework & Libraries**: Flutter with Riverpod 3.x, Drift SQLite, `cupertino_ui`, `share_plus`. No unnecessary third-party packages.
- **Transactional Integrity**: All inventory deductions and batch creations must execute inside a `db.transaction()` block.

---

## 4. Approaches Considered

### Approach 1: Integrated In-Place Transactional Flow
Mutates `materials.stockGrams` in-place and creates the aging batch inside one transaction. No audit trail.
- *Pros*: Simple, no schema changes.
- *Cons*: No history of why a material ran out or when deductions occurred.

### Approach 2: Pure Event-Sourced Ledger
All inventory is computed dynamically as `SUM(quantity)` from an `inventory_transactions` ledger. Formulas use separate parent/child tables (`Formula` → `FormulaVersion` → `FormulaItem`).
- *Pros*: Full historical accounting.
- *Cons*: Heavy schema overhaul, breaking migration, slow aggregated queries on large catalogs.

### Selected Approach: Hybrid Architecture (Approach 1 + Approach 2 Audit Log)
- Maintains fast `materials.stockGrams` cached on the material for instant catalog queries.
- Adds an `InventoryLogs` table to record an immutable debit/credit audit trail on every compounding run or manual adjustment.
- Uses `Formulas.version` with 1-tap "Duplicate as Mod" cloning into new formula entities.
- Executes batch insertion, stock decrement, and ledger entry atomically inside `db.transaction()`.

---

## 5. Detailed Specifications

### 5.1 Database Schema (Drift Migration to v2)
Add `InventoryLogs` table:
```dart
class InventoryLogs extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get materialId => text().references(Materials, #id)();
  RealColumn get deltaGrams => real()(); // Negative for deduction, positive for restock
  RealColumn get remainingStockGrams => real()(); // Snapshot after transaction
  TextColumn get reason => text()(); // 'compounding', 'spill', 'restock', 'correction'
  TextColumn get referenceBatchId => text().nullable()(); // Linked AgingBatch ID
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
```
In `AppDatabase`:
- Bump `schemaVersion` to `2`.
- Provide `MigrationStrategy(onUpgrade: (m, from, to) async { if (from == 1) await m.createTable(inventoryLogs); })`.

### 5.2 Formula Mod Duplication & Olfactory Balance
- **Action**: In `FormulaDetailScreen`, add a "Duplicate as Mod" action in the navigation bar/menu.
- **Logic**: Reads current formula and formula items. Prompts user for name (defaults to `"<Name> Mod N"`). Clones header with bumped version and inserts duplicate `FormulaItems`.
- **Olfactory Pyramid Bar**: A compact horizontal segmented bar showing Top (Yellow), Heart (Pink/Red), and Base (Purple) percentages dynamically recalculated from formula items.
- **IFRA Safety Warning**: For each item, if `(partsPerThousand / totalPpt * 100) > idealMaxPercent`, render an amber warning tag `IFRA Alert: Exceeds X%`.

### 5.3 Bench Compounding Atomic Execution & Inventory Sync
In `BenchCompoundingScreen`:
1. User weighs each material on their physical scale and checks off each item.
2. On tapping **"Finish Compounding"**:
   - Begin SQLite transaction:
     - Deduct weighed grams from each `Materials.stockGrams`.
     - Insert an `InventoryLogs` record for each deducted ingredient.
     - Insert `AgingBatches` record.
   - Commit transaction.
3. Present **Compounding Summary Modal**:
   - Batch Number and total yield.
   - Table of materials: Name, Weighed Grams, Remaining Stock, Warning pill if remaining < 10g.
   - Primary Action: **"Export Lab Batch Sheet"** (Share / Print).
   - Secondary Action: **"Done & View Aging Tracker"**.

### 5.4 Lab Binder Batch Sheet Export
- Generates a beautifully formatted plaintext / markdown worksheet shared via `SharePlus`:
  - Lab Header, Batch Number, Date, Formula Name & Version.
  - Target Batch Size (grams) and concentration.
  - Step-by-step table: Step #, Material Name, Dilution %, Target Weight (g), Actual Weighed (g), Sign-off.
  - Notes & Storage instructions for physical lab clipboard.

---

## 6. Builder Resolutions & Operational Edge Cases
- **Negative Stock Policy**: If `stockGrams - weighedGrams < 0`, the transaction will **not** block the user. At a physical lab bench, the perfumer is holding the physical bottle and pouring onto the scale; an outdated digital count must not stop bench compounding. The stock will record the negative value / deficit, and the post-compounding summary will highlight it with a red warning badge (*"Bottle depleted / negative stock"*).
- **Incomplete / Partial Compounding**: If the user finishes before all items are checked off, a prompt asks to complete with recorded weights or return. Only items actually weighed and recorded will have their stock deducted and logged.
- **Physical Bottle Alignment**: Deductions map 1:1 to the selected `materialId` in the formula. If the formula uses a pre-diluted material (e.g. "Ethyl Vanillin 10% in DPG"), the weighed grams are deducted directly from that pre-diluted bottle's inventory.

---

## 7. What is Left to the Builder
- Exact layout spacing, typography sizes, and Cupertino colors matching existing design tokens.
- Haptic feedback mapping using `LabHaptics` (`selection`, `stepCompleted`, `batchSuccess`).
- Specific threshold for "Low Stock" indicator (defaulting to 10.0g).

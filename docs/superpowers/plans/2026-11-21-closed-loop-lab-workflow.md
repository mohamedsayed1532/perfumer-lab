# Closed-Loop Fragrance Formulation & Bench Compounding Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a closed-loop fragrance formulation and bench compounding workflow with a real-time IFRA 51st Amendment Category 4 safety engine, atomic scale-to-stock compounding, inventory audit logging, formula mod duplication, and printable batch sheets.

**Architecture:** Drift SQLite v2 with an immutable `InventoryLogs` table, pure Dart `IfraSafetyService` computing real skin exposure at target concentration, and native Cupertino lab UI with liquid glass highlights.

---

## File Structure & Responsibilities

- `lib/core/services/ifra_safety_service.dart`: Pure domain math for IFRA Category 4 skin exposure and max allowed grams/ppt calculation.
- `lib/core/database/tables/inventory_logs_table.dart`: Drift table definition for immutable stock debit/credit transactions.
- `lib/core/database/app_database.dart`: Database bump to schemaVersion 2 with migration strategy.
- `lib/features/formulas/data/formulas_repository.dart`: Atomic transactions for compounding and formula duplication as mod.
- `lib/features/formulas/presentation/widgets/ifra_safety_banner.dart`: Formula-level compliance banner (Safe Green vs Breach Red).
- `lib/features/formulas/presentation/widgets/olfactory_pyramid_bar.dart`: Horizontal segmented bar for Top/Heart/Base ratio.
- `lib/features/formulas/presentation/formula_detail_screen.dart`: Integrates IFRA safety banner, olfactory bar, and "Duplicate as Mod".
- `lib/features/formulas/presentation/compounding_summary_sheet.dart`: Post-compounding breakdown of yield, deducted grams, remaining stock, and batch sheet export.
- `lib/features/formulas/presentation/bench_compounding_screen.dart`: Pre-flight IFRA warning, scale checkoff, and transaction trigger.
- `test/core/services/ifra_safety_service_test.dart`: Unit tests for skin exposure math and IFRA limit violations.

---

## Tasks

### Task 1: IFRA Safety Calculation Engine & Unit Tests
**Deliverable:** Pure Dart `IfraSafetyService` with full test coverage for Category 4 skin exposure and limit calculations.

- [ ] Write failing unit test in `test/core/services/ifra_safety_service_test.dart`:
  - Calculate active chemical skin exposure given formula PPT, ingredient dilution %, and finished perfume concentration % (e.g., 20% EdP).
  - Verify compliant state when below IFRA threshold.
  - Verify violation state and calculate exact `maxAllowedPpt` when exceeding threshold.
- [ ] Run `flutter test test/core/services/ifra_safety_service_test.dart` and confirm failure.
- [ ] Implement `lib/core/services/ifra_safety_service.dart`:
  - `calculateSkinExposure({required double partsPerThousand, required double totalPpt, required double specifiedDilutionPercent, required double targetConcentrationPercent})`
  - `calculateMaxAllowedPpt({required double idealMaxPercent, required double specifiedDilutionPercent, required double targetConcentrationPercent, required double totalPpt})`
  - `evaluateFormulaSafety({required double targetConcentrationPercent, required List<FormulaItemSafetyInput> items})`
- [ ] Run `flutter test test/core/services/ifra_safety_service_test.dart` and confirm passes.
- [ ] Commit: `git commit -m "feat(ifra): implement IFRA 51st Amendment safety calculation engine with unit tests"`

---

### Task 2: Database Schema Migration (InventoryLogs Table)
**Deliverable:** Drift schema bump to version 2 with `InventoryLogs` table and migration strategy.

- [ ] Create `lib/core/database/tables/inventory_logs_table.dart`:
  - Columns: `id`, `materialId`, `deltaGrams`, `remainingStockGrams`, `reason`, `referenceBatchId`, `timestamp`.
- [ ] Update `lib/core/database/app_database.dart`:
  - Register `InventoryLogs` in `@DriftDatabase`.
  - Bump `schemaVersion` to 2.
  - Add `MigrationStrategy` creating `inventoryLogs` on upgrade from version 1.
- [ ] Run `dart run build_runner build --delete-conflicting-outputs` to regenerate `app_database.g.dart`.
- [ ] Verify test suite passes (`flutter test`).
- [ ] Commit: `git commit -m "feat(db): add InventoryLogs table and drift migration to schema v2"`

---

### Task 3: Repository Logic (Mod Duplication & Atomic Compounding)
**Deliverable:** Methods in `FormulasRepository` for formula cloning and atomic compounding.

- [ ] Add `duplicateFormulaAsMod(String formulaId, String newName)` in `lib/features/formulas/data/formulas_repository.dart`:
  - Reads source formula and formula items.
  - Generates new UUID, inserts formula with updated version string, and duplicates all items.
- [ ] Add `compoundBatchAndDeductStock(...)` in `FormulasRepository`:
  - Uses `db.transaction()` to atomically:
    1. Insert `AgingBatches` record.
    2. Subtract weighed grams from `Materials.stockGrams`.
    3. Insert corresponding `InventoryLogs` records.
- [ ] Add unit test verifying atomic compounding and stock deduction.
- [ ] Commit: `git commit -m "feat(formulas): add mod duplication and atomic stock compounding transaction"`

---

### Task 4: Formula Detail UI (IFRA Banner, Olfactory Bar & Mod Duplication)
**Deliverable:** Enhanced Formula Details screen showing live IFRA safety, olfactory balance, and duplicate action.

- [ ] Create `lib/features/formulas/presentation/widgets/ifra_safety_banner.dart`:
  - Green banner when Category 4 compliant at current EdP %.
  - Red alert banner when non-compliant listing the infringing materials and required adjustments.
- [ ] Create `lib/features/formulas/presentation/widgets/olfactory_pyramid_bar.dart`:
  - Compact segmented progress bar showing Top/Heart/Base % breakdown.
- [ ] Update `lib/features/formulas/presentation/formula_detail_screen.dart`:
  - Embed `IfraSafetyBanner` and `OlfactoryPyramidBar`.
  - Add "Duplicate as Mod" action sheet option with name prompt.
  - Add IFRA warning tags on individual material rows exceeding their limit.
- [ ] Run `flutter analyze lib/` to ensure zero errors or warnings.
- [ ] Commit: `git commit -m "feat(ui): add IFRA compliance banner, olfactory pyramid bar, and mod duplication to formula details"`

---

### Task 5: Bench Compounding UI (Safety Pre-Flight, Inventory Sync & Summary)
**Deliverable:** Compounding flow that checks IFRA safety, deducts stock atomically, and presents summary with export.

- [ ] Create `lib/features/formulas/presentation/compounding_summary_sheet.dart`:
  - Modal displaying Batch ID, total grams compounded.
  - Itemized table of materials deducted and remaining stock.
  - Warning pills for low stock (<10g) or negative stock.
  - Action buttons: "Export / Print Batch Sheet" and "Done".
- [ ] Update `lib/features/formulas/presentation/bench_compounding_screen.dart`:
  - Add pre-flight IFRA warning dialog if formula has violations before starting scale dispense.
  - Replace `_finishCompounding()` with call to `compoundBatchAndDeductStock`.
  - Present `CompoundingSummarySheet` upon completion.
  - Implement batch sheet sharing via `SharePlus`.
- [ ] Run `flutter analyze lib/` and `flutter test`.
- [ ] Commit: `git commit -m "feat(compounding): integrate pre-flight IFRA alert, atomic stock deduction, and completion summary sheet"`

---

### Task 6: Device Verification & Quality Polish
**Deliverable:** Build debug APK, deploy via ADB to connected device (`bd4d5144`), and verify on device.

- [ ] Run `flutter build apk --debug`.
- [ ] Install to device: `adb install -r build/app/outputs/flutter-apk/app-debug.apk`.
- [ ] Launch app and verify IFRA safety status and bench compounding on physical device.
- [ ] Clean up temporary files.
- [ ] Commit: `git commit -m "chore: verify closed-loop workflow on physical device"`

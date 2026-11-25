# Perfumer Lab

An offline-first mobile workspace for artisanal perfumers and fragrance formulators built with Flutter, Drift (SQLite), and Riverpod.

## Features

- **Formulas Studio**: Formulate in parts-per-thousand (PPT), view olfactory pyramid distribution (Top / Heart / Base), evaluate live IFRA 51st compliance per product category (`Cat 1`–`Cat 12`), and run guided **Bench Compounding** batches with atomic stock deduction.
- **Raw Materials Organ**: Track dilutions, solvents, density, stock mass, cost per gram, and olfactory notes. Includes a **7,406-CAS offline reference database** (+1,303 alternate CAS numbers) in `Create Material` that automatically suggests `Ideal Max %` and **GHS Safety Classifications** (`Flammable`, `Irritant`, `Health Hazard`, `Environmental`, `Corrosive`, `Acute Toxic`) as soon as you type a CAS number — without cluttering your personal inventory list.
- **Official IFRA 51st Amendment Library**: Search all **263 IFRA Standards** across all **18 categories** (`Cat 1`–`Cat 12`) and **302 Natural Complex Substances (NCS)** with constituent mappings directly inside Lab Utilities.
- **Ready Oils & Bottling**: Calculate final dilution ratios, concentrate weights, alcohol/carrier volumes, and bottling batches.
- **Aging & Maceration Tracker**: Log compounding batches and record olfactive evaluations over time.
- **Lab Utilities & Backups**: Alcohol gauging & proof calculator, solvent mass/density converter, and JSON/CSV database backup export.

## Try the Beta (Android)

1. Download the latest APK (`app-release.apk`) from the **Releases** page on GitHub.
2. Enable installing apps from unknown sources if prompted, and install the APK on your Android device.
3. Please share feedback or report any bugs via **[GitHub Issues](../../issues/new/choose)**!

## Build from Source

Requires Flutter SDK (Dart `^3.14.0`).

```bash
flutter pub get
flutter test
flutter build apk --release
```

## Feedback & Bug Reports

Found an issue, unexpected calculation, or UI glitch? Open an issue using the **Bug Report** or **Feedback** template and include your device model, Android version, and steps to reproduce.

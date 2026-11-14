import 'package:drift/drift.dart';

/// Raw aroma materials & chemicals matching the perfumer's 10-screenshot master schema.
class Materials extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get name => text()();
  TextColumn get casNumber => text().nullable()();
  TextColumn get secondaryCas => text().nullable()();
  TextColumn get einecs => text().nullable()();
  TextColumn get ecNumber => text().nullable()();
  TextColumn get fema => text().nullable()();
  TextColumn get jecfa => text().nullable()();
  TextColumn get flavis => text().nullable()();
  TextColumn get iupacName => text().nullable()();
  TextColumn get botanicalName => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get description => text().nullable()();

  // Olfactory pyramid: 'top', 'heart', 'base'
  TextColumn get pyramidNote => text().withDefault(const Constant('heart'))();

  // Categories JSON array: ['Natural', 'Synthetic', 'Essential Oil', 'Absolute', 'Isolate', 'Mix', 'Solvent']
  TextColumn get categoriesJson => text().withDefault(const Constant('[]'))();

  // Odor groups & profiles JSON
  TextColumn get odorProfilesJson => text().withDefault(const Constant('[]'))();

  // Physical & Dilution properties
  RealColumn get density => real().nullable()(); // g/cm3
  RealColumn get dilutionPercent => real().withDefault(const Constant(100.0))(); // default 100% (neat)
  TextColumn get defaultSolvent => text().nullable()(); // 'DPG', 'TEC', 'IPM', 'Ethanol'
  IntColumn get intensity => integer().withDefault(const Constant(3))(); // 1-5 scale
  RealColumn get relativeImpact => real().nullable()();
  TextColumn get odorLife => text().nullable()(); // e.g. "400 hours", "48 hours on blotter"
  RealColumn get idealMaxPercent => real().nullable()(); // IFRA or formula guide max %

  // Chemical properties
  TextColumn get molecularWeight => text().nullable()();
  TextColumn get molecularFormula => text().nullable()();
  TextColumn get flashPoint => text().nullable()();
  TextColumn get boilingPoint => text().nullable()();
  TextColumn get meltingPoint => text().nullable()();
  TextColumn get logP => text().nullable()();
  TextColumn get vaporPressure => text().nullable()();
  TextColumn get biodegradability => text().nullable()(); // Readily, Inherently, etc.
  RealColumn get renewableCarbonPercent => real().nullable()();

  // Safety: JSON array of GHS pictograms ['flammable', 'irritant', 'corrosive', etc.]
  TextColumn get hazardPictogramsJson => text().withDefault(const Constant('[]'))();

  // External reference links
  TextColumn get tgscUrl => text().nullable()();
  TextColumn get pubchemCid => text().nullable()();
  TextColumn get scentreeUrl => text().nullable()();
  TextColumn get wikipediaUrl => text().nullable()();

  // Bench stock & cost
  RealColumn get stockGrams => real().withDefault(const Constant(0.0))();
  RealColumn get costPerGram => real().withDefault(const Constant(0.0))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

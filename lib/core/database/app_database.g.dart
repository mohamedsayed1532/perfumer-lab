// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MaterialsTable extends Materials
    with TableInfo<$MaterialsTable, Material> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaterialsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _casNumberMeta = const VerificationMeta(
    'casNumber',
  );
  @override
  late final GeneratedColumn<String> casNumber = GeneratedColumn<String>(
    'cas_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _secondaryCasMeta = const VerificationMeta(
    'secondaryCas',
  );
  @override
  late final GeneratedColumn<String> secondaryCas = GeneratedColumn<String>(
    'secondary_cas',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _einecsMeta = const VerificationMeta('einecs');
  @override
  late final GeneratedColumn<String> einecs = GeneratedColumn<String>(
    'einecs',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ecNumberMeta = const VerificationMeta(
    'ecNumber',
  );
  @override
  late final GeneratedColumn<String> ecNumber = GeneratedColumn<String>(
    'ec_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _femaMeta = const VerificationMeta('fema');
  @override
  late final GeneratedColumn<String> fema = GeneratedColumn<String>(
    'fema',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jecfaMeta = const VerificationMeta('jecfa');
  @override
  late final GeneratedColumn<String> jecfa = GeneratedColumn<String>(
    'jecfa',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flavisMeta = const VerificationMeta('flavis');
  @override
  late final GeneratedColumn<String> flavis = GeneratedColumn<String>(
    'flavis',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iupacNameMeta = const VerificationMeta(
    'iupacName',
  );
  @override
  late final GeneratedColumn<String> iupacName = GeneratedColumn<String>(
    'iupac_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _botanicalNameMeta = const VerificationMeta(
    'botanicalName',
  );
  @override
  late final GeneratedColumn<String> botanicalName = GeneratedColumn<String>(
    'botanical_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pyramidNoteMeta = const VerificationMeta(
    'pyramidNote',
  );
  @override
  late final GeneratedColumn<String> pyramidNote = GeneratedColumn<String>(
    'pyramid_note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('heart'),
  );
  static const VerificationMeta _categoriesJsonMeta = const VerificationMeta(
    'categoriesJson',
  );
  @override
  late final GeneratedColumn<String> categoriesJson = GeneratedColumn<String>(
    'categories_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _odorProfilesJsonMeta = const VerificationMeta(
    'odorProfilesJson',
  );
  @override
  late final GeneratedColumn<String> odorProfilesJson = GeneratedColumn<String>(
    'odor_profiles_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _densityMeta = const VerificationMeta(
    'density',
  );
  @override
  late final GeneratedColumn<double> density = GeneratedColumn<double>(
    'density',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dilutionPercentMeta = const VerificationMeta(
    'dilutionPercent',
  );
  @override
  late final GeneratedColumn<double> dilutionPercent = GeneratedColumn<double>(
    'dilution_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(100.0),
  );
  static const VerificationMeta _defaultSolventMeta = const VerificationMeta(
    'defaultSolvent',
  );
  @override
  late final GeneratedColumn<String> defaultSolvent = GeneratedColumn<String>(
    'default_solvent',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intensityMeta = const VerificationMeta(
    'intensity',
  );
  @override
  late final GeneratedColumn<int> intensity = GeneratedColumn<int>(
    'intensity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _relativeImpactMeta = const VerificationMeta(
    'relativeImpact',
  );
  @override
  late final GeneratedColumn<double> relativeImpact = GeneratedColumn<double>(
    'relative_impact',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _odorLifeMeta = const VerificationMeta(
    'odorLife',
  );
  @override
  late final GeneratedColumn<String> odorLife = GeneratedColumn<String>(
    'odor_life',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idealMaxPercentMeta = const VerificationMeta(
    'idealMaxPercent',
  );
  @override
  late final GeneratedColumn<double> idealMaxPercent = GeneratedColumn<double>(
    'ideal_max_percent',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _molecularWeightMeta = const VerificationMeta(
    'molecularWeight',
  );
  @override
  late final GeneratedColumn<String> molecularWeight = GeneratedColumn<String>(
    'molecular_weight',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _molecularFormulaMeta = const VerificationMeta(
    'molecularFormula',
  );
  @override
  late final GeneratedColumn<String> molecularFormula = GeneratedColumn<String>(
    'molecular_formula',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flashPointMeta = const VerificationMeta(
    'flashPoint',
  );
  @override
  late final GeneratedColumn<String> flashPoint = GeneratedColumn<String>(
    'flash_point',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _boilingPointMeta = const VerificationMeta(
    'boilingPoint',
  );
  @override
  late final GeneratedColumn<String> boilingPoint = GeneratedColumn<String>(
    'boiling_point',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _meltingPointMeta = const VerificationMeta(
    'meltingPoint',
  );
  @override
  late final GeneratedColumn<String> meltingPoint = GeneratedColumn<String>(
    'melting_point',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _logPMeta = const VerificationMeta('logP');
  @override
  late final GeneratedColumn<String> logP = GeneratedColumn<String>(
    'log_p',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vaporPressureMeta = const VerificationMeta(
    'vaporPressure',
  );
  @override
  late final GeneratedColumn<String> vaporPressure = GeneratedColumn<String>(
    'vapor_pressure',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _biodegradabilityMeta = const VerificationMeta(
    'biodegradability',
  );
  @override
  late final GeneratedColumn<String> biodegradability = GeneratedColumn<String>(
    'biodegradability',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _renewableCarbonPercentMeta =
      const VerificationMeta('renewableCarbonPercent');
  @override
  late final GeneratedColumn<double> renewableCarbonPercent =
      GeneratedColumn<double>(
        'renewable_carbon_percent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _hazardPictogramsJsonMeta =
      const VerificationMeta('hazardPictogramsJson');
  @override
  late final GeneratedColumn<String> hazardPictogramsJson =
      GeneratedColumn<String>(
        'hazard_pictograms_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _tgscUrlMeta = const VerificationMeta(
    'tgscUrl',
  );
  @override
  late final GeneratedColumn<String> tgscUrl = GeneratedColumn<String>(
    'tgsc_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pubchemCidMeta = const VerificationMeta(
    'pubchemCid',
  );
  @override
  late final GeneratedColumn<String> pubchemCid = GeneratedColumn<String>(
    'pubchem_cid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scentreeUrlMeta = const VerificationMeta(
    'scentreeUrl',
  );
  @override
  late final GeneratedColumn<String> scentreeUrl = GeneratedColumn<String>(
    'scentree_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wikipediaUrlMeta = const VerificationMeta(
    'wikipediaUrl',
  );
  @override
  late final GeneratedColumn<String> wikipediaUrl = GeneratedColumn<String>(
    'wikipedia_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockGramsMeta = const VerificationMeta(
    'stockGrams',
  );
  @override
  late final GeneratedColumn<double> stockGrams = GeneratedColumn<double>(
    'stock_grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _costPerGramMeta = const VerificationMeta(
    'costPerGram',
  );
  @override
  late final GeneratedColumn<double> costPerGram = GeneratedColumn<double>(
    'cost_per_gram',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    casNumber,
    secondaryCas,
    einecs,
    ecNumber,
    fema,
    jecfa,
    flavis,
    iupacName,
    botanicalName,
    imageUrl,
    description,
    pyramidNote,
    categoriesJson,
    odorProfilesJson,
    density,
    dilutionPercent,
    defaultSolvent,
    intensity,
    relativeImpact,
    odorLife,
    idealMaxPercent,
    molecularWeight,
    molecularFormula,
    flashPoint,
    boilingPoint,
    meltingPoint,
    logP,
    vaporPressure,
    biodegradability,
    renewableCarbonPercent,
    hazardPictogramsJson,
    tgscUrl,
    pubchemCid,
    scentreeUrl,
    wikipediaUrl,
    stockGrams,
    costPerGram,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'materials';
  @override
  VerificationContext validateIntegrity(
    Insertable<Material> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('cas_number')) {
      context.handle(
        _casNumberMeta,
        casNumber.isAcceptableOrUnknown(data['cas_number']!, _casNumberMeta),
      );
    }
    if (data.containsKey('secondary_cas')) {
      context.handle(
        _secondaryCasMeta,
        secondaryCas.isAcceptableOrUnknown(
          data['secondary_cas']!,
          _secondaryCasMeta,
        ),
      );
    }
    if (data.containsKey('einecs')) {
      context.handle(
        _einecsMeta,
        einecs.isAcceptableOrUnknown(data['einecs']!, _einecsMeta),
      );
    }
    if (data.containsKey('ec_number')) {
      context.handle(
        _ecNumberMeta,
        ecNumber.isAcceptableOrUnknown(data['ec_number']!, _ecNumberMeta),
      );
    }
    if (data.containsKey('fema')) {
      context.handle(
        _femaMeta,
        fema.isAcceptableOrUnknown(data['fema']!, _femaMeta),
      );
    }
    if (data.containsKey('jecfa')) {
      context.handle(
        _jecfaMeta,
        jecfa.isAcceptableOrUnknown(data['jecfa']!, _jecfaMeta),
      );
    }
    if (data.containsKey('flavis')) {
      context.handle(
        _flavisMeta,
        flavis.isAcceptableOrUnknown(data['flavis']!, _flavisMeta),
      );
    }
    if (data.containsKey('iupac_name')) {
      context.handle(
        _iupacNameMeta,
        iupacName.isAcceptableOrUnknown(data['iupac_name']!, _iupacNameMeta),
      );
    }
    if (data.containsKey('botanical_name')) {
      context.handle(
        _botanicalNameMeta,
        botanicalName.isAcceptableOrUnknown(
          data['botanical_name']!,
          _botanicalNameMeta,
        ),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('pyramid_note')) {
      context.handle(
        _pyramidNoteMeta,
        pyramidNote.isAcceptableOrUnknown(
          data['pyramid_note']!,
          _pyramidNoteMeta,
        ),
      );
    }
    if (data.containsKey('categories_json')) {
      context.handle(
        _categoriesJsonMeta,
        categoriesJson.isAcceptableOrUnknown(
          data['categories_json']!,
          _categoriesJsonMeta,
        ),
      );
    }
    if (data.containsKey('odor_profiles_json')) {
      context.handle(
        _odorProfilesJsonMeta,
        odorProfilesJson.isAcceptableOrUnknown(
          data['odor_profiles_json']!,
          _odorProfilesJsonMeta,
        ),
      );
    }
    if (data.containsKey('density')) {
      context.handle(
        _densityMeta,
        density.isAcceptableOrUnknown(data['density']!, _densityMeta),
      );
    }
    if (data.containsKey('dilution_percent')) {
      context.handle(
        _dilutionPercentMeta,
        dilutionPercent.isAcceptableOrUnknown(
          data['dilution_percent']!,
          _dilutionPercentMeta,
        ),
      );
    }
    if (data.containsKey('default_solvent')) {
      context.handle(
        _defaultSolventMeta,
        defaultSolvent.isAcceptableOrUnknown(
          data['default_solvent']!,
          _defaultSolventMeta,
        ),
      );
    }
    if (data.containsKey('intensity')) {
      context.handle(
        _intensityMeta,
        intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta),
      );
    }
    if (data.containsKey('relative_impact')) {
      context.handle(
        _relativeImpactMeta,
        relativeImpact.isAcceptableOrUnknown(
          data['relative_impact']!,
          _relativeImpactMeta,
        ),
      );
    }
    if (data.containsKey('odor_life')) {
      context.handle(
        _odorLifeMeta,
        odorLife.isAcceptableOrUnknown(data['odor_life']!, _odorLifeMeta),
      );
    }
    if (data.containsKey('ideal_max_percent')) {
      context.handle(
        _idealMaxPercentMeta,
        idealMaxPercent.isAcceptableOrUnknown(
          data['ideal_max_percent']!,
          _idealMaxPercentMeta,
        ),
      );
    }
    if (data.containsKey('molecular_weight')) {
      context.handle(
        _molecularWeightMeta,
        molecularWeight.isAcceptableOrUnknown(
          data['molecular_weight']!,
          _molecularWeightMeta,
        ),
      );
    }
    if (data.containsKey('molecular_formula')) {
      context.handle(
        _molecularFormulaMeta,
        molecularFormula.isAcceptableOrUnknown(
          data['molecular_formula']!,
          _molecularFormulaMeta,
        ),
      );
    }
    if (data.containsKey('flash_point')) {
      context.handle(
        _flashPointMeta,
        flashPoint.isAcceptableOrUnknown(data['flash_point']!, _flashPointMeta),
      );
    }
    if (data.containsKey('boiling_point')) {
      context.handle(
        _boilingPointMeta,
        boilingPoint.isAcceptableOrUnknown(
          data['boiling_point']!,
          _boilingPointMeta,
        ),
      );
    }
    if (data.containsKey('melting_point')) {
      context.handle(
        _meltingPointMeta,
        meltingPoint.isAcceptableOrUnknown(
          data['melting_point']!,
          _meltingPointMeta,
        ),
      );
    }
    if (data.containsKey('log_p')) {
      context.handle(
        _logPMeta,
        logP.isAcceptableOrUnknown(data['log_p']!, _logPMeta),
      );
    }
    if (data.containsKey('vapor_pressure')) {
      context.handle(
        _vaporPressureMeta,
        vaporPressure.isAcceptableOrUnknown(
          data['vapor_pressure']!,
          _vaporPressureMeta,
        ),
      );
    }
    if (data.containsKey('biodegradability')) {
      context.handle(
        _biodegradabilityMeta,
        biodegradability.isAcceptableOrUnknown(
          data['biodegradability']!,
          _biodegradabilityMeta,
        ),
      );
    }
    if (data.containsKey('renewable_carbon_percent')) {
      context.handle(
        _renewableCarbonPercentMeta,
        renewableCarbonPercent.isAcceptableOrUnknown(
          data['renewable_carbon_percent']!,
          _renewableCarbonPercentMeta,
        ),
      );
    }
    if (data.containsKey('hazard_pictograms_json')) {
      context.handle(
        _hazardPictogramsJsonMeta,
        hazardPictogramsJson.isAcceptableOrUnknown(
          data['hazard_pictograms_json']!,
          _hazardPictogramsJsonMeta,
        ),
      );
    }
    if (data.containsKey('tgsc_url')) {
      context.handle(
        _tgscUrlMeta,
        tgscUrl.isAcceptableOrUnknown(data['tgsc_url']!, _tgscUrlMeta),
      );
    }
    if (data.containsKey('pubchem_cid')) {
      context.handle(
        _pubchemCidMeta,
        pubchemCid.isAcceptableOrUnknown(data['pubchem_cid']!, _pubchemCidMeta),
      );
    }
    if (data.containsKey('scentree_url')) {
      context.handle(
        _scentreeUrlMeta,
        scentreeUrl.isAcceptableOrUnknown(
          data['scentree_url']!,
          _scentreeUrlMeta,
        ),
      );
    }
    if (data.containsKey('wikipedia_url')) {
      context.handle(
        _wikipediaUrlMeta,
        wikipediaUrl.isAcceptableOrUnknown(
          data['wikipedia_url']!,
          _wikipediaUrlMeta,
        ),
      );
    }
    if (data.containsKey('stock_grams')) {
      context.handle(
        _stockGramsMeta,
        stockGrams.isAcceptableOrUnknown(data['stock_grams']!, _stockGramsMeta),
      );
    }
    if (data.containsKey('cost_per_gram')) {
      context.handle(
        _costPerGramMeta,
        costPerGram.isAcceptableOrUnknown(
          data['cost_per_gram']!,
          _costPerGramMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Material map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Material(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      casNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cas_number'],
      ),
      secondaryCas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_cas'],
      ),
      einecs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}einecs'],
      ),
      ecNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ec_number'],
      ),
      fema: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fema'],
      ),
      jecfa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jecfa'],
      ),
      flavis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flavis'],
      ),
      iupacName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}iupac_name'],
      ),
      botanicalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}botanical_name'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      pyramidNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pyramid_note'],
      )!,
      categoriesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categories_json'],
      )!,
      odorProfilesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}odor_profiles_json'],
      )!,
      density: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}density'],
      ),
      dilutionPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dilution_percent'],
      )!,
      defaultSolvent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_solvent'],
      ),
      intensity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intensity'],
      )!,
      relativeImpact: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}relative_impact'],
      ),
      odorLife: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}odor_life'],
      ),
      idealMaxPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ideal_max_percent'],
      ),
      molecularWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}molecular_weight'],
      ),
      molecularFormula: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}molecular_formula'],
      ),
      flashPoint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flash_point'],
      ),
      boilingPoint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}boiling_point'],
      ),
      meltingPoint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}melting_point'],
      ),
      logP: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}log_p'],
      ),
      vaporPressure: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vapor_pressure'],
      ),
      biodegradability: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}biodegradability'],
      ),
      renewableCarbonPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}renewable_carbon_percent'],
      ),
      hazardPictogramsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hazard_pictograms_json'],
      )!,
      tgscUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tgsc_url'],
      ),
      pubchemCid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pubchem_cid'],
      ),
      scentreeUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scentree_url'],
      ),
      wikipediaUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wikipedia_url'],
      ),
      stockGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_grams'],
      )!,
      costPerGram: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_per_gram'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MaterialsTable createAlias(String alias) {
    return $MaterialsTable(attachedDatabase, alias);
  }
}

class Material extends DataClass implements Insertable<Material> {
  final String id;
  final String name;
  final String? casNumber;
  final String? secondaryCas;
  final String? einecs;
  final String? ecNumber;
  final String? fema;
  final String? jecfa;
  final String? flavis;
  final String? iupacName;
  final String? botanicalName;
  final String? imageUrl;
  final String? description;
  final String pyramidNote;
  final String categoriesJson;
  final String odorProfilesJson;
  final double? density;
  final double dilutionPercent;
  final String? defaultSolvent;
  final int intensity;
  final double? relativeImpact;
  final String? odorLife;
  final double? idealMaxPercent;
  final String? molecularWeight;
  final String? molecularFormula;
  final String? flashPoint;
  final String? boilingPoint;
  final String? meltingPoint;
  final String? logP;
  final String? vaporPressure;
  final String? biodegradability;
  final double? renewableCarbonPercent;
  final String hazardPictogramsJson;
  final String? tgscUrl;
  final String? pubchemCid;
  final String? scentreeUrl;
  final String? wikipediaUrl;
  final double stockGrams;
  final double costPerGram;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Material({
    required this.id,
    required this.name,
    this.casNumber,
    this.secondaryCas,
    this.einecs,
    this.ecNumber,
    this.fema,
    this.jecfa,
    this.flavis,
    this.iupacName,
    this.botanicalName,
    this.imageUrl,
    this.description,
    required this.pyramidNote,
    required this.categoriesJson,
    required this.odorProfilesJson,
    this.density,
    required this.dilutionPercent,
    this.defaultSolvent,
    required this.intensity,
    this.relativeImpact,
    this.odorLife,
    this.idealMaxPercent,
    this.molecularWeight,
    this.molecularFormula,
    this.flashPoint,
    this.boilingPoint,
    this.meltingPoint,
    this.logP,
    this.vaporPressure,
    this.biodegradability,
    this.renewableCarbonPercent,
    required this.hazardPictogramsJson,
    this.tgscUrl,
    this.pubchemCid,
    this.scentreeUrl,
    this.wikipediaUrl,
    required this.stockGrams,
    required this.costPerGram,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || casNumber != null) {
      map['cas_number'] = Variable<String>(casNumber);
    }
    if (!nullToAbsent || secondaryCas != null) {
      map['secondary_cas'] = Variable<String>(secondaryCas);
    }
    if (!nullToAbsent || einecs != null) {
      map['einecs'] = Variable<String>(einecs);
    }
    if (!nullToAbsent || ecNumber != null) {
      map['ec_number'] = Variable<String>(ecNumber);
    }
    if (!nullToAbsent || fema != null) {
      map['fema'] = Variable<String>(fema);
    }
    if (!nullToAbsent || jecfa != null) {
      map['jecfa'] = Variable<String>(jecfa);
    }
    if (!nullToAbsent || flavis != null) {
      map['flavis'] = Variable<String>(flavis);
    }
    if (!nullToAbsent || iupacName != null) {
      map['iupac_name'] = Variable<String>(iupacName);
    }
    if (!nullToAbsent || botanicalName != null) {
      map['botanical_name'] = Variable<String>(botanicalName);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['pyramid_note'] = Variable<String>(pyramidNote);
    map['categories_json'] = Variable<String>(categoriesJson);
    map['odor_profiles_json'] = Variable<String>(odorProfilesJson);
    if (!nullToAbsent || density != null) {
      map['density'] = Variable<double>(density);
    }
    map['dilution_percent'] = Variable<double>(dilutionPercent);
    if (!nullToAbsent || defaultSolvent != null) {
      map['default_solvent'] = Variable<String>(defaultSolvent);
    }
    map['intensity'] = Variable<int>(intensity);
    if (!nullToAbsent || relativeImpact != null) {
      map['relative_impact'] = Variable<double>(relativeImpact);
    }
    if (!nullToAbsent || odorLife != null) {
      map['odor_life'] = Variable<String>(odorLife);
    }
    if (!nullToAbsent || idealMaxPercent != null) {
      map['ideal_max_percent'] = Variable<double>(idealMaxPercent);
    }
    if (!nullToAbsent || molecularWeight != null) {
      map['molecular_weight'] = Variable<String>(molecularWeight);
    }
    if (!nullToAbsent || molecularFormula != null) {
      map['molecular_formula'] = Variable<String>(molecularFormula);
    }
    if (!nullToAbsent || flashPoint != null) {
      map['flash_point'] = Variable<String>(flashPoint);
    }
    if (!nullToAbsent || boilingPoint != null) {
      map['boiling_point'] = Variable<String>(boilingPoint);
    }
    if (!nullToAbsent || meltingPoint != null) {
      map['melting_point'] = Variable<String>(meltingPoint);
    }
    if (!nullToAbsent || logP != null) {
      map['log_p'] = Variable<String>(logP);
    }
    if (!nullToAbsent || vaporPressure != null) {
      map['vapor_pressure'] = Variable<String>(vaporPressure);
    }
    if (!nullToAbsent || biodegradability != null) {
      map['biodegradability'] = Variable<String>(biodegradability);
    }
    if (!nullToAbsent || renewableCarbonPercent != null) {
      map['renewable_carbon_percent'] = Variable<double>(
        renewableCarbonPercent,
      );
    }
    map['hazard_pictograms_json'] = Variable<String>(hazardPictogramsJson);
    if (!nullToAbsent || tgscUrl != null) {
      map['tgsc_url'] = Variable<String>(tgscUrl);
    }
    if (!nullToAbsent || pubchemCid != null) {
      map['pubchem_cid'] = Variable<String>(pubchemCid);
    }
    if (!nullToAbsent || scentreeUrl != null) {
      map['scentree_url'] = Variable<String>(scentreeUrl);
    }
    if (!nullToAbsent || wikipediaUrl != null) {
      map['wikipedia_url'] = Variable<String>(wikipediaUrl);
    }
    map['stock_grams'] = Variable<double>(stockGrams);
    map['cost_per_gram'] = Variable<double>(costPerGram);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MaterialsCompanion toCompanion(bool nullToAbsent) {
    return MaterialsCompanion(
      id: Value(id),
      name: Value(name),
      casNumber: casNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(casNumber),
      secondaryCas: secondaryCas == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryCas),
      einecs: einecs == null && nullToAbsent
          ? const Value.absent()
          : Value(einecs),
      ecNumber: ecNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(ecNumber),
      fema: fema == null && nullToAbsent ? const Value.absent() : Value(fema),
      jecfa: jecfa == null && nullToAbsent
          ? const Value.absent()
          : Value(jecfa),
      flavis: flavis == null && nullToAbsent
          ? const Value.absent()
          : Value(flavis),
      iupacName: iupacName == null && nullToAbsent
          ? const Value.absent()
          : Value(iupacName),
      botanicalName: botanicalName == null && nullToAbsent
          ? const Value.absent()
          : Value(botanicalName),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      pyramidNote: Value(pyramidNote),
      categoriesJson: Value(categoriesJson),
      odorProfilesJson: Value(odorProfilesJson),
      density: density == null && nullToAbsent
          ? const Value.absent()
          : Value(density),
      dilutionPercent: Value(dilutionPercent),
      defaultSolvent: defaultSolvent == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultSolvent),
      intensity: Value(intensity),
      relativeImpact: relativeImpact == null && nullToAbsent
          ? const Value.absent()
          : Value(relativeImpact),
      odorLife: odorLife == null && nullToAbsent
          ? const Value.absent()
          : Value(odorLife),
      idealMaxPercent: idealMaxPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(idealMaxPercent),
      molecularWeight: molecularWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(molecularWeight),
      molecularFormula: molecularFormula == null && nullToAbsent
          ? const Value.absent()
          : Value(molecularFormula),
      flashPoint: flashPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(flashPoint),
      boilingPoint: boilingPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(boilingPoint),
      meltingPoint: meltingPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(meltingPoint),
      logP: logP == null && nullToAbsent ? const Value.absent() : Value(logP),
      vaporPressure: vaporPressure == null && nullToAbsent
          ? const Value.absent()
          : Value(vaporPressure),
      biodegradability: biodegradability == null && nullToAbsent
          ? const Value.absent()
          : Value(biodegradability),
      renewableCarbonPercent: renewableCarbonPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(renewableCarbonPercent),
      hazardPictogramsJson: Value(hazardPictogramsJson),
      tgscUrl: tgscUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(tgscUrl),
      pubchemCid: pubchemCid == null && nullToAbsent
          ? const Value.absent()
          : Value(pubchemCid),
      scentreeUrl: scentreeUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(scentreeUrl),
      wikipediaUrl: wikipediaUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(wikipediaUrl),
      stockGrams: Value(stockGrams),
      costPerGram: Value(costPerGram),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Material.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Material(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      casNumber: serializer.fromJson<String?>(json['casNumber']),
      secondaryCas: serializer.fromJson<String?>(json['secondaryCas']),
      einecs: serializer.fromJson<String?>(json['einecs']),
      ecNumber: serializer.fromJson<String?>(json['ecNumber']),
      fema: serializer.fromJson<String?>(json['fema']),
      jecfa: serializer.fromJson<String?>(json['jecfa']),
      flavis: serializer.fromJson<String?>(json['flavis']),
      iupacName: serializer.fromJson<String?>(json['iupacName']),
      botanicalName: serializer.fromJson<String?>(json['botanicalName']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      description: serializer.fromJson<String?>(json['description']),
      pyramidNote: serializer.fromJson<String>(json['pyramidNote']),
      categoriesJson: serializer.fromJson<String>(json['categoriesJson']),
      odorProfilesJson: serializer.fromJson<String>(json['odorProfilesJson']),
      density: serializer.fromJson<double?>(json['density']),
      dilutionPercent: serializer.fromJson<double>(json['dilutionPercent']),
      defaultSolvent: serializer.fromJson<String?>(json['defaultSolvent']),
      intensity: serializer.fromJson<int>(json['intensity']),
      relativeImpact: serializer.fromJson<double?>(json['relativeImpact']),
      odorLife: serializer.fromJson<String?>(json['odorLife']),
      idealMaxPercent: serializer.fromJson<double?>(json['idealMaxPercent']),
      molecularWeight: serializer.fromJson<String?>(json['molecularWeight']),
      molecularFormula: serializer.fromJson<String?>(json['molecularFormula']),
      flashPoint: serializer.fromJson<String?>(json['flashPoint']),
      boilingPoint: serializer.fromJson<String?>(json['boilingPoint']),
      meltingPoint: serializer.fromJson<String?>(json['meltingPoint']),
      logP: serializer.fromJson<String?>(json['logP']),
      vaporPressure: serializer.fromJson<String?>(json['vaporPressure']),
      biodegradability: serializer.fromJson<String?>(json['biodegradability']),
      renewableCarbonPercent: serializer.fromJson<double?>(
        json['renewableCarbonPercent'],
      ),
      hazardPictogramsJson: serializer.fromJson<String>(
        json['hazardPictogramsJson'],
      ),
      tgscUrl: serializer.fromJson<String?>(json['tgscUrl']),
      pubchemCid: serializer.fromJson<String?>(json['pubchemCid']),
      scentreeUrl: serializer.fromJson<String?>(json['scentreeUrl']),
      wikipediaUrl: serializer.fromJson<String?>(json['wikipediaUrl']),
      stockGrams: serializer.fromJson<double>(json['stockGrams']),
      costPerGram: serializer.fromJson<double>(json['costPerGram']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'casNumber': serializer.toJson<String?>(casNumber),
      'secondaryCas': serializer.toJson<String?>(secondaryCas),
      'einecs': serializer.toJson<String?>(einecs),
      'ecNumber': serializer.toJson<String?>(ecNumber),
      'fema': serializer.toJson<String?>(fema),
      'jecfa': serializer.toJson<String?>(jecfa),
      'flavis': serializer.toJson<String?>(flavis),
      'iupacName': serializer.toJson<String?>(iupacName),
      'botanicalName': serializer.toJson<String?>(botanicalName),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'description': serializer.toJson<String?>(description),
      'pyramidNote': serializer.toJson<String>(pyramidNote),
      'categoriesJson': serializer.toJson<String>(categoriesJson),
      'odorProfilesJson': serializer.toJson<String>(odorProfilesJson),
      'density': serializer.toJson<double?>(density),
      'dilutionPercent': serializer.toJson<double>(dilutionPercent),
      'defaultSolvent': serializer.toJson<String?>(defaultSolvent),
      'intensity': serializer.toJson<int>(intensity),
      'relativeImpact': serializer.toJson<double?>(relativeImpact),
      'odorLife': serializer.toJson<String?>(odorLife),
      'idealMaxPercent': serializer.toJson<double?>(idealMaxPercent),
      'molecularWeight': serializer.toJson<String?>(molecularWeight),
      'molecularFormula': serializer.toJson<String?>(molecularFormula),
      'flashPoint': serializer.toJson<String?>(flashPoint),
      'boilingPoint': serializer.toJson<String?>(boilingPoint),
      'meltingPoint': serializer.toJson<String?>(meltingPoint),
      'logP': serializer.toJson<String?>(logP),
      'vaporPressure': serializer.toJson<String?>(vaporPressure),
      'biodegradability': serializer.toJson<String?>(biodegradability),
      'renewableCarbonPercent': serializer.toJson<double?>(
        renewableCarbonPercent,
      ),
      'hazardPictogramsJson': serializer.toJson<String>(hazardPictogramsJson),
      'tgscUrl': serializer.toJson<String?>(tgscUrl),
      'pubchemCid': serializer.toJson<String?>(pubchemCid),
      'scentreeUrl': serializer.toJson<String?>(scentreeUrl),
      'wikipediaUrl': serializer.toJson<String?>(wikipediaUrl),
      'stockGrams': serializer.toJson<double>(stockGrams),
      'costPerGram': serializer.toJson<double>(costPerGram),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Material copyWith({
    String? id,
    String? name,
    Value<String?> casNumber = const Value.absent(),
    Value<String?> secondaryCas = const Value.absent(),
    Value<String?> einecs = const Value.absent(),
    Value<String?> ecNumber = const Value.absent(),
    Value<String?> fema = const Value.absent(),
    Value<String?> jecfa = const Value.absent(),
    Value<String?> flavis = const Value.absent(),
    Value<String?> iupacName = const Value.absent(),
    Value<String?> botanicalName = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? pyramidNote,
    String? categoriesJson,
    String? odorProfilesJson,
    Value<double?> density = const Value.absent(),
    double? dilutionPercent,
    Value<String?> defaultSolvent = const Value.absent(),
    int? intensity,
    Value<double?> relativeImpact = const Value.absent(),
    Value<String?> odorLife = const Value.absent(),
    Value<double?> idealMaxPercent = const Value.absent(),
    Value<String?> molecularWeight = const Value.absent(),
    Value<String?> molecularFormula = const Value.absent(),
    Value<String?> flashPoint = const Value.absent(),
    Value<String?> boilingPoint = const Value.absent(),
    Value<String?> meltingPoint = const Value.absent(),
    Value<String?> logP = const Value.absent(),
    Value<String?> vaporPressure = const Value.absent(),
    Value<String?> biodegradability = const Value.absent(),
    Value<double?> renewableCarbonPercent = const Value.absent(),
    String? hazardPictogramsJson,
    Value<String?> tgscUrl = const Value.absent(),
    Value<String?> pubchemCid = const Value.absent(),
    Value<String?> scentreeUrl = const Value.absent(),
    Value<String?> wikipediaUrl = const Value.absent(),
    double? stockGrams,
    double? costPerGram,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Material(
    id: id ?? this.id,
    name: name ?? this.name,
    casNumber: casNumber.present ? casNumber.value : this.casNumber,
    secondaryCas: secondaryCas.present ? secondaryCas.value : this.secondaryCas,
    einecs: einecs.present ? einecs.value : this.einecs,
    ecNumber: ecNumber.present ? ecNumber.value : this.ecNumber,
    fema: fema.present ? fema.value : this.fema,
    jecfa: jecfa.present ? jecfa.value : this.jecfa,
    flavis: flavis.present ? flavis.value : this.flavis,
    iupacName: iupacName.present ? iupacName.value : this.iupacName,
    botanicalName: botanicalName.present
        ? botanicalName.value
        : this.botanicalName,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    description: description.present ? description.value : this.description,
    pyramidNote: pyramidNote ?? this.pyramidNote,
    categoriesJson: categoriesJson ?? this.categoriesJson,
    odorProfilesJson: odorProfilesJson ?? this.odorProfilesJson,
    density: density.present ? density.value : this.density,
    dilutionPercent: dilutionPercent ?? this.dilutionPercent,
    defaultSolvent: defaultSolvent.present
        ? defaultSolvent.value
        : this.defaultSolvent,
    intensity: intensity ?? this.intensity,
    relativeImpact: relativeImpact.present
        ? relativeImpact.value
        : this.relativeImpact,
    odorLife: odorLife.present ? odorLife.value : this.odorLife,
    idealMaxPercent: idealMaxPercent.present
        ? idealMaxPercent.value
        : this.idealMaxPercent,
    molecularWeight: molecularWeight.present
        ? molecularWeight.value
        : this.molecularWeight,
    molecularFormula: molecularFormula.present
        ? molecularFormula.value
        : this.molecularFormula,
    flashPoint: flashPoint.present ? flashPoint.value : this.flashPoint,
    boilingPoint: boilingPoint.present ? boilingPoint.value : this.boilingPoint,
    meltingPoint: meltingPoint.present ? meltingPoint.value : this.meltingPoint,
    logP: logP.present ? logP.value : this.logP,
    vaporPressure: vaporPressure.present
        ? vaporPressure.value
        : this.vaporPressure,
    biodegradability: biodegradability.present
        ? biodegradability.value
        : this.biodegradability,
    renewableCarbonPercent: renewableCarbonPercent.present
        ? renewableCarbonPercent.value
        : this.renewableCarbonPercent,
    hazardPictogramsJson: hazardPictogramsJson ?? this.hazardPictogramsJson,
    tgscUrl: tgscUrl.present ? tgscUrl.value : this.tgscUrl,
    pubchemCid: pubchemCid.present ? pubchemCid.value : this.pubchemCid,
    scentreeUrl: scentreeUrl.present ? scentreeUrl.value : this.scentreeUrl,
    wikipediaUrl: wikipediaUrl.present ? wikipediaUrl.value : this.wikipediaUrl,
    stockGrams: stockGrams ?? this.stockGrams,
    costPerGram: costPerGram ?? this.costPerGram,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Material copyWithCompanion(MaterialsCompanion data) {
    return Material(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      casNumber: data.casNumber.present ? data.casNumber.value : this.casNumber,
      secondaryCas: data.secondaryCas.present
          ? data.secondaryCas.value
          : this.secondaryCas,
      einecs: data.einecs.present ? data.einecs.value : this.einecs,
      ecNumber: data.ecNumber.present ? data.ecNumber.value : this.ecNumber,
      fema: data.fema.present ? data.fema.value : this.fema,
      jecfa: data.jecfa.present ? data.jecfa.value : this.jecfa,
      flavis: data.flavis.present ? data.flavis.value : this.flavis,
      iupacName: data.iupacName.present ? data.iupacName.value : this.iupacName,
      botanicalName: data.botanicalName.present
          ? data.botanicalName.value
          : this.botanicalName,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      description: data.description.present
          ? data.description.value
          : this.description,
      pyramidNote: data.pyramidNote.present
          ? data.pyramidNote.value
          : this.pyramidNote,
      categoriesJson: data.categoriesJson.present
          ? data.categoriesJson.value
          : this.categoriesJson,
      odorProfilesJson: data.odorProfilesJson.present
          ? data.odorProfilesJson.value
          : this.odorProfilesJson,
      density: data.density.present ? data.density.value : this.density,
      dilutionPercent: data.dilutionPercent.present
          ? data.dilutionPercent.value
          : this.dilutionPercent,
      defaultSolvent: data.defaultSolvent.present
          ? data.defaultSolvent.value
          : this.defaultSolvent,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      relativeImpact: data.relativeImpact.present
          ? data.relativeImpact.value
          : this.relativeImpact,
      odorLife: data.odorLife.present ? data.odorLife.value : this.odorLife,
      idealMaxPercent: data.idealMaxPercent.present
          ? data.idealMaxPercent.value
          : this.idealMaxPercent,
      molecularWeight: data.molecularWeight.present
          ? data.molecularWeight.value
          : this.molecularWeight,
      molecularFormula: data.molecularFormula.present
          ? data.molecularFormula.value
          : this.molecularFormula,
      flashPoint: data.flashPoint.present
          ? data.flashPoint.value
          : this.flashPoint,
      boilingPoint: data.boilingPoint.present
          ? data.boilingPoint.value
          : this.boilingPoint,
      meltingPoint: data.meltingPoint.present
          ? data.meltingPoint.value
          : this.meltingPoint,
      logP: data.logP.present ? data.logP.value : this.logP,
      vaporPressure: data.vaporPressure.present
          ? data.vaporPressure.value
          : this.vaporPressure,
      biodegradability: data.biodegradability.present
          ? data.biodegradability.value
          : this.biodegradability,
      renewableCarbonPercent: data.renewableCarbonPercent.present
          ? data.renewableCarbonPercent.value
          : this.renewableCarbonPercent,
      hazardPictogramsJson: data.hazardPictogramsJson.present
          ? data.hazardPictogramsJson.value
          : this.hazardPictogramsJson,
      tgscUrl: data.tgscUrl.present ? data.tgscUrl.value : this.tgscUrl,
      pubchemCid: data.pubchemCid.present
          ? data.pubchemCid.value
          : this.pubchemCid,
      scentreeUrl: data.scentreeUrl.present
          ? data.scentreeUrl.value
          : this.scentreeUrl,
      wikipediaUrl: data.wikipediaUrl.present
          ? data.wikipediaUrl.value
          : this.wikipediaUrl,
      stockGrams: data.stockGrams.present
          ? data.stockGrams.value
          : this.stockGrams,
      costPerGram: data.costPerGram.present
          ? data.costPerGram.value
          : this.costPerGram,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Material(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('casNumber: $casNumber, ')
          ..write('secondaryCas: $secondaryCas, ')
          ..write('einecs: $einecs, ')
          ..write('ecNumber: $ecNumber, ')
          ..write('fema: $fema, ')
          ..write('jecfa: $jecfa, ')
          ..write('flavis: $flavis, ')
          ..write('iupacName: $iupacName, ')
          ..write('botanicalName: $botanicalName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('description: $description, ')
          ..write('pyramidNote: $pyramidNote, ')
          ..write('categoriesJson: $categoriesJson, ')
          ..write('odorProfilesJson: $odorProfilesJson, ')
          ..write('density: $density, ')
          ..write('dilutionPercent: $dilutionPercent, ')
          ..write('defaultSolvent: $defaultSolvent, ')
          ..write('intensity: $intensity, ')
          ..write('relativeImpact: $relativeImpact, ')
          ..write('odorLife: $odorLife, ')
          ..write('idealMaxPercent: $idealMaxPercent, ')
          ..write('molecularWeight: $molecularWeight, ')
          ..write('molecularFormula: $molecularFormula, ')
          ..write('flashPoint: $flashPoint, ')
          ..write('boilingPoint: $boilingPoint, ')
          ..write('meltingPoint: $meltingPoint, ')
          ..write('logP: $logP, ')
          ..write('vaporPressure: $vaporPressure, ')
          ..write('biodegradability: $biodegradability, ')
          ..write('renewableCarbonPercent: $renewableCarbonPercent, ')
          ..write('hazardPictogramsJson: $hazardPictogramsJson, ')
          ..write('tgscUrl: $tgscUrl, ')
          ..write('pubchemCid: $pubchemCid, ')
          ..write('scentreeUrl: $scentreeUrl, ')
          ..write('wikipediaUrl: $wikipediaUrl, ')
          ..write('stockGrams: $stockGrams, ')
          ..write('costPerGram: $costPerGram, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    casNumber,
    secondaryCas,
    einecs,
    ecNumber,
    fema,
    jecfa,
    flavis,
    iupacName,
    botanicalName,
    imageUrl,
    description,
    pyramidNote,
    categoriesJson,
    odorProfilesJson,
    density,
    dilutionPercent,
    defaultSolvent,
    intensity,
    relativeImpact,
    odorLife,
    idealMaxPercent,
    molecularWeight,
    molecularFormula,
    flashPoint,
    boilingPoint,
    meltingPoint,
    logP,
    vaporPressure,
    biodegradability,
    renewableCarbonPercent,
    hazardPictogramsJson,
    tgscUrl,
    pubchemCid,
    scentreeUrl,
    wikipediaUrl,
    stockGrams,
    costPerGram,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Material &&
          other.id == this.id &&
          other.name == this.name &&
          other.casNumber == this.casNumber &&
          other.secondaryCas == this.secondaryCas &&
          other.einecs == this.einecs &&
          other.ecNumber == this.ecNumber &&
          other.fema == this.fema &&
          other.jecfa == this.jecfa &&
          other.flavis == this.flavis &&
          other.iupacName == this.iupacName &&
          other.botanicalName == this.botanicalName &&
          other.imageUrl == this.imageUrl &&
          other.description == this.description &&
          other.pyramidNote == this.pyramidNote &&
          other.categoriesJson == this.categoriesJson &&
          other.odorProfilesJson == this.odorProfilesJson &&
          other.density == this.density &&
          other.dilutionPercent == this.dilutionPercent &&
          other.defaultSolvent == this.defaultSolvent &&
          other.intensity == this.intensity &&
          other.relativeImpact == this.relativeImpact &&
          other.odorLife == this.odorLife &&
          other.idealMaxPercent == this.idealMaxPercent &&
          other.molecularWeight == this.molecularWeight &&
          other.molecularFormula == this.molecularFormula &&
          other.flashPoint == this.flashPoint &&
          other.boilingPoint == this.boilingPoint &&
          other.meltingPoint == this.meltingPoint &&
          other.logP == this.logP &&
          other.vaporPressure == this.vaporPressure &&
          other.biodegradability == this.biodegradability &&
          other.renewableCarbonPercent == this.renewableCarbonPercent &&
          other.hazardPictogramsJson == this.hazardPictogramsJson &&
          other.tgscUrl == this.tgscUrl &&
          other.pubchemCid == this.pubchemCid &&
          other.scentreeUrl == this.scentreeUrl &&
          other.wikipediaUrl == this.wikipediaUrl &&
          other.stockGrams == this.stockGrams &&
          other.costPerGram == this.costPerGram &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MaterialsCompanion extends UpdateCompanion<Material> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> casNumber;
  final Value<String?> secondaryCas;
  final Value<String?> einecs;
  final Value<String?> ecNumber;
  final Value<String?> fema;
  final Value<String?> jecfa;
  final Value<String?> flavis;
  final Value<String?> iupacName;
  final Value<String?> botanicalName;
  final Value<String?> imageUrl;
  final Value<String?> description;
  final Value<String> pyramidNote;
  final Value<String> categoriesJson;
  final Value<String> odorProfilesJson;
  final Value<double?> density;
  final Value<double> dilutionPercent;
  final Value<String?> defaultSolvent;
  final Value<int> intensity;
  final Value<double?> relativeImpact;
  final Value<String?> odorLife;
  final Value<double?> idealMaxPercent;
  final Value<String?> molecularWeight;
  final Value<String?> molecularFormula;
  final Value<String?> flashPoint;
  final Value<String?> boilingPoint;
  final Value<String?> meltingPoint;
  final Value<String?> logP;
  final Value<String?> vaporPressure;
  final Value<String?> biodegradability;
  final Value<double?> renewableCarbonPercent;
  final Value<String> hazardPictogramsJson;
  final Value<String?> tgscUrl;
  final Value<String?> pubchemCid;
  final Value<String?> scentreeUrl;
  final Value<String?> wikipediaUrl;
  final Value<double> stockGrams;
  final Value<double> costPerGram;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MaterialsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.casNumber = const Value.absent(),
    this.secondaryCas = const Value.absent(),
    this.einecs = const Value.absent(),
    this.ecNumber = const Value.absent(),
    this.fema = const Value.absent(),
    this.jecfa = const Value.absent(),
    this.flavis = const Value.absent(),
    this.iupacName = const Value.absent(),
    this.botanicalName = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.pyramidNote = const Value.absent(),
    this.categoriesJson = const Value.absent(),
    this.odorProfilesJson = const Value.absent(),
    this.density = const Value.absent(),
    this.dilutionPercent = const Value.absent(),
    this.defaultSolvent = const Value.absent(),
    this.intensity = const Value.absent(),
    this.relativeImpact = const Value.absent(),
    this.odorLife = const Value.absent(),
    this.idealMaxPercent = const Value.absent(),
    this.molecularWeight = const Value.absent(),
    this.molecularFormula = const Value.absent(),
    this.flashPoint = const Value.absent(),
    this.boilingPoint = const Value.absent(),
    this.meltingPoint = const Value.absent(),
    this.logP = const Value.absent(),
    this.vaporPressure = const Value.absent(),
    this.biodegradability = const Value.absent(),
    this.renewableCarbonPercent = const Value.absent(),
    this.hazardPictogramsJson = const Value.absent(),
    this.tgscUrl = const Value.absent(),
    this.pubchemCid = const Value.absent(),
    this.scentreeUrl = const Value.absent(),
    this.wikipediaUrl = const Value.absent(),
    this.stockGrams = const Value.absent(),
    this.costPerGram = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MaterialsCompanion.insert({
    required String id,
    required String name,
    this.casNumber = const Value.absent(),
    this.secondaryCas = const Value.absent(),
    this.einecs = const Value.absent(),
    this.ecNumber = const Value.absent(),
    this.fema = const Value.absent(),
    this.jecfa = const Value.absent(),
    this.flavis = const Value.absent(),
    this.iupacName = const Value.absent(),
    this.botanicalName = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.pyramidNote = const Value.absent(),
    this.categoriesJson = const Value.absent(),
    this.odorProfilesJson = const Value.absent(),
    this.density = const Value.absent(),
    this.dilutionPercent = const Value.absent(),
    this.defaultSolvent = const Value.absent(),
    this.intensity = const Value.absent(),
    this.relativeImpact = const Value.absent(),
    this.odorLife = const Value.absent(),
    this.idealMaxPercent = const Value.absent(),
    this.molecularWeight = const Value.absent(),
    this.molecularFormula = const Value.absent(),
    this.flashPoint = const Value.absent(),
    this.boilingPoint = const Value.absent(),
    this.meltingPoint = const Value.absent(),
    this.logP = const Value.absent(),
    this.vaporPressure = const Value.absent(),
    this.biodegradability = const Value.absent(),
    this.renewableCarbonPercent = const Value.absent(),
    this.hazardPictogramsJson = const Value.absent(),
    this.tgscUrl = const Value.absent(),
    this.pubchemCid = const Value.absent(),
    this.scentreeUrl = const Value.absent(),
    this.wikipediaUrl = const Value.absent(),
    this.stockGrams = const Value.absent(),
    this.costPerGram = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Material> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? casNumber,
    Expression<String>? secondaryCas,
    Expression<String>? einecs,
    Expression<String>? ecNumber,
    Expression<String>? fema,
    Expression<String>? jecfa,
    Expression<String>? flavis,
    Expression<String>? iupacName,
    Expression<String>? botanicalName,
    Expression<String>? imageUrl,
    Expression<String>? description,
    Expression<String>? pyramidNote,
    Expression<String>? categoriesJson,
    Expression<String>? odorProfilesJson,
    Expression<double>? density,
    Expression<double>? dilutionPercent,
    Expression<String>? defaultSolvent,
    Expression<int>? intensity,
    Expression<double>? relativeImpact,
    Expression<String>? odorLife,
    Expression<double>? idealMaxPercent,
    Expression<String>? molecularWeight,
    Expression<String>? molecularFormula,
    Expression<String>? flashPoint,
    Expression<String>? boilingPoint,
    Expression<String>? meltingPoint,
    Expression<String>? logP,
    Expression<String>? vaporPressure,
    Expression<String>? biodegradability,
    Expression<double>? renewableCarbonPercent,
    Expression<String>? hazardPictogramsJson,
    Expression<String>? tgscUrl,
    Expression<String>? pubchemCid,
    Expression<String>? scentreeUrl,
    Expression<String>? wikipediaUrl,
    Expression<double>? stockGrams,
    Expression<double>? costPerGram,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (casNumber != null) 'cas_number': casNumber,
      if (secondaryCas != null) 'secondary_cas': secondaryCas,
      if (einecs != null) 'einecs': einecs,
      if (ecNumber != null) 'ec_number': ecNumber,
      if (fema != null) 'fema': fema,
      if (jecfa != null) 'jecfa': jecfa,
      if (flavis != null) 'flavis': flavis,
      if (iupacName != null) 'iupac_name': iupacName,
      if (botanicalName != null) 'botanical_name': botanicalName,
      if (imageUrl != null) 'image_url': imageUrl,
      if (description != null) 'description': description,
      if (pyramidNote != null) 'pyramid_note': pyramidNote,
      if (categoriesJson != null) 'categories_json': categoriesJson,
      if (odorProfilesJson != null) 'odor_profiles_json': odorProfilesJson,
      if (density != null) 'density': density,
      if (dilutionPercent != null) 'dilution_percent': dilutionPercent,
      if (defaultSolvent != null) 'default_solvent': defaultSolvent,
      if (intensity != null) 'intensity': intensity,
      if (relativeImpact != null) 'relative_impact': relativeImpact,
      if (odorLife != null) 'odor_life': odorLife,
      if (idealMaxPercent != null) 'ideal_max_percent': idealMaxPercent,
      if (molecularWeight != null) 'molecular_weight': molecularWeight,
      if (molecularFormula != null) 'molecular_formula': molecularFormula,
      if (flashPoint != null) 'flash_point': flashPoint,
      if (boilingPoint != null) 'boiling_point': boilingPoint,
      if (meltingPoint != null) 'melting_point': meltingPoint,
      if (logP != null) 'log_p': logP,
      if (vaporPressure != null) 'vapor_pressure': vaporPressure,
      if (biodegradability != null) 'biodegradability': biodegradability,
      if (renewableCarbonPercent != null)
        'renewable_carbon_percent': renewableCarbonPercent,
      if (hazardPictogramsJson != null)
        'hazard_pictograms_json': hazardPictogramsJson,
      if (tgscUrl != null) 'tgsc_url': tgscUrl,
      if (pubchemCid != null) 'pubchem_cid': pubchemCid,
      if (scentreeUrl != null) 'scentree_url': scentreeUrl,
      if (wikipediaUrl != null) 'wikipedia_url': wikipediaUrl,
      if (stockGrams != null) 'stock_grams': stockGrams,
      if (costPerGram != null) 'cost_per_gram': costPerGram,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MaterialsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? casNumber,
    Value<String?>? secondaryCas,
    Value<String?>? einecs,
    Value<String?>? ecNumber,
    Value<String?>? fema,
    Value<String?>? jecfa,
    Value<String?>? flavis,
    Value<String?>? iupacName,
    Value<String?>? botanicalName,
    Value<String?>? imageUrl,
    Value<String?>? description,
    Value<String>? pyramidNote,
    Value<String>? categoriesJson,
    Value<String>? odorProfilesJson,
    Value<double?>? density,
    Value<double>? dilutionPercent,
    Value<String?>? defaultSolvent,
    Value<int>? intensity,
    Value<double?>? relativeImpact,
    Value<String?>? odorLife,
    Value<double?>? idealMaxPercent,
    Value<String?>? molecularWeight,
    Value<String?>? molecularFormula,
    Value<String?>? flashPoint,
    Value<String?>? boilingPoint,
    Value<String?>? meltingPoint,
    Value<String?>? logP,
    Value<String?>? vaporPressure,
    Value<String?>? biodegradability,
    Value<double?>? renewableCarbonPercent,
    Value<String>? hazardPictogramsJson,
    Value<String?>? tgscUrl,
    Value<String?>? pubchemCid,
    Value<String?>? scentreeUrl,
    Value<String?>? wikipediaUrl,
    Value<double>? stockGrams,
    Value<double>? costPerGram,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MaterialsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      casNumber: casNumber ?? this.casNumber,
      secondaryCas: secondaryCas ?? this.secondaryCas,
      einecs: einecs ?? this.einecs,
      ecNumber: ecNumber ?? this.ecNumber,
      fema: fema ?? this.fema,
      jecfa: jecfa ?? this.jecfa,
      flavis: flavis ?? this.flavis,
      iupacName: iupacName ?? this.iupacName,
      botanicalName: botanicalName ?? this.botanicalName,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      pyramidNote: pyramidNote ?? this.pyramidNote,
      categoriesJson: categoriesJson ?? this.categoriesJson,
      odorProfilesJson: odorProfilesJson ?? this.odorProfilesJson,
      density: density ?? this.density,
      dilutionPercent: dilutionPercent ?? this.dilutionPercent,
      defaultSolvent: defaultSolvent ?? this.defaultSolvent,
      intensity: intensity ?? this.intensity,
      relativeImpact: relativeImpact ?? this.relativeImpact,
      odorLife: odorLife ?? this.odorLife,
      idealMaxPercent: idealMaxPercent ?? this.idealMaxPercent,
      molecularWeight: molecularWeight ?? this.molecularWeight,
      molecularFormula: molecularFormula ?? this.molecularFormula,
      flashPoint: flashPoint ?? this.flashPoint,
      boilingPoint: boilingPoint ?? this.boilingPoint,
      meltingPoint: meltingPoint ?? this.meltingPoint,
      logP: logP ?? this.logP,
      vaporPressure: vaporPressure ?? this.vaporPressure,
      biodegradability: biodegradability ?? this.biodegradability,
      renewableCarbonPercent:
          renewableCarbonPercent ?? this.renewableCarbonPercent,
      hazardPictogramsJson: hazardPictogramsJson ?? this.hazardPictogramsJson,
      tgscUrl: tgscUrl ?? this.tgscUrl,
      pubchemCid: pubchemCid ?? this.pubchemCid,
      scentreeUrl: scentreeUrl ?? this.scentreeUrl,
      wikipediaUrl: wikipediaUrl ?? this.wikipediaUrl,
      stockGrams: stockGrams ?? this.stockGrams,
      costPerGram: costPerGram ?? this.costPerGram,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (casNumber.present) {
      map['cas_number'] = Variable<String>(casNumber.value);
    }
    if (secondaryCas.present) {
      map['secondary_cas'] = Variable<String>(secondaryCas.value);
    }
    if (einecs.present) {
      map['einecs'] = Variable<String>(einecs.value);
    }
    if (ecNumber.present) {
      map['ec_number'] = Variable<String>(ecNumber.value);
    }
    if (fema.present) {
      map['fema'] = Variable<String>(fema.value);
    }
    if (jecfa.present) {
      map['jecfa'] = Variable<String>(jecfa.value);
    }
    if (flavis.present) {
      map['flavis'] = Variable<String>(flavis.value);
    }
    if (iupacName.present) {
      map['iupac_name'] = Variable<String>(iupacName.value);
    }
    if (botanicalName.present) {
      map['botanical_name'] = Variable<String>(botanicalName.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (pyramidNote.present) {
      map['pyramid_note'] = Variable<String>(pyramidNote.value);
    }
    if (categoriesJson.present) {
      map['categories_json'] = Variable<String>(categoriesJson.value);
    }
    if (odorProfilesJson.present) {
      map['odor_profiles_json'] = Variable<String>(odorProfilesJson.value);
    }
    if (density.present) {
      map['density'] = Variable<double>(density.value);
    }
    if (dilutionPercent.present) {
      map['dilution_percent'] = Variable<double>(dilutionPercent.value);
    }
    if (defaultSolvent.present) {
      map['default_solvent'] = Variable<String>(defaultSolvent.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<int>(intensity.value);
    }
    if (relativeImpact.present) {
      map['relative_impact'] = Variable<double>(relativeImpact.value);
    }
    if (odorLife.present) {
      map['odor_life'] = Variable<String>(odorLife.value);
    }
    if (idealMaxPercent.present) {
      map['ideal_max_percent'] = Variable<double>(idealMaxPercent.value);
    }
    if (molecularWeight.present) {
      map['molecular_weight'] = Variable<String>(molecularWeight.value);
    }
    if (molecularFormula.present) {
      map['molecular_formula'] = Variable<String>(molecularFormula.value);
    }
    if (flashPoint.present) {
      map['flash_point'] = Variable<String>(flashPoint.value);
    }
    if (boilingPoint.present) {
      map['boiling_point'] = Variable<String>(boilingPoint.value);
    }
    if (meltingPoint.present) {
      map['melting_point'] = Variable<String>(meltingPoint.value);
    }
    if (logP.present) {
      map['log_p'] = Variable<String>(logP.value);
    }
    if (vaporPressure.present) {
      map['vapor_pressure'] = Variable<String>(vaporPressure.value);
    }
    if (biodegradability.present) {
      map['biodegradability'] = Variable<String>(biodegradability.value);
    }
    if (renewableCarbonPercent.present) {
      map['renewable_carbon_percent'] = Variable<double>(
        renewableCarbonPercent.value,
      );
    }
    if (hazardPictogramsJson.present) {
      map['hazard_pictograms_json'] = Variable<String>(
        hazardPictogramsJson.value,
      );
    }
    if (tgscUrl.present) {
      map['tgsc_url'] = Variable<String>(tgscUrl.value);
    }
    if (pubchemCid.present) {
      map['pubchem_cid'] = Variable<String>(pubchemCid.value);
    }
    if (scentreeUrl.present) {
      map['scentree_url'] = Variable<String>(scentreeUrl.value);
    }
    if (wikipediaUrl.present) {
      map['wikipedia_url'] = Variable<String>(wikipediaUrl.value);
    }
    if (stockGrams.present) {
      map['stock_grams'] = Variable<double>(stockGrams.value);
    }
    if (costPerGram.present) {
      map['cost_per_gram'] = Variable<double>(costPerGram.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaterialsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('casNumber: $casNumber, ')
          ..write('secondaryCas: $secondaryCas, ')
          ..write('einecs: $einecs, ')
          ..write('ecNumber: $ecNumber, ')
          ..write('fema: $fema, ')
          ..write('jecfa: $jecfa, ')
          ..write('flavis: $flavis, ')
          ..write('iupacName: $iupacName, ')
          ..write('botanicalName: $botanicalName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('description: $description, ')
          ..write('pyramidNote: $pyramidNote, ')
          ..write('categoriesJson: $categoriesJson, ')
          ..write('odorProfilesJson: $odorProfilesJson, ')
          ..write('density: $density, ')
          ..write('dilutionPercent: $dilutionPercent, ')
          ..write('defaultSolvent: $defaultSolvent, ')
          ..write('intensity: $intensity, ')
          ..write('relativeImpact: $relativeImpact, ')
          ..write('odorLife: $odorLife, ')
          ..write('idealMaxPercent: $idealMaxPercent, ')
          ..write('molecularWeight: $molecularWeight, ')
          ..write('molecularFormula: $molecularFormula, ')
          ..write('flashPoint: $flashPoint, ')
          ..write('boilingPoint: $boilingPoint, ')
          ..write('meltingPoint: $meltingPoint, ')
          ..write('logP: $logP, ')
          ..write('vaporPressure: $vaporPressure, ')
          ..write('biodegradability: $biodegradability, ')
          ..write('renewableCarbonPercent: $renewableCarbonPercent, ')
          ..write('hazardPictogramsJson: $hazardPictogramsJson, ')
          ..write('tgscUrl: $tgscUrl, ')
          ..write('pubchemCid: $pubchemCid, ')
          ..write('scentreeUrl: $scentreeUrl, ')
          ..write('wikipediaUrl: $wikipediaUrl, ')
          ..write('stockGrams: $stockGrams, ')
          ..write('costPerGram: $costPerGram, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReadyOilsTable extends ReadyOils
    with TableInfo<$ReadyOilsTable, ReadyOil> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadyOilsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierMeta = const VerificationMeta(
    'supplier',
  );
  @override
  late final GeneratedColumn<String> supplier = GeneratedColumn<String>(
    'supplier',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lotNumberMeta = const VerificationMeta(
    'lotNumber',
  );
  @override
  late final GeneratedColumn<String> lotNumber = GeneratedColumn<String>(
    'lot_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockGramsMeta = const VerificationMeta(
    'stockGrams',
  );
  @override
  late final GeneratedColumn<double> stockGrams = GeneratedColumn<double>(
    'stock_grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _costPerGramMeta = const VerificationMeta(
    'costPerGram',
  );
  @override
  late final GeneratedColumn<double> costPerGram = GeneratedColumn<double>(
    'cost_per_gram',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _recommendedDosagePercentMeta =
      const VerificationMeta('recommendedDosagePercent');
  @override
  late final GeneratedColumn<double> recommendedDosagePercent =
      GeneratedColumn<double>(
        'recommended_dosage_percent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _ifraMaxPercentMeta = const VerificationMeta(
    'ifraMaxPercent',
  );
  @override
  late final GeneratedColumn<double> ifraMaxPercent = GeneratedColumn<double>(
    'ifra_max_percent',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flashPointMeta = const VerificationMeta(
    'flashPoint',
  );
  @override
  late final GeneratedColumn<double> flashPoint = GeneratedColumn<double>(
    'flash_point',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    supplier,
    lotNumber,
    stockGrams,
    costPerGram,
    recommendedDosagePercent,
    ifraMaxPercent,
    flashPoint,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ready_oils';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadyOil> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('supplier')) {
      context.handle(
        _supplierMeta,
        supplier.isAcceptableOrUnknown(data['supplier']!, _supplierMeta),
      );
    }
    if (data.containsKey('lot_number')) {
      context.handle(
        _lotNumberMeta,
        lotNumber.isAcceptableOrUnknown(data['lot_number']!, _lotNumberMeta),
      );
    }
    if (data.containsKey('stock_grams')) {
      context.handle(
        _stockGramsMeta,
        stockGrams.isAcceptableOrUnknown(data['stock_grams']!, _stockGramsMeta),
      );
    }
    if (data.containsKey('cost_per_gram')) {
      context.handle(
        _costPerGramMeta,
        costPerGram.isAcceptableOrUnknown(
          data['cost_per_gram']!,
          _costPerGramMeta,
        ),
      );
    }
    if (data.containsKey('recommended_dosage_percent')) {
      context.handle(
        _recommendedDosagePercentMeta,
        recommendedDosagePercent.isAcceptableOrUnknown(
          data['recommended_dosage_percent']!,
          _recommendedDosagePercentMeta,
        ),
      );
    }
    if (data.containsKey('ifra_max_percent')) {
      context.handle(
        _ifraMaxPercentMeta,
        ifraMaxPercent.isAcceptableOrUnknown(
          data['ifra_max_percent']!,
          _ifraMaxPercentMeta,
        ),
      );
    }
    if (data.containsKey('flash_point')) {
      context.handle(
        _flashPointMeta,
        flashPoint.isAcceptableOrUnknown(data['flash_point']!, _flashPointMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadyOil map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadyOil(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      supplier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier'],
      ),
      lotNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lot_number'],
      ),
      stockGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_grams'],
      )!,
      costPerGram: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_per_gram'],
      )!,
      recommendedDosagePercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}recommended_dosage_percent'],
      ),
      ifraMaxPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ifra_max_percent'],
      ),
      flashPoint: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}flash_point'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReadyOilsTable createAlias(String alias) {
    return $ReadyOilsTable(attachedDatabase, alias);
  }
}

class ReadyOil extends DataClass implements Insertable<ReadyOil> {
  final String id;
  final String name;
  final String? supplier;
  final String? lotNumber;
  final double stockGrams;
  final double costPerGram;
  final double? recommendedDosagePercent;
  final double? ifraMaxPercent;
  final double? flashPoint;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ReadyOil({
    required this.id,
    required this.name,
    this.supplier,
    this.lotNumber,
    required this.stockGrams,
    required this.costPerGram,
    this.recommendedDosagePercent,
    this.ifraMaxPercent,
    this.flashPoint,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || supplier != null) {
      map['supplier'] = Variable<String>(supplier);
    }
    if (!nullToAbsent || lotNumber != null) {
      map['lot_number'] = Variable<String>(lotNumber);
    }
    map['stock_grams'] = Variable<double>(stockGrams);
    map['cost_per_gram'] = Variable<double>(costPerGram);
    if (!nullToAbsent || recommendedDosagePercent != null) {
      map['recommended_dosage_percent'] = Variable<double>(
        recommendedDosagePercent,
      );
    }
    if (!nullToAbsent || ifraMaxPercent != null) {
      map['ifra_max_percent'] = Variable<double>(ifraMaxPercent);
    }
    if (!nullToAbsent || flashPoint != null) {
      map['flash_point'] = Variable<double>(flashPoint);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReadyOilsCompanion toCompanion(bool nullToAbsent) {
    return ReadyOilsCompanion(
      id: Value(id),
      name: Value(name),
      supplier: supplier == null && nullToAbsent
          ? const Value.absent()
          : Value(supplier),
      lotNumber: lotNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(lotNumber),
      stockGrams: Value(stockGrams),
      costPerGram: Value(costPerGram),
      recommendedDosagePercent: recommendedDosagePercent == null && nullToAbsent
          ? const Value.absent()
          : Value(recommendedDosagePercent),
      ifraMaxPercent: ifraMaxPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(ifraMaxPercent),
      flashPoint: flashPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(flashPoint),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReadyOil.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadyOil(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      supplier: serializer.fromJson<String?>(json['supplier']),
      lotNumber: serializer.fromJson<String?>(json['lotNumber']),
      stockGrams: serializer.fromJson<double>(json['stockGrams']),
      costPerGram: serializer.fromJson<double>(json['costPerGram']),
      recommendedDosagePercent: serializer.fromJson<double?>(
        json['recommendedDosagePercent'],
      ),
      ifraMaxPercent: serializer.fromJson<double?>(json['ifraMaxPercent']),
      flashPoint: serializer.fromJson<double?>(json['flashPoint']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'supplier': serializer.toJson<String?>(supplier),
      'lotNumber': serializer.toJson<String?>(lotNumber),
      'stockGrams': serializer.toJson<double>(stockGrams),
      'costPerGram': serializer.toJson<double>(costPerGram),
      'recommendedDosagePercent': serializer.toJson<double?>(
        recommendedDosagePercent,
      ),
      'ifraMaxPercent': serializer.toJson<double?>(ifraMaxPercent),
      'flashPoint': serializer.toJson<double?>(flashPoint),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReadyOil copyWith({
    String? id,
    String? name,
    Value<String?> supplier = const Value.absent(),
    Value<String?> lotNumber = const Value.absent(),
    double? stockGrams,
    double? costPerGram,
    Value<double?> recommendedDosagePercent = const Value.absent(),
    Value<double?> ifraMaxPercent = const Value.absent(),
    Value<double?> flashPoint = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ReadyOil(
    id: id ?? this.id,
    name: name ?? this.name,
    supplier: supplier.present ? supplier.value : this.supplier,
    lotNumber: lotNumber.present ? lotNumber.value : this.lotNumber,
    stockGrams: stockGrams ?? this.stockGrams,
    costPerGram: costPerGram ?? this.costPerGram,
    recommendedDosagePercent: recommendedDosagePercent.present
        ? recommendedDosagePercent.value
        : this.recommendedDosagePercent,
    ifraMaxPercent: ifraMaxPercent.present
        ? ifraMaxPercent.value
        : this.ifraMaxPercent,
    flashPoint: flashPoint.present ? flashPoint.value : this.flashPoint,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ReadyOil copyWithCompanion(ReadyOilsCompanion data) {
    return ReadyOil(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      supplier: data.supplier.present ? data.supplier.value : this.supplier,
      lotNumber: data.lotNumber.present ? data.lotNumber.value : this.lotNumber,
      stockGrams: data.stockGrams.present
          ? data.stockGrams.value
          : this.stockGrams,
      costPerGram: data.costPerGram.present
          ? data.costPerGram.value
          : this.costPerGram,
      recommendedDosagePercent: data.recommendedDosagePercent.present
          ? data.recommendedDosagePercent.value
          : this.recommendedDosagePercent,
      ifraMaxPercent: data.ifraMaxPercent.present
          ? data.ifraMaxPercent.value
          : this.ifraMaxPercent,
      flashPoint: data.flashPoint.present
          ? data.flashPoint.value
          : this.flashPoint,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadyOil(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('supplier: $supplier, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('stockGrams: $stockGrams, ')
          ..write('costPerGram: $costPerGram, ')
          ..write('recommendedDosagePercent: $recommendedDosagePercent, ')
          ..write('ifraMaxPercent: $ifraMaxPercent, ')
          ..write('flashPoint: $flashPoint, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    supplier,
    lotNumber,
    stockGrams,
    costPerGram,
    recommendedDosagePercent,
    ifraMaxPercent,
    flashPoint,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadyOil &&
          other.id == this.id &&
          other.name == this.name &&
          other.supplier == this.supplier &&
          other.lotNumber == this.lotNumber &&
          other.stockGrams == this.stockGrams &&
          other.costPerGram == this.costPerGram &&
          other.recommendedDosagePercent == this.recommendedDosagePercent &&
          other.ifraMaxPercent == this.ifraMaxPercent &&
          other.flashPoint == this.flashPoint &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ReadyOilsCompanion extends UpdateCompanion<ReadyOil> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> supplier;
  final Value<String?> lotNumber;
  final Value<double> stockGrams;
  final Value<double> costPerGram;
  final Value<double?> recommendedDosagePercent;
  final Value<double?> ifraMaxPercent;
  final Value<double?> flashPoint;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ReadyOilsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.supplier = const Value.absent(),
    this.lotNumber = const Value.absent(),
    this.stockGrams = const Value.absent(),
    this.costPerGram = const Value.absent(),
    this.recommendedDosagePercent = const Value.absent(),
    this.ifraMaxPercent = const Value.absent(),
    this.flashPoint = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReadyOilsCompanion.insert({
    required String id,
    required String name,
    this.supplier = const Value.absent(),
    this.lotNumber = const Value.absent(),
    this.stockGrams = const Value.absent(),
    this.costPerGram = const Value.absent(),
    this.recommendedDosagePercent = const Value.absent(),
    this.ifraMaxPercent = const Value.absent(),
    this.flashPoint = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<ReadyOil> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? supplier,
    Expression<String>? lotNumber,
    Expression<double>? stockGrams,
    Expression<double>? costPerGram,
    Expression<double>? recommendedDosagePercent,
    Expression<double>? ifraMaxPercent,
    Expression<double>? flashPoint,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (supplier != null) 'supplier': supplier,
      if (lotNumber != null) 'lot_number': lotNumber,
      if (stockGrams != null) 'stock_grams': stockGrams,
      if (costPerGram != null) 'cost_per_gram': costPerGram,
      if (recommendedDosagePercent != null)
        'recommended_dosage_percent': recommendedDosagePercent,
      if (ifraMaxPercent != null) 'ifra_max_percent': ifraMaxPercent,
      if (flashPoint != null) 'flash_point': flashPoint,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReadyOilsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? supplier,
    Value<String?>? lotNumber,
    Value<double>? stockGrams,
    Value<double>? costPerGram,
    Value<double?>? recommendedDosagePercent,
    Value<double?>? ifraMaxPercent,
    Value<double?>? flashPoint,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ReadyOilsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      supplier: supplier ?? this.supplier,
      lotNumber: lotNumber ?? this.lotNumber,
      stockGrams: stockGrams ?? this.stockGrams,
      costPerGram: costPerGram ?? this.costPerGram,
      recommendedDosagePercent:
          recommendedDosagePercent ?? this.recommendedDosagePercent,
      ifraMaxPercent: ifraMaxPercent ?? this.ifraMaxPercent,
      flashPoint: flashPoint ?? this.flashPoint,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (supplier.present) {
      map['supplier'] = Variable<String>(supplier.value);
    }
    if (lotNumber.present) {
      map['lot_number'] = Variable<String>(lotNumber.value);
    }
    if (stockGrams.present) {
      map['stock_grams'] = Variable<double>(stockGrams.value);
    }
    if (costPerGram.present) {
      map['cost_per_gram'] = Variable<double>(costPerGram.value);
    }
    if (recommendedDosagePercent.present) {
      map['recommended_dosage_percent'] = Variable<double>(
        recommendedDosagePercent.value,
      );
    }
    if (ifraMaxPercent.present) {
      map['ifra_max_percent'] = Variable<double>(ifraMaxPercent.value);
    }
    if (flashPoint.present) {
      map['flash_point'] = Variable<double>(flashPoint.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadyOilsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('supplier: $supplier, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('stockGrams: $stockGrams, ')
          ..write('costPerGram: $costPerGram, ')
          ..write('recommendedDosagePercent: $recommendedDosagePercent, ')
          ..write('ifraMaxPercent: $ifraMaxPercent, ')
          ..write('flashPoint: $flashPoint, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FormulasTable extends Formulas with TableInfo<$FormulasTable, Formula> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FormulasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('1.0'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetConcentrationPercentMeta =
      const VerificationMeta('targetConcentrationPercent');
  @override
  late final GeneratedColumn<double> targetConcentrationPercent =
      GeneratedColumn<double>(
        'target_concentration_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(20.0),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    version,
    description,
    targetConcentrationPercent,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'formulas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Formula> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('target_concentration_percent')) {
      context.handle(
        _targetConcentrationPercentMeta,
        targetConcentrationPercent.isAcceptableOrUnknown(
          data['target_concentration_percent']!,
          _targetConcentrationPercentMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Formula map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Formula(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}version'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      targetConcentrationPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_concentration_percent'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FormulasTable createAlias(String alias) {
    return $FormulasTable(attachedDatabase, alias);
  }
}

class Formula extends DataClass implements Insertable<Formula> {
  final String id;
  final String name;
  final String version;
  final String? description;
  final double targetConcentrationPercent;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Formula({
    required this.id,
    required this.name,
    required this.version,
    this.description,
    required this.targetConcentrationPercent,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['version'] = Variable<String>(version);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['target_concentration_percent'] = Variable<double>(
      targetConcentrationPercent,
    );
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FormulasCompanion toCompanion(bool nullToAbsent) {
    return FormulasCompanion(
      id: Value(id),
      name: Value(name),
      version: Value(version),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      targetConcentrationPercent: Value(targetConcentrationPercent),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Formula.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Formula(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      version: serializer.fromJson<String>(json['version']),
      description: serializer.fromJson<String?>(json['description']),
      targetConcentrationPercent: serializer.fromJson<double>(
        json['targetConcentrationPercent'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'version': serializer.toJson<String>(version),
      'description': serializer.toJson<String?>(description),
      'targetConcentrationPercent': serializer.toJson<double>(
        targetConcentrationPercent,
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Formula copyWith({
    String? id,
    String? name,
    String? version,
    Value<String?> description = const Value.absent(),
    double? targetConcentrationPercent,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Formula(
    id: id ?? this.id,
    name: name ?? this.name,
    version: version ?? this.version,
    description: description.present ? description.value : this.description,
    targetConcentrationPercent:
        targetConcentrationPercent ?? this.targetConcentrationPercent,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Formula copyWithCompanion(FormulasCompanion data) {
    return Formula(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      version: data.version.present ? data.version.value : this.version,
      description: data.description.present
          ? data.description.value
          : this.description,
      targetConcentrationPercent: data.targetConcentrationPercent.present
          ? data.targetConcentrationPercent.value
          : this.targetConcentrationPercent,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Formula(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('version: $version, ')
          ..write('description: $description, ')
          ..write('targetConcentrationPercent: $targetConcentrationPercent, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    version,
    description,
    targetConcentrationPercent,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Formula &&
          other.id == this.id &&
          other.name == this.name &&
          other.version == this.version &&
          other.description == this.description &&
          other.targetConcentrationPercent == this.targetConcentrationPercent &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FormulasCompanion extends UpdateCompanion<Formula> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> version;
  final Value<String?> description;
  final Value<double> targetConcentrationPercent;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FormulasCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.version = const Value.absent(),
    this.description = const Value.absent(),
    this.targetConcentrationPercent = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FormulasCompanion.insert({
    required String id,
    required String name,
    this.version = const Value.absent(),
    this.description = const Value.absent(),
    this.targetConcentrationPercent = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Formula> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? version,
    Expression<String>? description,
    Expression<double>? targetConcentrationPercent,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (version != null) 'version': version,
      if (description != null) 'description': description,
      if (targetConcentrationPercent != null)
        'target_concentration_percent': targetConcentrationPercent,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FormulasCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? version,
    Value<String?>? description,
    Value<double>? targetConcentrationPercent,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FormulasCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      version: version ?? this.version,
      description: description ?? this.description,
      targetConcentrationPercent:
          targetConcentrationPercent ?? this.targetConcentrationPercent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (targetConcentrationPercent.present) {
      map['target_concentration_percent'] = Variable<double>(
        targetConcentrationPercent.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FormulasCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('version: $version, ')
          ..write('description: $description, ')
          ..write('targetConcentrationPercent: $targetConcentrationPercent, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FormulaItemsTable extends FormulaItems
    with TableInfo<$FormulaItemsTable, FormulaItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FormulaItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formulaIdMeta = const VerificationMeta(
    'formulaId',
  );
  @override
  late final GeneratedColumn<String> formulaId = GeneratedColumn<String>(
    'formula_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES formulas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _materialIdMeta = const VerificationMeta(
    'materialId',
  );
  @override
  late final GeneratedColumn<String> materialId = GeneratedColumn<String>(
    'material_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES materials (id)',
    ),
  );
  static const VerificationMeta _partsPerThousandMeta = const VerificationMeta(
    'partsPerThousand',
  );
  @override
  late final GeneratedColumn<double> partsPerThousand = GeneratedColumn<double>(
    'parts_per_thousand',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _specifiedDilutionPercentMeta =
      const VerificationMeta('specifiedDilutionPercent');
  @override
  late final GeneratedColumn<double> specifiedDilutionPercent =
      GeneratedColumn<double>(
        'specified_dilution_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(100.0),
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    formulaId,
    materialId,
    partsPerThousand,
    specifiedDilutionPercent,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'formula_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FormulaItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('formula_id')) {
      context.handle(
        _formulaIdMeta,
        formulaId.isAcceptableOrUnknown(data['formula_id']!, _formulaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_formulaIdMeta);
    }
    if (data.containsKey('material_id')) {
      context.handle(
        _materialIdMeta,
        materialId.isAcceptableOrUnknown(data['material_id']!, _materialIdMeta),
      );
    } else if (isInserting) {
      context.missing(_materialIdMeta);
    }
    if (data.containsKey('parts_per_thousand')) {
      context.handle(
        _partsPerThousandMeta,
        partsPerThousand.isAcceptableOrUnknown(
          data['parts_per_thousand']!,
          _partsPerThousandMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_partsPerThousandMeta);
    }
    if (data.containsKey('specified_dilution_percent')) {
      context.handle(
        _specifiedDilutionPercentMeta,
        specifiedDilutionPercent.isAcceptableOrUnknown(
          data['specified_dilution_percent']!,
          _specifiedDilutionPercentMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FormulaItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FormulaItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      formulaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formula_id'],
      )!,
      materialId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material_id'],
      )!,
      partsPerThousand: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}parts_per_thousand'],
      )!,
      specifiedDilutionPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}specified_dilution_percent'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $FormulaItemsTable createAlias(String alias) {
    return $FormulaItemsTable(attachedDatabase, alias);
  }
}

class FormulaItem extends DataClass implements Insertable<FormulaItem> {
  final String id;
  final String formulaId;
  final String materialId;
  final double partsPerThousand;
  final double specifiedDilutionPercent;
  final String? notes;
  const FormulaItem({
    required this.id,
    required this.formulaId,
    required this.materialId,
    required this.partsPerThousand,
    required this.specifiedDilutionPercent,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['formula_id'] = Variable<String>(formulaId);
    map['material_id'] = Variable<String>(materialId);
    map['parts_per_thousand'] = Variable<double>(partsPerThousand);
    map['specified_dilution_percent'] = Variable<double>(
      specifiedDilutionPercent,
    );
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  FormulaItemsCompanion toCompanion(bool nullToAbsent) {
    return FormulaItemsCompanion(
      id: Value(id),
      formulaId: Value(formulaId),
      materialId: Value(materialId),
      partsPerThousand: Value(partsPerThousand),
      specifiedDilutionPercent: Value(specifiedDilutionPercent),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory FormulaItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FormulaItem(
      id: serializer.fromJson<String>(json['id']),
      formulaId: serializer.fromJson<String>(json['formulaId']),
      materialId: serializer.fromJson<String>(json['materialId']),
      partsPerThousand: serializer.fromJson<double>(json['partsPerThousand']),
      specifiedDilutionPercent: serializer.fromJson<double>(
        json['specifiedDilutionPercent'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'formulaId': serializer.toJson<String>(formulaId),
      'materialId': serializer.toJson<String>(materialId),
      'partsPerThousand': serializer.toJson<double>(partsPerThousand),
      'specifiedDilutionPercent': serializer.toJson<double>(
        specifiedDilutionPercent,
      ),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  FormulaItem copyWith({
    String? id,
    String? formulaId,
    String? materialId,
    double? partsPerThousand,
    double? specifiedDilutionPercent,
    Value<String?> notes = const Value.absent(),
  }) => FormulaItem(
    id: id ?? this.id,
    formulaId: formulaId ?? this.formulaId,
    materialId: materialId ?? this.materialId,
    partsPerThousand: partsPerThousand ?? this.partsPerThousand,
    specifiedDilutionPercent:
        specifiedDilutionPercent ?? this.specifiedDilutionPercent,
    notes: notes.present ? notes.value : this.notes,
  );
  FormulaItem copyWithCompanion(FormulaItemsCompanion data) {
    return FormulaItem(
      id: data.id.present ? data.id.value : this.id,
      formulaId: data.formulaId.present ? data.formulaId.value : this.formulaId,
      materialId: data.materialId.present
          ? data.materialId.value
          : this.materialId,
      partsPerThousand: data.partsPerThousand.present
          ? data.partsPerThousand.value
          : this.partsPerThousand,
      specifiedDilutionPercent: data.specifiedDilutionPercent.present
          ? data.specifiedDilutionPercent.value
          : this.specifiedDilutionPercent,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FormulaItem(')
          ..write('id: $id, ')
          ..write('formulaId: $formulaId, ')
          ..write('materialId: $materialId, ')
          ..write('partsPerThousand: $partsPerThousand, ')
          ..write('specifiedDilutionPercent: $specifiedDilutionPercent, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    formulaId,
    materialId,
    partsPerThousand,
    specifiedDilutionPercent,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FormulaItem &&
          other.id == this.id &&
          other.formulaId == this.formulaId &&
          other.materialId == this.materialId &&
          other.partsPerThousand == this.partsPerThousand &&
          other.specifiedDilutionPercent == this.specifiedDilutionPercent &&
          other.notes == this.notes);
}

class FormulaItemsCompanion extends UpdateCompanion<FormulaItem> {
  final Value<String> id;
  final Value<String> formulaId;
  final Value<String> materialId;
  final Value<double> partsPerThousand;
  final Value<double> specifiedDilutionPercent;
  final Value<String?> notes;
  final Value<int> rowid;
  const FormulaItemsCompanion({
    this.id = const Value.absent(),
    this.formulaId = const Value.absent(),
    this.materialId = const Value.absent(),
    this.partsPerThousand = const Value.absent(),
    this.specifiedDilutionPercent = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FormulaItemsCompanion.insert({
    required String id,
    required String formulaId,
    required String materialId,
    required double partsPerThousand,
    this.specifiedDilutionPercent = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       formulaId = Value(formulaId),
       materialId = Value(materialId),
       partsPerThousand = Value(partsPerThousand);
  static Insertable<FormulaItem> custom({
    Expression<String>? id,
    Expression<String>? formulaId,
    Expression<String>? materialId,
    Expression<double>? partsPerThousand,
    Expression<double>? specifiedDilutionPercent,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (formulaId != null) 'formula_id': formulaId,
      if (materialId != null) 'material_id': materialId,
      if (partsPerThousand != null) 'parts_per_thousand': partsPerThousand,
      if (specifiedDilutionPercent != null)
        'specified_dilution_percent': specifiedDilutionPercent,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FormulaItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? formulaId,
    Value<String>? materialId,
    Value<double>? partsPerThousand,
    Value<double>? specifiedDilutionPercent,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return FormulaItemsCompanion(
      id: id ?? this.id,
      formulaId: formulaId ?? this.formulaId,
      materialId: materialId ?? this.materialId,
      partsPerThousand: partsPerThousand ?? this.partsPerThousand,
      specifiedDilutionPercent:
          specifiedDilutionPercent ?? this.specifiedDilutionPercent,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (formulaId.present) {
      map['formula_id'] = Variable<String>(formulaId.value);
    }
    if (materialId.present) {
      map['material_id'] = Variable<String>(materialId.value);
    }
    if (partsPerThousand.present) {
      map['parts_per_thousand'] = Variable<double>(partsPerThousand.value);
    }
    if (specifiedDilutionPercent.present) {
      map['specified_dilution_percent'] = Variable<double>(
        specifiedDilutionPercent.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FormulaItemsCompanion(')
          ..write('id: $id, ')
          ..write('formulaId: $formulaId, ')
          ..write('materialId: $materialId, ')
          ..write('partsPerThousand: $partsPerThousand, ')
          ..write('specifiedDilutionPercent: $specifiedDilutionPercent, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AgingBatchesTable extends AgingBatches
    with TableInfo<$AgingBatchesTable, AgingBatche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgingBatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchNumberMeta = const VerificationMeta(
    'batchNumber',
  );
  @override
  late final GeneratedColumn<String> batchNumber = GeneratedColumn<String>(
    'batch_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stageMeta = const VerificationMeta('stage');
  @override
  late final GeneratedColumn<String> stage = GeneratedColumn<String>(
    'stage',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalWeightGramsMeta = const VerificationMeta(
    'totalWeightGrams',
  );
  @override
  late final GeneratedColumn<double> totalWeightGrams = GeneratedColumn<double>(
    'total_weight_grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _concentrationPercentMeta =
      const VerificationMeta('concentrationPercent');
  @override
  late final GeneratedColumn<double> concentrationPercent =
      GeneratedColumn<double>(
        'concentration_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _alcoholTypeMeta = const VerificationMeta(
    'alcoholType',
  );
  @override
  late final GeneratedColumn<String> alcoholType = GeneratedColumn<String>(
    'alcohol_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waterPercentMeta = const VerificationMeta(
    'waterPercent',
  );
  @override
  late final GeneratedColumn<double> waterPercent = GeneratedColumn<double>(
    'water_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetAgingDaysMeta = const VerificationMeta(
    'targetAgingDays',
  );
  @override
  late final GeneratedColumn<int> targetAgingDays = GeneratedColumn<int>(
    'target_aging_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchNumber,
    name,
    sourceType,
    sourceId,
    stage,
    totalWeightGrams,
    concentrationPercent,
    alcoholType,
    waterPercent,
    startDate,
    targetAgingDays,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'aging_batches';
  @override
  VerificationContext validateIntegrity(
    Insertable<AgingBatche> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('batch_number')) {
      context.handle(
        _batchNumberMeta,
        batchNumber.isAcceptableOrUnknown(
          data['batch_number']!,
          _batchNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_batchNumberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('stage')) {
      context.handle(
        _stageMeta,
        stage.isAcceptableOrUnknown(data['stage']!, _stageMeta),
      );
    } else if (isInserting) {
      context.missing(_stageMeta);
    }
    if (data.containsKey('total_weight_grams')) {
      context.handle(
        _totalWeightGramsMeta,
        totalWeightGrams.isAcceptableOrUnknown(
          data['total_weight_grams']!,
          _totalWeightGramsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalWeightGramsMeta);
    }
    if (data.containsKey('concentration_percent')) {
      context.handle(
        _concentrationPercentMeta,
        concentrationPercent.isAcceptableOrUnknown(
          data['concentration_percent']!,
          _concentrationPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_concentrationPercentMeta);
    }
    if (data.containsKey('alcohol_type')) {
      context.handle(
        _alcoholTypeMeta,
        alcoholType.isAcceptableOrUnknown(
          data['alcohol_type']!,
          _alcoholTypeMeta,
        ),
      );
    }
    if (data.containsKey('water_percent')) {
      context.handle(
        _waterPercentMeta,
        waterPercent.isAcceptableOrUnknown(
          data['water_percent']!,
          _waterPercentMeta,
        ),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('target_aging_days')) {
      context.handle(
        _targetAgingDaysMeta,
        targetAgingDays.isAcceptableOrUnknown(
          data['target_aging_days']!,
          _targetAgingDaysMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AgingBatche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgingBatche(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      batchNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_number'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      stage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stage'],
      )!,
      totalWeightGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_weight_grams'],
      )!,
      concentrationPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}concentration_percent'],
      )!,
      alcoholType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alcohol_type'],
      ),
      waterPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}water_percent'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      targetAgingDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_aging_days'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AgingBatchesTable createAlias(String alias) {
    return $AgingBatchesTable(attachedDatabase, alias);
  }
}

class AgingBatche extends DataClass implements Insertable<AgingBatche> {
  final String id;
  final String batchNumber;
  final String name;
  final String sourceType;
  final String sourceId;
  final String stage;
  final double totalWeightGrams;
  final double concentrationPercent;
  final String? alcoholType;
  final double waterPercent;
  final DateTime startDate;
  final int targetAgingDays;
  final String status;
  final DateTime createdAt;
  const AgingBatche({
    required this.id,
    required this.batchNumber,
    required this.name,
    required this.sourceType,
    required this.sourceId,
    required this.stage,
    required this.totalWeightGrams,
    required this.concentrationPercent,
    this.alcoholType,
    required this.waterPercent,
    required this.startDate,
    required this.targetAgingDays,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['batch_number'] = Variable<String>(batchNumber);
    map['name'] = Variable<String>(name);
    map['source_type'] = Variable<String>(sourceType);
    map['source_id'] = Variable<String>(sourceId);
    map['stage'] = Variable<String>(stage);
    map['total_weight_grams'] = Variable<double>(totalWeightGrams);
    map['concentration_percent'] = Variable<double>(concentrationPercent);
    if (!nullToAbsent || alcoholType != null) {
      map['alcohol_type'] = Variable<String>(alcoholType);
    }
    map['water_percent'] = Variable<double>(waterPercent);
    map['start_date'] = Variable<DateTime>(startDate);
    map['target_aging_days'] = Variable<int>(targetAgingDays);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AgingBatchesCompanion toCompanion(bool nullToAbsent) {
    return AgingBatchesCompanion(
      id: Value(id),
      batchNumber: Value(batchNumber),
      name: Value(name),
      sourceType: Value(sourceType),
      sourceId: Value(sourceId),
      stage: Value(stage),
      totalWeightGrams: Value(totalWeightGrams),
      concentrationPercent: Value(concentrationPercent),
      alcoholType: alcoholType == null && nullToAbsent
          ? const Value.absent()
          : Value(alcoholType),
      waterPercent: Value(waterPercent),
      startDate: Value(startDate),
      targetAgingDays: Value(targetAgingDays),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory AgingBatche.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgingBatche(
      id: serializer.fromJson<String>(json['id']),
      batchNumber: serializer.fromJson<String>(json['batchNumber']),
      name: serializer.fromJson<String>(json['name']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      stage: serializer.fromJson<String>(json['stage']),
      totalWeightGrams: serializer.fromJson<double>(json['totalWeightGrams']),
      concentrationPercent: serializer.fromJson<double>(
        json['concentrationPercent'],
      ),
      alcoholType: serializer.fromJson<String?>(json['alcoholType']),
      waterPercent: serializer.fromJson<double>(json['waterPercent']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      targetAgingDays: serializer.fromJson<int>(json['targetAgingDays']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'batchNumber': serializer.toJson<String>(batchNumber),
      'name': serializer.toJson<String>(name),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceId': serializer.toJson<String>(sourceId),
      'stage': serializer.toJson<String>(stage),
      'totalWeightGrams': serializer.toJson<double>(totalWeightGrams),
      'concentrationPercent': serializer.toJson<double>(concentrationPercent),
      'alcoholType': serializer.toJson<String?>(alcoholType),
      'waterPercent': serializer.toJson<double>(waterPercent),
      'startDate': serializer.toJson<DateTime>(startDate),
      'targetAgingDays': serializer.toJson<int>(targetAgingDays),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AgingBatche copyWith({
    String? id,
    String? batchNumber,
    String? name,
    String? sourceType,
    String? sourceId,
    String? stage,
    double? totalWeightGrams,
    double? concentrationPercent,
    Value<String?> alcoholType = const Value.absent(),
    double? waterPercent,
    DateTime? startDate,
    int? targetAgingDays,
    String? status,
    DateTime? createdAt,
  }) => AgingBatche(
    id: id ?? this.id,
    batchNumber: batchNumber ?? this.batchNumber,
    name: name ?? this.name,
    sourceType: sourceType ?? this.sourceType,
    sourceId: sourceId ?? this.sourceId,
    stage: stage ?? this.stage,
    totalWeightGrams: totalWeightGrams ?? this.totalWeightGrams,
    concentrationPercent: concentrationPercent ?? this.concentrationPercent,
    alcoholType: alcoholType.present ? alcoholType.value : this.alcoholType,
    waterPercent: waterPercent ?? this.waterPercent,
    startDate: startDate ?? this.startDate,
    targetAgingDays: targetAgingDays ?? this.targetAgingDays,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  AgingBatche copyWithCompanion(AgingBatchesCompanion data) {
    return AgingBatche(
      id: data.id.present ? data.id.value : this.id,
      batchNumber: data.batchNumber.present
          ? data.batchNumber.value
          : this.batchNumber,
      name: data.name.present ? data.name.value : this.name,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      stage: data.stage.present ? data.stage.value : this.stage,
      totalWeightGrams: data.totalWeightGrams.present
          ? data.totalWeightGrams.value
          : this.totalWeightGrams,
      concentrationPercent: data.concentrationPercent.present
          ? data.concentrationPercent.value
          : this.concentrationPercent,
      alcoholType: data.alcoholType.present
          ? data.alcoholType.value
          : this.alcoholType,
      waterPercent: data.waterPercent.present
          ? data.waterPercent.value
          : this.waterPercent,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      targetAgingDays: data.targetAgingDays.present
          ? data.targetAgingDays.value
          : this.targetAgingDays,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgingBatche(')
          ..write('id: $id, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('name: $name, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('stage: $stage, ')
          ..write('totalWeightGrams: $totalWeightGrams, ')
          ..write('concentrationPercent: $concentrationPercent, ')
          ..write('alcoholType: $alcoholType, ')
          ..write('waterPercent: $waterPercent, ')
          ..write('startDate: $startDate, ')
          ..write('targetAgingDays: $targetAgingDays, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    batchNumber,
    name,
    sourceType,
    sourceId,
    stage,
    totalWeightGrams,
    concentrationPercent,
    alcoholType,
    waterPercent,
    startDate,
    targetAgingDays,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgingBatche &&
          other.id == this.id &&
          other.batchNumber == this.batchNumber &&
          other.name == this.name &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId &&
          other.stage == this.stage &&
          other.totalWeightGrams == this.totalWeightGrams &&
          other.concentrationPercent == this.concentrationPercent &&
          other.alcoholType == this.alcoholType &&
          other.waterPercent == this.waterPercent &&
          other.startDate == this.startDate &&
          other.targetAgingDays == this.targetAgingDays &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class AgingBatchesCompanion extends UpdateCompanion<AgingBatche> {
  final Value<String> id;
  final Value<String> batchNumber;
  final Value<String> name;
  final Value<String> sourceType;
  final Value<String> sourceId;
  final Value<String> stage;
  final Value<double> totalWeightGrams;
  final Value<double> concentrationPercent;
  final Value<String?> alcoholType;
  final Value<double> waterPercent;
  final Value<DateTime> startDate;
  final Value<int> targetAgingDays;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AgingBatchesCompanion({
    this.id = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.stage = const Value.absent(),
    this.totalWeightGrams = const Value.absent(),
    this.concentrationPercent = const Value.absent(),
    this.alcoholType = const Value.absent(),
    this.waterPercent = const Value.absent(),
    this.startDate = const Value.absent(),
    this.targetAgingDays = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AgingBatchesCompanion.insert({
    required String id,
    required String batchNumber,
    required String name,
    required String sourceType,
    required String sourceId,
    required String stage,
    required double totalWeightGrams,
    required double concentrationPercent,
    this.alcoholType = const Value.absent(),
    this.waterPercent = const Value.absent(),
    required DateTime startDate,
    this.targetAgingDays = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       batchNumber = Value(batchNumber),
       name = Value(name),
       sourceType = Value(sourceType),
       sourceId = Value(sourceId),
       stage = Value(stage),
       totalWeightGrams = Value(totalWeightGrams),
       concentrationPercent = Value(concentrationPercent),
       startDate = Value(startDate);
  static Insertable<AgingBatche> custom({
    Expression<String>? id,
    Expression<String>? batchNumber,
    Expression<String>? name,
    Expression<String>? sourceType,
    Expression<String>? sourceId,
    Expression<String>? stage,
    Expression<double>? totalWeightGrams,
    Expression<double>? concentrationPercent,
    Expression<String>? alcoholType,
    Expression<double>? waterPercent,
    Expression<DateTime>? startDate,
    Expression<int>? targetAgingDays,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchNumber != null) 'batch_number': batchNumber,
      if (name != null) 'name': name,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceId != null) 'source_id': sourceId,
      if (stage != null) 'stage': stage,
      if (totalWeightGrams != null) 'total_weight_grams': totalWeightGrams,
      if (concentrationPercent != null)
        'concentration_percent': concentrationPercent,
      if (alcoholType != null) 'alcohol_type': alcoholType,
      if (waterPercent != null) 'water_percent': waterPercent,
      if (startDate != null) 'start_date': startDate,
      if (targetAgingDays != null) 'target_aging_days': targetAgingDays,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AgingBatchesCompanion copyWith({
    Value<String>? id,
    Value<String>? batchNumber,
    Value<String>? name,
    Value<String>? sourceType,
    Value<String>? sourceId,
    Value<String>? stage,
    Value<double>? totalWeightGrams,
    Value<double>? concentrationPercent,
    Value<String?>? alcoholType,
    Value<double>? waterPercent,
    Value<DateTime>? startDate,
    Value<int>? targetAgingDays,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AgingBatchesCompanion(
      id: id ?? this.id,
      batchNumber: batchNumber ?? this.batchNumber,
      name: name ?? this.name,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      stage: stage ?? this.stage,
      totalWeightGrams: totalWeightGrams ?? this.totalWeightGrams,
      concentrationPercent: concentrationPercent ?? this.concentrationPercent,
      alcoholType: alcoholType ?? this.alcoholType,
      waterPercent: waterPercent ?? this.waterPercent,
      startDate: startDate ?? this.startDate,
      targetAgingDays: targetAgingDays ?? this.targetAgingDays,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (batchNumber.present) {
      map['batch_number'] = Variable<String>(batchNumber.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(stage.value);
    }
    if (totalWeightGrams.present) {
      map['total_weight_grams'] = Variable<double>(totalWeightGrams.value);
    }
    if (concentrationPercent.present) {
      map['concentration_percent'] = Variable<double>(
        concentrationPercent.value,
      );
    }
    if (alcoholType.present) {
      map['alcohol_type'] = Variable<String>(alcoholType.value);
    }
    if (waterPercent.present) {
      map['water_percent'] = Variable<double>(waterPercent.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (targetAgingDays.present) {
      map['target_aging_days'] = Variable<int>(targetAgingDays.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgingBatchesCompanion(')
          ..write('id: $id, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('name: $name, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('stage: $stage, ')
          ..write('totalWeightGrams: $totalWeightGrams, ')
          ..write('concentrationPercent: $concentrationPercent, ')
          ..write('alcoholType: $alcoholType, ')
          ..write('waterPercent: $waterPercent, ')
          ..write('startDate: $startDate, ')
          ..write('targetAgingDays: $targetAgingDays, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AgingEvaluationsTable extends AgingEvaluations
    with TableInfo<$AgingEvaluationsTable, AgingEvaluation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgingEvaluationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta(
    'batchId',
  );
  @override
  late final GeneratedColumn<String> batchId = GeneratedColumn<String>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES aging_batches (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _evaluationDateMeta = const VerificationMeta(
    'evaluationDate',
  );
  @override
  late final GeneratedColumn<DateTime> evaluationDate =
      GeneratedColumn<DateTime>(
        'evaluation_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _dayNumberMeta = const VerificationMeta(
    'dayNumber',
  );
  @override
  late final GeneratedColumn<int> dayNumber = GeneratedColumn<int>(
    'day_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clarityMeta = const VerificationMeta(
    'clarity',
  );
  @override
  late final GeneratedColumn<String> clarity = GeneratedColumn<String>(
    'clarity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorDescriptionMeta = const VerificationMeta(
    'colorDescription',
  );
  @override
  late final GeneratedColumn<String> colorDescription = GeneratedColumn<String>(
    'color_description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alcoholSoftnessMeta = const VerificationMeta(
    'alcoholSoftness',
  );
  @override
  late final GeneratedColumn<int> alcoholSoftness = GeneratedColumn<int>(
    'alcohol_softness',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _harmonyScoreMeta = const VerificationMeta(
    'harmonyScore',
  );
  @override
  late final GeneratedColumn<int> harmonyScore = GeneratedColumn<int>(
    'harmony_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _perfumerNotesMeta = const VerificationMeta(
    'perfumerNotes',
  );
  @override
  late final GeneratedColumn<String> perfumerNotes = GeneratedColumn<String>(
    'perfumer_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isChillFilteredMeta = const VerificationMeta(
    'isChillFiltered',
  );
  @override
  late final GeneratedColumn<bool> isChillFiltered = GeneratedColumn<bool>(
    'is_chill_filtered',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_chill_filtered" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    batchId,
    evaluationDate,
    dayNumber,
    clarity,
    colorDescription,
    alcoholSoftness,
    harmonyScore,
    perfumerNotes,
    isChillFiltered,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'aging_evaluations';
  @override
  VerificationContext validateIntegrity(
    Insertable<AgingEvaluation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(
        _batchIdMeta,
        batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('evaluation_date')) {
      context.handle(
        _evaluationDateMeta,
        evaluationDate.isAcceptableOrUnknown(
          data['evaluation_date']!,
          _evaluationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_evaluationDateMeta);
    }
    if (data.containsKey('day_number')) {
      context.handle(
        _dayNumberMeta,
        dayNumber.isAcceptableOrUnknown(data['day_number']!, _dayNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_dayNumberMeta);
    }
    if (data.containsKey('clarity')) {
      context.handle(
        _clarityMeta,
        clarity.isAcceptableOrUnknown(data['clarity']!, _clarityMeta),
      );
    } else if (isInserting) {
      context.missing(_clarityMeta);
    }
    if (data.containsKey('color_description')) {
      context.handle(
        _colorDescriptionMeta,
        colorDescription.isAcceptableOrUnknown(
          data['color_description']!,
          _colorDescriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_colorDescriptionMeta);
    }
    if (data.containsKey('alcohol_softness')) {
      context.handle(
        _alcoholSoftnessMeta,
        alcoholSoftness.isAcceptableOrUnknown(
          data['alcohol_softness']!,
          _alcoholSoftnessMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_alcoholSoftnessMeta);
    }
    if (data.containsKey('harmony_score')) {
      context.handle(
        _harmonyScoreMeta,
        harmonyScore.isAcceptableOrUnknown(
          data['harmony_score']!,
          _harmonyScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_harmonyScoreMeta);
    }
    if (data.containsKey('perfumer_notes')) {
      context.handle(
        _perfumerNotesMeta,
        perfumerNotes.isAcceptableOrUnknown(
          data['perfumer_notes']!,
          _perfumerNotesMeta,
        ),
      );
    }
    if (data.containsKey('is_chill_filtered')) {
      context.handle(
        _isChillFilteredMeta,
        isChillFiltered.isAcceptableOrUnknown(
          data['is_chill_filtered']!,
          _isChillFilteredMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AgingEvaluation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgingEvaluation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      batchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_id'],
      )!,
      evaluationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}evaluation_date'],
      )!,
      dayNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_number'],
      )!,
      clarity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clarity'],
      )!,
      colorDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_description'],
      )!,
      alcoholSoftness: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alcohol_softness'],
      )!,
      harmonyScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harmony_score'],
      )!,
      perfumerNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}perfumer_notes'],
      ),
      isChillFiltered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_chill_filtered'],
      )!,
    );
  }

  @override
  $AgingEvaluationsTable createAlias(String alias) {
    return $AgingEvaluationsTable(attachedDatabase, alias);
  }
}

class AgingEvaluation extends DataClass implements Insertable<AgingEvaluation> {
  final String id;
  final String batchId;
  final DateTime evaluationDate;
  final int dayNumber;
  final String clarity;
  final String colorDescription;
  final int alcoholSoftness;
  final int harmonyScore;
  final String? perfumerNotes;
  final bool isChillFiltered;
  const AgingEvaluation({
    required this.id,
    required this.batchId,
    required this.evaluationDate,
    required this.dayNumber,
    required this.clarity,
    required this.colorDescription,
    required this.alcoholSoftness,
    required this.harmonyScore,
    this.perfumerNotes,
    required this.isChillFiltered,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['batch_id'] = Variable<String>(batchId);
    map['evaluation_date'] = Variable<DateTime>(evaluationDate);
    map['day_number'] = Variable<int>(dayNumber);
    map['clarity'] = Variable<String>(clarity);
    map['color_description'] = Variable<String>(colorDescription);
    map['alcohol_softness'] = Variable<int>(alcoholSoftness);
    map['harmony_score'] = Variable<int>(harmonyScore);
    if (!nullToAbsent || perfumerNotes != null) {
      map['perfumer_notes'] = Variable<String>(perfumerNotes);
    }
    map['is_chill_filtered'] = Variable<bool>(isChillFiltered);
    return map;
  }

  AgingEvaluationsCompanion toCompanion(bool nullToAbsent) {
    return AgingEvaluationsCompanion(
      id: Value(id),
      batchId: Value(batchId),
      evaluationDate: Value(evaluationDate),
      dayNumber: Value(dayNumber),
      clarity: Value(clarity),
      colorDescription: Value(colorDescription),
      alcoholSoftness: Value(alcoholSoftness),
      harmonyScore: Value(harmonyScore),
      perfumerNotes: perfumerNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(perfumerNotes),
      isChillFiltered: Value(isChillFiltered),
    );
  }

  factory AgingEvaluation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgingEvaluation(
      id: serializer.fromJson<String>(json['id']),
      batchId: serializer.fromJson<String>(json['batchId']),
      evaluationDate: serializer.fromJson<DateTime>(json['evaluationDate']),
      dayNumber: serializer.fromJson<int>(json['dayNumber']),
      clarity: serializer.fromJson<String>(json['clarity']),
      colorDescription: serializer.fromJson<String>(json['colorDescription']),
      alcoholSoftness: serializer.fromJson<int>(json['alcoholSoftness']),
      harmonyScore: serializer.fromJson<int>(json['harmonyScore']),
      perfumerNotes: serializer.fromJson<String?>(json['perfumerNotes']),
      isChillFiltered: serializer.fromJson<bool>(json['isChillFiltered']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'batchId': serializer.toJson<String>(batchId),
      'evaluationDate': serializer.toJson<DateTime>(evaluationDate),
      'dayNumber': serializer.toJson<int>(dayNumber),
      'clarity': serializer.toJson<String>(clarity),
      'colorDescription': serializer.toJson<String>(colorDescription),
      'alcoholSoftness': serializer.toJson<int>(alcoholSoftness),
      'harmonyScore': serializer.toJson<int>(harmonyScore),
      'perfumerNotes': serializer.toJson<String?>(perfumerNotes),
      'isChillFiltered': serializer.toJson<bool>(isChillFiltered),
    };
  }

  AgingEvaluation copyWith({
    String? id,
    String? batchId,
    DateTime? evaluationDate,
    int? dayNumber,
    String? clarity,
    String? colorDescription,
    int? alcoholSoftness,
    int? harmonyScore,
    Value<String?> perfumerNotes = const Value.absent(),
    bool? isChillFiltered,
  }) => AgingEvaluation(
    id: id ?? this.id,
    batchId: batchId ?? this.batchId,
    evaluationDate: evaluationDate ?? this.evaluationDate,
    dayNumber: dayNumber ?? this.dayNumber,
    clarity: clarity ?? this.clarity,
    colorDescription: colorDescription ?? this.colorDescription,
    alcoholSoftness: alcoholSoftness ?? this.alcoholSoftness,
    harmonyScore: harmonyScore ?? this.harmonyScore,
    perfumerNotes: perfumerNotes.present
        ? perfumerNotes.value
        : this.perfumerNotes,
    isChillFiltered: isChillFiltered ?? this.isChillFiltered,
  );
  AgingEvaluation copyWithCompanion(AgingEvaluationsCompanion data) {
    return AgingEvaluation(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      evaluationDate: data.evaluationDate.present
          ? data.evaluationDate.value
          : this.evaluationDate,
      dayNumber: data.dayNumber.present ? data.dayNumber.value : this.dayNumber,
      clarity: data.clarity.present ? data.clarity.value : this.clarity,
      colorDescription: data.colorDescription.present
          ? data.colorDescription.value
          : this.colorDescription,
      alcoholSoftness: data.alcoholSoftness.present
          ? data.alcoholSoftness.value
          : this.alcoholSoftness,
      harmonyScore: data.harmonyScore.present
          ? data.harmonyScore.value
          : this.harmonyScore,
      perfumerNotes: data.perfumerNotes.present
          ? data.perfumerNotes.value
          : this.perfumerNotes,
      isChillFiltered: data.isChillFiltered.present
          ? data.isChillFiltered.value
          : this.isChillFiltered,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgingEvaluation(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('evaluationDate: $evaluationDate, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('clarity: $clarity, ')
          ..write('colorDescription: $colorDescription, ')
          ..write('alcoholSoftness: $alcoholSoftness, ')
          ..write('harmonyScore: $harmonyScore, ')
          ..write('perfumerNotes: $perfumerNotes, ')
          ..write('isChillFiltered: $isChillFiltered')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    batchId,
    evaluationDate,
    dayNumber,
    clarity,
    colorDescription,
    alcoholSoftness,
    harmonyScore,
    perfumerNotes,
    isChillFiltered,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgingEvaluation &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.evaluationDate == this.evaluationDate &&
          other.dayNumber == this.dayNumber &&
          other.clarity == this.clarity &&
          other.colorDescription == this.colorDescription &&
          other.alcoholSoftness == this.alcoholSoftness &&
          other.harmonyScore == this.harmonyScore &&
          other.perfumerNotes == this.perfumerNotes &&
          other.isChillFiltered == this.isChillFiltered);
}

class AgingEvaluationsCompanion extends UpdateCompanion<AgingEvaluation> {
  final Value<String> id;
  final Value<String> batchId;
  final Value<DateTime> evaluationDate;
  final Value<int> dayNumber;
  final Value<String> clarity;
  final Value<String> colorDescription;
  final Value<int> alcoholSoftness;
  final Value<int> harmonyScore;
  final Value<String?> perfumerNotes;
  final Value<bool> isChillFiltered;
  final Value<int> rowid;
  const AgingEvaluationsCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.evaluationDate = const Value.absent(),
    this.dayNumber = const Value.absent(),
    this.clarity = const Value.absent(),
    this.colorDescription = const Value.absent(),
    this.alcoholSoftness = const Value.absent(),
    this.harmonyScore = const Value.absent(),
    this.perfumerNotes = const Value.absent(),
    this.isChillFiltered = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AgingEvaluationsCompanion.insert({
    required String id,
    required String batchId,
    required DateTime evaluationDate,
    required int dayNumber,
    required String clarity,
    required String colorDescription,
    required int alcoholSoftness,
    required int harmonyScore,
    this.perfumerNotes = const Value.absent(),
    this.isChillFiltered = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       batchId = Value(batchId),
       evaluationDate = Value(evaluationDate),
       dayNumber = Value(dayNumber),
       clarity = Value(clarity),
       colorDescription = Value(colorDescription),
       alcoholSoftness = Value(alcoholSoftness),
       harmonyScore = Value(harmonyScore);
  static Insertable<AgingEvaluation> custom({
    Expression<String>? id,
    Expression<String>? batchId,
    Expression<DateTime>? evaluationDate,
    Expression<int>? dayNumber,
    Expression<String>? clarity,
    Expression<String>? colorDescription,
    Expression<int>? alcoholSoftness,
    Expression<int>? harmonyScore,
    Expression<String>? perfumerNotes,
    Expression<bool>? isChillFiltered,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (evaluationDate != null) 'evaluation_date': evaluationDate,
      if (dayNumber != null) 'day_number': dayNumber,
      if (clarity != null) 'clarity': clarity,
      if (colorDescription != null) 'color_description': colorDescription,
      if (alcoholSoftness != null) 'alcohol_softness': alcoholSoftness,
      if (harmonyScore != null) 'harmony_score': harmonyScore,
      if (perfumerNotes != null) 'perfumer_notes': perfumerNotes,
      if (isChillFiltered != null) 'is_chill_filtered': isChillFiltered,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AgingEvaluationsCompanion copyWith({
    Value<String>? id,
    Value<String>? batchId,
    Value<DateTime>? evaluationDate,
    Value<int>? dayNumber,
    Value<String>? clarity,
    Value<String>? colorDescription,
    Value<int>? alcoholSoftness,
    Value<int>? harmonyScore,
    Value<String?>? perfumerNotes,
    Value<bool>? isChillFiltered,
    Value<int>? rowid,
  }) {
    return AgingEvaluationsCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      evaluationDate: evaluationDate ?? this.evaluationDate,
      dayNumber: dayNumber ?? this.dayNumber,
      clarity: clarity ?? this.clarity,
      colorDescription: colorDescription ?? this.colorDescription,
      alcoholSoftness: alcoholSoftness ?? this.alcoholSoftness,
      harmonyScore: harmonyScore ?? this.harmonyScore,
      perfumerNotes: perfumerNotes ?? this.perfumerNotes,
      isChillFiltered: isChillFiltered ?? this.isChillFiltered,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<String>(batchId.value);
    }
    if (evaluationDate.present) {
      map['evaluation_date'] = Variable<DateTime>(evaluationDate.value);
    }
    if (dayNumber.present) {
      map['day_number'] = Variable<int>(dayNumber.value);
    }
    if (clarity.present) {
      map['clarity'] = Variable<String>(clarity.value);
    }
    if (colorDescription.present) {
      map['color_description'] = Variable<String>(colorDescription.value);
    }
    if (alcoholSoftness.present) {
      map['alcohol_softness'] = Variable<int>(alcoholSoftness.value);
    }
    if (harmonyScore.present) {
      map['harmony_score'] = Variable<int>(harmonyScore.value);
    }
    if (perfumerNotes.present) {
      map['perfumer_notes'] = Variable<String>(perfumerNotes.value);
    }
    if (isChillFiltered.present) {
      map['is_chill_filtered'] = Variable<bool>(isChillFiltered.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgingEvaluationsCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('evaluationDate: $evaluationDate, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('clarity: $clarity, ')
          ..write('colorDescription: $colorDescription, ')
          ..write('alcoholSoftness: $alcoholSoftness, ')
          ..write('harmonyScore: $harmonyScore, ')
          ..write('perfumerNotes: $perfumerNotes, ')
          ..write('isChillFiltered: $isChillFiltered, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoryLogsTable extends InventoryLogs
    with TableInfo<$InventoryLogsTable, InventoryLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _materialIdMeta = const VerificationMeta(
    'materialId',
  );
  @override
  late final GeneratedColumn<String> materialId = GeneratedColumn<String>(
    'material_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES materials (id)',
    ),
  );
  static const VerificationMeta _deltaGramsMeta = const VerificationMeta(
    'deltaGrams',
  );
  @override
  late final GeneratedColumn<double> deltaGrams = GeneratedColumn<double>(
    'delta_grams',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remainingStockGramsMeta =
      const VerificationMeta('remainingStockGrams');
  @override
  late final GeneratedColumn<double> remainingStockGrams =
      GeneratedColumn<double>(
        'remaining_stock_grams',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceBatchIdMeta = const VerificationMeta(
    'referenceBatchId',
  );
  @override
  late final GeneratedColumn<String> referenceBatchId = GeneratedColumn<String>(
    'reference_batch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    materialId,
    deltaGrams,
    remainingStockGrams,
    reason,
    referenceBatchId,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('material_id')) {
      context.handle(
        _materialIdMeta,
        materialId.isAcceptableOrUnknown(data['material_id']!, _materialIdMeta),
      );
    } else if (isInserting) {
      context.missing(_materialIdMeta);
    }
    if (data.containsKey('delta_grams')) {
      context.handle(
        _deltaGramsMeta,
        deltaGrams.isAcceptableOrUnknown(data['delta_grams']!, _deltaGramsMeta),
      );
    } else if (isInserting) {
      context.missing(_deltaGramsMeta);
    }
    if (data.containsKey('remaining_stock_grams')) {
      context.handle(
        _remainingStockGramsMeta,
        remainingStockGrams.isAcceptableOrUnknown(
          data['remaining_stock_grams']!,
          _remainingStockGramsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_remainingStockGramsMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('reference_batch_id')) {
      context.handle(
        _referenceBatchIdMeta,
        referenceBatchId.isAcceptableOrUnknown(
          data['reference_batch_id']!,
          _referenceBatchIdMeta,
        ),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      materialId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material_id'],
      )!,
      deltaGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}delta_grams'],
      )!,
      remainingStockGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}remaining_stock_grams'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      referenceBatchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_batch_id'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $InventoryLogsTable createAlias(String alias) {
    return $InventoryLogsTable(attachedDatabase, alias);
  }
}

class InventoryLog extends DataClass implements Insertable<InventoryLog> {
  final String id;
  final String materialId;
  final double deltaGrams;
  final double remainingStockGrams;
  final String reason;
  final String? referenceBatchId;
  final DateTime timestamp;
  const InventoryLog({
    required this.id,
    required this.materialId,
    required this.deltaGrams,
    required this.remainingStockGrams,
    required this.reason,
    this.referenceBatchId,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['material_id'] = Variable<String>(materialId);
    map['delta_grams'] = Variable<double>(deltaGrams);
    map['remaining_stock_grams'] = Variable<double>(remainingStockGrams);
    map['reason'] = Variable<String>(reason);
    if (!nullToAbsent || referenceBatchId != null) {
      map['reference_batch_id'] = Variable<String>(referenceBatchId);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  InventoryLogsCompanion toCompanion(bool nullToAbsent) {
    return InventoryLogsCompanion(
      id: Value(id),
      materialId: Value(materialId),
      deltaGrams: Value(deltaGrams),
      remainingStockGrams: Value(remainingStockGrams),
      reason: Value(reason),
      referenceBatchId: referenceBatchId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceBatchId),
      timestamp: Value(timestamp),
    );
  }

  factory InventoryLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryLog(
      id: serializer.fromJson<String>(json['id']),
      materialId: serializer.fromJson<String>(json['materialId']),
      deltaGrams: serializer.fromJson<double>(json['deltaGrams']),
      remainingStockGrams: serializer.fromJson<double>(
        json['remainingStockGrams'],
      ),
      reason: serializer.fromJson<String>(json['reason']),
      referenceBatchId: serializer.fromJson<String?>(json['referenceBatchId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'materialId': serializer.toJson<String>(materialId),
      'deltaGrams': serializer.toJson<double>(deltaGrams),
      'remainingStockGrams': serializer.toJson<double>(remainingStockGrams),
      'reason': serializer.toJson<String>(reason),
      'referenceBatchId': serializer.toJson<String?>(referenceBatchId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  InventoryLog copyWith({
    String? id,
    String? materialId,
    double? deltaGrams,
    double? remainingStockGrams,
    String? reason,
    Value<String?> referenceBatchId = const Value.absent(),
    DateTime? timestamp,
  }) => InventoryLog(
    id: id ?? this.id,
    materialId: materialId ?? this.materialId,
    deltaGrams: deltaGrams ?? this.deltaGrams,
    remainingStockGrams: remainingStockGrams ?? this.remainingStockGrams,
    reason: reason ?? this.reason,
    referenceBatchId: referenceBatchId.present
        ? referenceBatchId.value
        : this.referenceBatchId,
    timestamp: timestamp ?? this.timestamp,
  );
  InventoryLog copyWithCompanion(InventoryLogsCompanion data) {
    return InventoryLog(
      id: data.id.present ? data.id.value : this.id,
      materialId: data.materialId.present
          ? data.materialId.value
          : this.materialId,
      deltaGrams: data.deltaGrams.present
          ? data.deltaGrams.value
          : this.deltaGrams,
      remainingStockGrams: data.remainingStockGrams.present
          ? data.remainingStockGrams.value
          : this.remainingStockGrams,
      reason: data.reason.present ? data.reason.value : this.reason,
      referenceBatchId: data.referenceBatchId.present
          ? data.referenceBatchId.value
          : this.referenceBatchId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryLog(')
          ..write('id: $id, ')
          ..write('materialId: $materialId, ')
          ..write('deltaGrams: $deltaGrams, ')
          ..write('remainingStockGrams: $remainingStockGrams, ')
          ..write('reason: $reason, ')
          ..write('referenceBatchId: $referenceBatchId, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    materialId,
    deltaGrams,
    remainingStockGrams,
    reason,
    referenceBatchId,
    timestamp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryLog &&
          other.id == this.id &&
          other.materialId == this.materialId &&
          other.deltaGrams == this.deltaGrams &&
          other.remainingStockGrams == this.remainingStockGrams &&
          other.reason == this.reason &&
          other.referenceBatchId == this.referenceBatchId &&
          other.timestamp == this.timestamp);
}

class InventoryLogsCompanion extends UpdateCompanion<InventoryLog> {
  final Value<String> id;
  final Value<String> materialId;
  final Value<double> deltaGrams;
  final Value<double> remainingStockGrams;
  final Value<String> reason;
  final Value<String?> referenceBatchId;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const InventoryLogsCompanion({
    this.id = const Value.absent(),
    this.materialId = const Value.absent(),
    this.deltaGrams = const Value.absent(),
    this.remainingStockGrams = const Value.absent(),
    this.reason = const Value.absent(),
    this.referenceBatchId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryLogsCompanion.insert({
    required String id,
    required String materialId,
    required double deltaGrams,
    required double remainingStockGrams,
    required String reason,
    this.referenceBatchId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       materialId = Value(materialId),
       deltaGrams = Value(deltaGrams),
       remainingStockGrams = Value(remainingStockGrams),
       reason = Value(reason);
  static Insertable<InventoryLog> custom({
    Expression<String>? id,
    Expression<String>? materialId,
    Expression<double>? deltaGrams,
    Expression<double>? remainingStockGrams,
    Expression<String>? reason,
    Expression<String>? referenceBatchId,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (materialId != null) 'material_id': materialId,
      if (deltaGrams != null) 'delta_grams': deltaGrams,
      if (remainingStockGrams != null)
        'remaining_stock_grams': remainingStockGrams,
      if (reason != null) 'reason': reason,
      if (referenceBatchId != null) 'reference_batch_id': referenceBatchId,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? materialId,
    Value<double>? deltaGrams,
    Value<double>? remainingStockGrams,
    Value<String>? reason,
    Value<String?>? referenceBatchId,
    Value<DateTime>? timestamp,
    Value<int>? rowid,
  }) {
    return InventoryLogsCompanion(
      id: id ?? this.id,
      materialId: materialId ?? this.materialId,
      deltaGrams: deltaGrams ?? this.deltaGrams,
      remainingStockGrams: remainingStockGrams ?? this.remainingStockGrams,
      reason: reason ?? this.reason,
      referenceBatchId: referenceBatchId ?? this.referenceBatchId,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (materialId.present) {
      map['material_id'] = Variable<String>(materialId.value);
    }
    if (deltaGrams.present) {
      map['delta_grams'] = Variable<double>(deltaGrams.value);
    }
    if (remainingStockGrams.present) {
      map['remaining_stock_grams'] = Variable<double>(
        remainingStockGrams.value,
      );
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (referenceBatchId.present) {
      map['reference_batch_id'] = Variable<String>(referenceBatchId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryLogsCompanion(')
          ..write('id: $id, ')
          ..write('materialId: $materialId, ')
          ..write('deltaGrams: $deltaGrams, ')
          ..write('remainingStockGrams: $remainingStockGrams, ')
          ..write('reason: $reason, ')
          ..write('referenceBatchId: $referenceBatchId, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MaterialsTable materials = $MaterialsTable(this);
  late final $ReadyOilsTable readyOils = $ReadyOilsTable(this);
  late final $FormulasTable formulas = $FormulasTable(this);
  late final $FormulaItemsTable formulaItems = $FormulaItemsTable(this);
  late final $AgingBatchesTable agingBatches = $AgingBatchesTable(this);
  late final $AgingEvaluationsTable agingEvaluations = $AgingEvaluationsTable(
    this,
  );
  late final $InventoryLogsTable inventoryLogs = $InventoryLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    materials,
    readyOils,
    formulas,
    formulaItems,
    agingBatches,
    agingEvaluations,
    inventoryLogs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'formulas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('formula_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'aging_batches',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('aging_evaluations', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MaterialsTableCreateCompanionBuilder = MaterialsCompanion Function({
  required String id,
  required String name,
  Value<String?> casNumber,
  Value<String?> secondaryCas,
  Value<String?> einecs,
  Value<String?> ecNumber,
  Value<String?> fema,
  Value<String?> jecfa,
  Value<String?> flavis,
  Value<String?> iupacName,
  Value<String?> botanicalName,
  Value<String?> imageUrl,
  Value<String?> description,
  Value<String> pyramidNote,
  Value<String> categoriesJson,
  Value<String> odorProfilesJson,
  Value<double?> density,
  Value<double> dilutionPercent,
  Value<String?> defaultSolvent,
  Value<int> intensity,
  Value<double?> relativeImpact,
  Value<String?> odorLife,
  Value<double?> idealMaxPercent,
  Value<String?> molecularWeight,
  Value<String?> molecularFormula,
  Value<String?> flashPoint,
  Value<String?> boilingPoint,
  Value<String?> meltingPoint,
  Value<String?> logP,
  Value<String?> vaporPressure,
  Value<String?> biodegradability,
  Value<double?> renewableCarbonPercent,
  Value<String> hazardPictogramsJson,
  Value<String?> tgscUrl,
  Value<String?> pubchemCid,
  Value<String?> scentreeUrl,
  Value<String?> wikipediaUrl,
  Value<double> stockGrams,
  Value<double> costPerGram,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$MaterialsTableUpdateCompanionBuilder = MaterialsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> casNumber,
  Value<String?> secondaryCas,
  Value<String?> einecs,
  Value<String?> ecNumber,
  Value<String?> fema,
  Value<String?> jecfa,
  Value<String?> flavis,
  Value<String?> iupacName,
  Value<String?> botanicalName,
  Value<String?> imageUrl,
  Value<String?> description,
  Value<String> pyramidNote,
  Value<String> categoriesJson,
  Value<String> odorProfilesJson,
  Value<double?> density,
  Value<double> dilutionPercent,
  Value<String?> defaultSolvent,
  Value<int> intensity,
  Value<double?> relativeImpact,
  Value<String?> odorLife,
  Value<double?> idealMaxPercent,
  Value<String?> molecularWeight,
  Value<String?> molecularFormula,
  Value<String?> flashPoint,
  Value<String?> boilingPoint,
  Value<String?> meltingPoint,
  Value<String?> logP,
  Value<String?> vaporPressure,
  Value<String?> biodegradability,
  Value<double?> renewableCarbonPercent,
  Value<String> hazardPictogramsJson,
  Value<String?> tgscUrl,
  Value<String?> pubchemCid,
  Value<String?> scentreeUrl,
  Value<String?> wikipediaUrl,
  Value<double> stockGrams,
  Value<double> costPerGram,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$MaterialsTableReferences
    extends BaseReferences<_$AppDatabase, $MaterialsTable, Material> {
  $$MaterialsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FormulaItemsTable, List<FormulaItem>>
  _formulaItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.formulaItems,
    aliasName: 'materials__id__formula_items__material_id',
  );

  $$FormulaItemsTableProcessedTableManager get formulaItemsRefs {
    final manager = $$FormulaItemsTableTableManager(
      $_db,
      $_db.formulaItems,
    ).filter((f) => f.materialId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_formulaItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InventoryLogsTable, List<InventoryLog>>
  _inventoryLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.inventoryLogs,
    aliasName: 'materials__id__inventory_logs__material_id',
  );

  $$InventoryLogsTableProcessedTableManager get inventoryLogsRefs {
    final manager = $$InventoryLogsTableTableManager(
      $_db,
      $_db.inventoryLogs,
    ).filter((f) => f.materialId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_inventoryLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MaterialsTableFilterComposer
    extends Composer<_$AppDatabase, $MaterialsTable> {
  $$MaterialsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get casNumber => $composableBuilder(
    column: $table.casNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryCas => $composableBuilder(
    column: $table.secondaryCas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get einecs => $composableBuilder(
    column: $table.einecs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ecNumber => $composableBuilder(
    column: $table.ecNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fema => $composableBuilder(
    column: $table.fema,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jecfa => $composableBuilder(
    column: $table.jecfa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flavis => $composableBuilder(
    column: $table.flavis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iupacName => $composableBuilder(
    column: $table.iupacName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get botanicalName => $composableBuilder(
    column: $table.botanicalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pyramidNote => $composableBuilder(
    column: $table.pyramidNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoriesJson => $composableBuilder(
    column: $table.categoriesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get odorProfilesJson => $composableBuilder(
    column: $table.odorProfilesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get density => $composableBuilder(
    column: $table.density,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dilutionPercent => $composableBuilder(
    column: $table.dilutionPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultSolvent => $composableBuilder(
    column: $table.defaultSolvent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get relativeImpact => $composableBuilder(
    column: $table.relativeImpact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get odorLife => $composableBuilder(
    column: $table.odorLife,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get idealMaxPercent => $composableBuilder(
    column: $table.idealMaxPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get molecularWeight => $composableBuilder(
    column: $table.molecularWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get molecularFormula => $composableBuilder(
    column: $table.molecularFormula,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flashPoint => $composableBuilder(
    column: $table.flashPoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get boilingPoint => $composableBuilder(
    column: $table.boilingPoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meltingPoint => $composableBuilder(
    column: $table.meltingPoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logP => $composableBuilder(
    column: $table.logP,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vaporPressure => $composableBuilder(
    column: $table.vaporPressure,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get biodegradability => $composableBuilder(
    column: $table.biodegradability,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get renewableCarbonPercent => $composableBuilder(
    column: $table.renewableCarbonPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hazardPictogramsJson => $composableBuilder(
    column: $table.hazardPictogramsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tgscUrl => $composableBuilder(
    column: $table.tgscUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pubchemCid => $composableBuilder(
    column: $table.pubchemCid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scentreeUrl => $composableBuilder(
    column: $table.scentreeUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wikipediaUrl => $composableBuilder(
    column: $table.wikipediaUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockGrams => $composableBuilder(
    column: $table.stockGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costPerGram => $composableBuilder(
    column: $table.costPerGram,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> formulaItemsRefs(
    Expression<bool> Function($$FormulaItemsTableFilterComposer f) f,
  ) {
    final $$FormulaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.formulaItems,
      getReferencedColumn: (t) => t.materialId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FormulaItemsTableFilterComposer(
            $db: $db,
            $table: $db.formulaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inventoryLogsRefs(
    Expression<bool> Function($$InventoryLogsTableFilterComposer f) f,
  ) {
    final $$InventoryLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryLogs,
      getReferencedColumn: (t) => t.materialId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryLogsTableFilterComposer(
            $db: $db,
            $table: $db.inventoryLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaterialsTableOrderingComposer
    extends Composer<_$AppDatabase, $MaterialsTable> {
  $$MaterialsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get casNumber => $composableBuilder(
    column: $table.casNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryCas => $composableBuilder(
    column: $table.secondaryCas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get einecs => $composableBuilder(
    column: $table.einecs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ecNumber => $composableBuilder(
    column: $table.ecNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fema => $composableBuilder(
    column: $table.fema,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jecfa => $composableBuilder(
    column: $table.jecfa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flavis => $composableBuilder(
    column: $table.flavis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iupacName => $composableBuilder(
    column: $table.iupacName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get botanicalName => $composableBuilder(
    column: $table.botanicalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pyramidNote => $composableBuilder(
    column: $table.pyramidNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoriesJson => $composableBuilder(
    column: $table.categoriesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get odorProfilesJson => $composableBuilder(
    column: $table.odorProfilesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get density => $composableBuilder(
    column: $table.density,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dilutionPercent => $composableBuilder(
    column: $table.dilutionPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultSolvent => $composableBuilder(
    column: $table.defaultSolvent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get relativeImpact => $composableBuilder(
    column: $table.relativeImpact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get odorLife => $composableBuilder(
    column: $table.odorLife,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get idealMaxPercent => $composableBuilder(
    column: $table.idealMaxPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get molecularWeight => $composableBuilder(
    column: $table.molecularWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get molecularFormula => $composableBuilder(
    column: $table.molecularFormula,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flashPoint => $composableBuilder(
    column: $table.flashPoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get boilingPoint => $composableBuilder(
    column: $table.boilingPoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meltingPoint => $composableBuilder(
    column: $table.meltingPoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logP => $composableBuilder(
    column: $table.logP,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vaporPressure => $composableBuilder(
    column: $table.vaporPressure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get biodegradability => $composableBuilder(
    column: $table.biodegradability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get renewableCarbonPercent => $composableBuilder(
    column: $table.renewableCarbonPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hazardPictogramsJson => $composableBuilder(
    column: $table.hazardPictogramsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tgscUrl => $composableBuilder(
    column: $table.tgscUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pubchemCid => $composableBuilder(
    column: $table.pubchemCid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scentreeUrl => $composableBuilder(
    column: $table.scentreeUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wikipediaUrl => $composableBuilder(
    column: $table.wikipediaUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockGrams => $composableBuilder(
    column: $table.stockGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costPerGram => $composableBuilder(
    column: $table.costPerGram,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MaterialsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaterialsTable> {
  $$MaterialsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get casNumber =>
      $composableBuilder(column: $table.casNumber, builder: (column) => column);

  GeneratedColumn<String> get secondaryCas => $composableBuilder(
    column: $table.secondaryCas,
    builder: (column) => column,
  );

  GeneratedColumn<String> get einecs =>
      $composableBuilder(column: $table.einecs, builder: (column) => column);

  GeneratedColumn<String> get ecNumber =>
      $composableBuilder(column: $table.ecNumber, builder: (column) => column);

  GeneratedColumn<String> get fema =>
      $composableBuilder(column: $table.fema, builder: (column) => column);

  GeneratedColumn<String> get jecfa =>
      $composableBuilder(column: $table.jecfa, builder: (column) => column);

  GeneratedColumn<String> get flavis =>
      $composableBuilder(column: $table.flavis, builder: (column) => column);

  GeneratedColumn<String> get iupacName =>
      $composableBuilder(column: $table.iupacName, builder: (column) => column);

  GeneratedColumn<String> get botanicalName => $composableBuilder(
    column: $table.botanicalName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pyramidNote => $composableBuilder(
    column: $table.pyramidNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoriesJson => $composableBuilder(
    column: $table.categoriesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get odorProfilesJson => $composableBuilder(
    column: $table.odorProfilesJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get density =>
      $composableBuilder(column: $table.density, builder: (column) => column);

  GeneratedColumn<double> get dilutionPercent => $composableBuilder(
    column: $table.dilutionPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultSolvent => $composableBuilder(
    column: $table.defaultSolvent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumn<double> get relativeImpact => $composableBuilder(
    column: $table.relativeImpact,
    builder: (column) => column,
  );

  GeneratedColumn<String> get odorLife =>
      $composableBuilder(column: $table.odorLife, builder: (column) => column);

  GeneratedColumn<double> get idealMaxPercent => $composableBuilder(
    column: $table.idealMaxPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get molecularWeight => $composableBuilder(
    column: $table.molecularWeight,
    builder: (column) => column,
  );

  GeneratedColumn<String> get molecularFormula => $composableBuilder(
    column: $table.molecularFormula,
    builder: (column) => column,
  );

  GeneratedColumn<String> get flashPoint => $composableBuilder(
    column: $table.flashPoint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get boilingPoint => $composableBuilder(
    column: $table.boilingPoint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get meltingPoint => $composableBuilder(
    column: $table.meltingPoint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logP =>
      $composableBuilder(column: $table.logP, builder: (column) => column);

  GeneratedColumn<String> get vaporPressure => $composableBuilder(
    column: $table.vaporPressure,
    builder: (column) => column,
  );

  GeneratedColumn<String> get biodegradability => $composableBuilder(
    column: $table.biodegradability,
    builder: (column) => column,
  );

  GeneratedColumn<double> get renewableCarbonPercent => $composableBuilder(
    column: $table.renewableCarbonPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hazardPictogramsJson => $composableBuilder(
    column: $table.hazardPictogramsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tgscUrl =>
      $composableBuilder(column: $table.tgscUrl, builder: (column) => column);

  GeneratedColumn<String> get pubchemCid => $composableBuilder(
    column: $table.pubchemCid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scentreeUrl => $composableBuilder(
    column: $table.scentreeUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wikipediaUrl => $composableBuilder(
    column: $table.wikipediaUrl,
    builder: (column) => column,
  );

  GeneratedColumn<double> get stockGrams => $composableBuilder(
    column: $table.stockGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get costPerGram => $composableBuilder(
    column: $table.costPerGram,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> formulaItemsRefs<T extends Object>(
    Expression<T> Function($$FormulaItemsTableAnnotationComposer a) f,
  ) {
    final $$FormulaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.formulaItems,
      getReferencedColumn: (t) => t.materialId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FormulaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.formulaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inventoryLogsRefs<T extends Object>(
    Expression<T> Function($$InventoryLogsTableAnnotationComposer a) f,
  ) {
    final $$InventoryLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inventoryLogs,
      getReferencedColumn: (t) => t.materialId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InventoryLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.inventoryLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaterialsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaterialsTable,
          Material,
          $$MaterialsTableFilterComposer,
          $$MaterialsTableOrderingComposer,
          $$MaterialsTableAnnotationComposer,
          $$MaterialsTableCreateCompanionBuilder,
          $$MaterialsTableUpdateCompanionBuilder,
          (Material, $$MaterialsTableReferences),
          Material,
          PrefetchHooks Function({
            bool formulaItemsRefs,
            bool inventoryLogsRefs,
          })
        > {
  $$MaterialsTableTableManager(_$AppDatabase db, $MaterialsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaterialsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaterialsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaterialsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> casNumber = const Value.absent(),
                Value<String?> secondaryCas = const Value.absent(),
                Value<String?> einecs = const Value.absent(),
                Value<String?> ecNumber = const Value.absent(),
                Value<String?> fema = const Value.absent(),
                Value<String?> jecfa = const Value.absent(),
                Value<String?> flavis = const Value.absent(),
                Value<String?> iupacName = const Value.absent(),
                Value<String?> botanicalName = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> pyramidNote = const Value.absent(),
                Value<String> categoriesJson = const Value.absent(),
                Value<String> odorProfilesJson = const Value.absent(),
                Value<double?> density = const Value.absent(),
                Value<double> dilutionPercent = const Value.absent(),
                Value<String?> defaultSolvent = const Value.absent(),
                Value<int> intensity = const Value.absent(),
                Value<double?> relativeImpact = const Value.absent(),
                Value<String?> odorLife = const Value.absent(),
                Value<double?> idealMaxPercent = const Value.absent(),
                Value<String?> molecularWeight = const Value.absent(),
                Value<String?> molecularFormula = const Value.absent(),
                Value<String?> flashPoint = const Value.absent(),
                Value<String?> boilingPoint = const Value.absent(),
                Value<String?> meltingPoint = const Value.absent(),
                Value<String?> logP = const Value.absent(),
                Value<String?> vaporPressure = const Value.absent(),
                Value<String?> biodegradability = const Value.absent(),
                Value<double?> renewableCarbonPercent = const Value.absent(),
                Value<String> hazardPictogramsJson = const Value.absent(),
                Value<String?> tgscUrl = const Value.absent(),
                Value<String?> pubchemCid = const Value.absent(),
                Value<String?> scentreeUrl = const Value.absent(),
                Value<String?> wikipediaUrl = const Value.absent(),
                Value<double> stockGrams = const Value.absent(),
                Value<double> costPerGram = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaterialsCompanion(
                id: id,
                name: name,
                casNumber: casNumber,
                secondaryCas: secondaryCas,
                einecs: einecs,
                ecNumber: ecNumber,
                fema: fema,
                jecfa: jecfa,
                flavis: flavis,
                iupacName: iupacName,
                botanicalName: botanicalName,
                imageUrl: imageUrl,
                description: description,
                pyramidNote: pyramidNote,
                categoriesJson: categoriesJson,
                odorProfilesJson: odorProfilesJson,
                density: density,
                dilutionPercent: dilutionPercent,
                defaultSolvent: defaultSolvent,
                intensity: intensity,
                relativeImpact: relativeImpact,
                odorLife: odorLife,
                idealMaxPercent: idealMaxPercent,
                molecularWeight: molecularWeight,
                molecularFormula: molecularFormula,
                flashPoint: flashPoint,
                boilingPoint: boilingPoint,
                meltingPoint: meltingPoint,
                logP: logP,
                vaporPressure: vaporPressure,
                biodegradability: biodegradability,
                renewableCarbonPercent: renewableCarbonPercent,
                hazardPictogramsJson: hazardPictogramsJson,
                tgscUrl: tgscUrl,
                pubchemCid: pubchemCid,
                scentreeUrl: scentreeUrl,
                wikipediaUrl: wikipediaUrl,
                stockGrams: stockGrams,
                costPerGram: costPerGram,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> casNumber = const Value.absent(),
                Value<String?> secondaryCas = const Value.absent(),
                Value<String?> einecs = const Value.absent(),
                Value<String?> ecNumber = const Value.absent(),
                Value<String?> fema = const Value.absent(),
                Value<String?> jecfa = const Value.absent(),
                Value<String?> flavis = const Value.absent(),
                Value<String?> iupacName = const Value.absent(),
                Value<String?> botanicalName = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> pyramidNote = const Value.absent(),
                Value<String> categoriesJson = const Value.absent(),
                Value<String> odorProfilesJson = const Value.absent(),
                Value<double?> density = const Value.absent(),
                Value<double> dilutionPercent = const Value.absent(),
                Value<String?> defaultSolvent = const Value.absent(),
                Value<int> intensity = const Value.absent(),
                Value<double?> relativeImpact = const Value.absent(),
                Value<String?> odorLife = const Value.absent(),
                Value<double?> idealMaxPercent = const Value.absent(),
                Value<String?> molecularWeight = const Value.absent(),
                Value<String?> molecularFormula = const Value.absent(),
                Value<String?> flashPoint = const Value.absent(),
                Value<String?> boilingPoint = const Value.absent(),
                Value<String?> meltingPoint = const Value.absent(),
                Value<String?> logP = const Value.absent(),
                Value<String?> vaporPressure = const Value.absent(),
                Value<String?> biodegradability = const Value.absent(),
                Value<double?> renewableCarbonPercent = const Value.absent(),
                Value<String> hazardPictogramsJson = const Value.absent(),
                Value<String?> tgscUrl = const Value.absent(),
                Value<String?> pubchemCid = const Value.absent(),
                Value<String?> scentreeUrl = const Value.absent(),
                Value<String?> wikipediaUrl = const Value.absent(),
                Value<double> stockGrams = const Value.absent(),
                Value<double> costPerGram = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaterialsCompanion.insert(
                id: id,
                name: name,
                casNumber: casNumber,
                secondaryCas: secondaryCas,
                einecs: einecs,
                ecNumber: ecNumber,
                fema: fema,
                jecfa: jecfa,
                flavis: flavis,
                iupacName: iupacName,
                botanicalName: botanicalName,
                imageUrl: imageUrl,
                description: description,
                pyramidNote: pyramidNote,
                categoriesJson: categoriesJson,
                odorProfilesJson: odorProfilesJson,
                density: density,
                dilutionPercent: dilutionPercent,
                defaultSolvent: defaultSolvent,
                intensity: intensity,
                relativeImpact: relativeImpact,
                odorLife: odorLife,
                idealMaxPercent: idealMaxPercent,
                molecularWeight: molecularWeight,
                molecularFormula: molecularFormula,
                flashPoint: flashPoint,
                boilingPoint: boilingPoint,
                meltingPoint: meltingPoint,
                logP: logP,
                vaporPressure: vaporPressure,
                biodegradability: biodegradability,
                renewableCarbonPercent: renewableCarbonPercent,
                hazardPictogramsJson: hazardPictogramsJson,
                tgscUrl: tgscUrl,
                pubchemCid: pubchemCid,
                scentreeUrl: scentreeUrl,
                wikipediaUrl: wikipediaUrl,
                stockGrams: stockGrams,
                costPerGram: costPerGram,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MaterialsTable, Material>(table),
                  $$MaterialsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({formulaItemsRefs = false, inventoryLogsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (formulaItemsRefs) db.formulaItems,
                    if (inventoryLogsRefs) db.inventoryLogs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (formulaItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          Material,
                          $MaterialsTable,
                          FormulaItem,
                          $FormulaItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$MaterialsTableReferences
                              ._formulaItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MaterialsTableReferences(
                                db,
                                table,
                                p0,
                              ).formulaItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'material_id',
                          typedResults: items,
                        ),
                      if (inventoryLogsRefs)
                        await $_getPrefetchedDataByColumns<
                          Material,
                          $MaterialsTable,
                          InventoryLog,
                          $InventoryLogsTable
                        >(
                          currentTable: table,
                          referencedTable: $$MaterialsTableReferences
                              ._inventoryLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MaterialsTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryLogsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'material_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MaterialsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaterialsTable,
      Material,
      $$MaterialsTableFilterComposer,
      $$MaterialsTableOrderingComposer,
      $$MaterialsTableAnnotationComposer,
      $$MaterialsTableCreateCompanionBuilder,
      $$MaterialsTableUpdateCompanionBuilder,
      (Material, $$MaterialsTableReferences),
      Material,
      PrefetchHooks Function({bool formulaItemsRefs, bool inventoryLogsRefs})
    >;
typedef $$ReadyOilsTableCreateCompanionBuilder = ReadyOilsCompanion Function({
  required String id,
  required String name,
  Value<String?> supplier,
  Value<String?> lotNumber,
  Value<double> stockGrams,
  Value<double> costPerGram,
  Value<double?> recommendedDosagePercent,
  Value<double?> ifraMaxPercent,
  Value<double?> flashPoint,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$ReadyOilsTableUpdateCompanionBuilder = ReadyOilsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> supplier,
  Value<String?> lotNumber,
  Value<double> stockGrams,
  Value<double> costPerGram,
  Value<double?> recommendedDosagePercent,
  Value<double?> ifraMaxPercent,
  Value<double?> flashPoint,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ReadyOilsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadyOilsTable> {
  $$ReadyOilsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplier => $composableBuilder(
    column: $table.supplier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lotNumber => $composableBuilder(
    column: $table.lotNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockGrams => $composableBuilder(
    column: $table.stockGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costPerGram => $composableBuilder(
    column: $table.costPerGram,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get recommendedDosagePercent => $composableBuilder(
    column: $table.recommendedDosagePercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ifraMaxPercent => $composableBuilder(
    column: $table.ifraMaxPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get flashPoint => $composableBuilder(
    column: $table.flashPoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReadyOilsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadyOilsTable> {
  $$ReadyOilsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplier => $composableBuilder(
    column: $table.supplier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lotNumber => $composableBuilder(
    column: $table.lotNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockGrams => $composableBuilder(
    column: $table.stockGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costPerGram => $composableBuilder(
    column: $table.costPerGram,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get recommendedDosagePercent => $composableBuilder(
    column: $table.recommendedDosagePercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ifraMaxPercent => $composableBuilder(
    column: $table.ifraMaxPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get flashPoint => $composableBuilder(
    column: $table.flashPoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadyOilsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadyOilsTable> {
  $$ReadyOilsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get supplier =>
      $composableBuilder(column: $table.supplier, builder: (column) => column);

  GeneratedColumn<String> get lotNumber =>
      $composableBuilder(column: $table.lotNumber, builder: (column) => column);

  GeneratedColumn<double> get stockGrams => $composableBuilder(
    column: $table.stockGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get costPerGram => $composableBuilder(
    column: $table.costPerGram,
    builder: (column) => column,
  );

  GeneratedColumn<double> get recommendedDosagePercent => $composableBuilder(
    column: $table.recommendedDosagePercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ifraMaxPercent => $composableBuilder(
    column: $table.ifraMaxPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get flashPoint => $composableBuilder(
    column: $table.flashPoint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ReadyOilsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadyOilsTable,
          ReadyOil,
          $$ReadyOilsTableFilterComposer,
          $$ReadyOilsTableOrderingComposer,
          $$ReadyOilsTableAnnotationComposer,
          $$ReadyOilsTableCreateCompanionBuilder,
          $$ReadyOilsTableUpdateCompanionBuilder,
          (ReadyOil, BaseReferences<_$AppDatabase, $ReadyOilsTable, ReadyOil>),
          ReadyOil,
          PrefetchHooks Function()
        > {
  $$ReadyOilsTableTableManager(_$AppDatabase db, $ReadyOilsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadyOilsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadyOilsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadyOilsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> supplier = const Value.absent(),
                Value<String?> lotNumber = const Value.absent(),
                Value<double> stockGrams = const Value.absent(),
                Value<double> costPerGram = const Value.absent(),
                Value<double?> recommendedDosagePercent = const Value.absent(),
                Value<double?> ifraMaxPercent = const Value.absent(),
                Value<double?> flashPoint = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadyOilsCompanion(
                id: id,
                name: name,
                supplier: supplier,
                lotNumber: lotNumber,
                stockGrams: stockGrams,
                costPerGram: costPerGram,
                recommendedDosagePercent: recommendedDosagePercent,
                ifraMaxPercent: ifraMaxPercent,
                flashPoint: flashPoint,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> supplier = const Value.absent(),
                Value<String?> lotNumber = const Value.absent(),
                Value<double> stockGrams = const Value.absent(),
                Value<double> costPerGram = const Value.absent(),
                Value<double?> recommendedDosagePercent = const Value.absent(),
                Value<double?> ifraMaxPercent = const Value.absent(),
                Value<double?> flashPoint = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadyOilsCompanion.insert(
                id: id,
                name: name,
                supplier: supplier,
                lotNumber: lotNumber,
                stockGrams: stockGrams,
                costPerGram: costPerGram,
                recommendedDosagePercent: recommendedDosagePercent,
                ifraMaxPercent: ifraMaxPercent,
                flashPoint: flashPoint,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReadyOilsTable, ReadyOil>(table),
                  BaseReferences<_$AppDatabase, $ReadyOilsTable, ReadyOil>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReadyOilsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadyOilsTable,
      ReadyOil,
      $$ReadyOilsTableFilterComposer,
      $$ReadyOilsTableOrderingComposer,
      $$ReadyOilsTableAnnotationComposer,
      $$ReadyOilsTableCreateCompanionBuilder,
      $$ReadyOilsTableUpdateCompanionBuilder,
      (ReadyOil, BaseReferences<_$AppDatabase, $ReadyOilsTable, ReadyOil>),
      ReadyOil,
      PrefetchHooks Function()
    >;
typedef $$FormulasTableCreateCompanionBuilder = FormulasCompanion Function({
  required String id,
  required String name,
  Value<String> version,
  Value<String?> description,
  Value<double> targetConcentrationPercent,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$FormulasTableUpdateCompanionBuilder = FormulasCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> version,
  Value<String?> description,
  Value<double> targetConcentrationPercent,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$FormulasTableReferences
    extends BaseReferences<_$AppDatabase, $FormulasTable, Formula> {
  $$FormulasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FormulaItemsTable, List<FormulaItem>>
  _formulaItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.formulaItems,
    aliasName: 'formulas__id__formula_items__formula_id',
  );

  $$FormulaItemsTableProcessedTableManager get formulaItemsRefs {
    final manager = $$FormulaItemsTableTableManager(
      $_db,
      $_db.formulaItems,
    ).filter((f) => f.formulaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_formulaItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FormulasTableFilterComposer
    extends Composer<_$AppDatabase, $FormulasTable> {
  $$FormulasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetConcentrationPercent => $composableBuilder(
    column: $table.targetConcentrationPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> formulaItemsRefs(
    Expression<bool> Function($$FormulaItemsTableFilterComposer f) f,
  ) {
    final $$FormulaItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.formulaItems,
      getReferencedColumn: (t) => t.formulaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FormulaItemsTableFilterComposer(
            $db: $db,
            $table: $db.formulaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FormulasTableOrderingComposer
    extends Composer<_$AppDatabase, $FormulasTable> {
  $$FormulasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetConcentrationPercent => $composableBuilder(
    column: $table.targetConcentrationPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FormulasTableAnnotationComposer
    extends Composer<_$AppDatabase, $FormulasTable> {
  $$FormulasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetConcentrationPercent => $composableBuilder(
    column: $table.targetConcentrationPercent,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> formulaItemsRefs<T extends Object>(
    Expression<T> Function($$FormulaItemsTableAnnotationComposer a) f,
  ) {
    final $$FormulaItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.formulaItems,
      getReferencedColumn: (t) => t.formulaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FormulaItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.formulaItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FormulasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FormulasTable,
          Formula,
          $$FormulasTableFilterComposer,
          $$FormulasTableOrderingComposer,
          $$FormulasTableAnnotationComposer,
          $$FormulasTableCreateCompanionBuilder,
          $$FormulasTableUpdateCompanionBuilder,
          (Formula, $$FormulasTableReferences),
          Formula,
          PrefetchHooks Function({bool formulaItemsRefs})
        > {
  $$FormulasTableTableManager(_$AppDatabase db, $FormulasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FormulasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FormulasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FormulasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> version = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> targetConcentrationPercent = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FormulasCompanion(
                id: id,
                name: name,
                version: version,
                description: description,
                targetConcentrationPercent: targetConcentrationPercent,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> version = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> targetConcentrationPercent = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FormulasCompanion.insert(
                id: id,
                name: name,
                version: version,
                description: description,
                targetConcentrationPercent: targetConcentrationPercent,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FormulasTable, Formula>(table),
                  $$FormulasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({formulaItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (formulaItemsRefs) db.formulaItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (formulaItemsRefs)
                    await $_getPrefetchedDataByColumns<
                      Formula,
                      $FormulasTable,
                      FormulaItem,
                      $FormulaItemsTable
                    >(
                      currentTable: table,
                      referencedTable: $$FormulasTableReferences
                          ._formulaItemsRefsTable(db),
                      managerFromTypedResult: (p0) => $$FormulasTableReferences(
                        db,
                        table,
                        p0,
                      ).formulaItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'formula_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FormulasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FormulasTable,
      Formula,
      $$FormulasTableFilterComposer,
      $$FormulasTableOrderingComposer,
      $$FormulasTableAnnotationComposer,
      $$FormulasTableCreateCompanionBuilder,
      $$FormulasTableUpdateCompanionBuilder,
      (Formula, $$FormulasTableReferences),
      Formula,
      PrefetchHooks Function({bool formulaItemsRefs})
    >;
typedef $$FormulaItemsTableCreateCompanionBuilder =
    FormulaItemsCompanion Function({
      required String id,
      required String formulaId,
      required String materialId,
      required double partsPerThousand,
      Value<double> specifiedDilutionPercent,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$FormulaItemsTableUpdateCompanionBuilder =
    FormulaItemsCompanion Function({
      Value<String> id,
      Value<String> formulaId,
      Value<String> materialId,
      Value<double> partsPerThousand,
      Value<double> specifiedDilutionPercent,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$FormulaItemsTableReferences
    extends BaseReferences<_$AppDatabase, $FormulaItemsTable, FormulaItem> {
  $$FormulaItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FormulasTable _formulaIdTable(_$AppDatabase db) =>
      db.formulas.createAlias('formula_items__formula_id__formulas__id');

  $$FormulasTableProcessedTableManager get formulaId {
    final $_column = $_itemColumn<String>('formula_id')!;

    final manager = $$FormulasTableTableManager(
      $_db,
      $_db.formulas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_formulaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MaterialsTable _materialIdTable(_$AppDatabase db) =>
      db.materials.createAlias('formula_items__material_id__materials__id');

  $$MaterialsTableProcessedTableManager get materialId {
    final $_column = $_itemColumn<String>('material_id')!;

    final manager = $$MaterialsTableTableManager(
      $_db,
      $_db.materials,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_materialIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FormulaItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FormulaItemsTable> {
  $$FormulaItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get partsPerThousand => $composableBuilder(
    column: $table.partsPerThousand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get specifiedDilutionPercent => $composableBuilder(
    column: $table.specifiedDilutionPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$FormulasTableFilterComposer get formulaId {
    final $$FormulasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.formulaId,
      referencedTable: $db.formulas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FormulasTableFilterComposer(
            $db: $db,
            $table: $db.formulas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaterialsTableFilterComposer get materialId {
    final $$MaterialsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.materialId,
      referencedTable: $db.materials,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaterialsTableFilterComposer(
            $db: $db,
            $table: $db.materials,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FormulaItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FormulaItemsTable> {
  $$FormulaItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get partsPerThousand => $composableBuilder(
    column: $table.partsPerThousand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get specifiedDilutionPercent => $composableBuilder(
    column: $table.specifiedDilutionPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$FormulasTableOrderingComposer get formulaId {
    final $$FormulasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.formulaId,
      referencedTable: $db.formulas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FormulasTableOrderingComposer(
            $db: $db,
            $table: $db.formulas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaterialsTableOrderingComposer get materialId {
    final $$MaterialsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.materialId,
      referencedTable: $db.materials,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaterialsTableOrderingComposer(
            $db: $db,
            $table: $db.materials,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FormulaItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FormulaItemsTable> {
  $$FormulaItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get partsPerThousand => $composableBuilder(
    column: $table.partsPerThousand,
    builder: (column) => column,
  );

  GeneratedColumn<double> get specifiedDilutionPercent => $composableBuilder(
    column: $table.specifiedDilutionPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$FormulasTableAnnotationComposer get formulaId {
    final $$FormulasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.formulaId,
      referencedTable: $db.formulas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FormulasTableAnnotationComposer(
            $db: $db,
            $table: $db.formulas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaterialsTableAnnotationComposer get materialId {
    final $$MaterialsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.materialId,
      referencedTable: $db.materials,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaterialsTableAnnotationComposer(
            $db: $db,
            $table: $db.materials,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FormulaItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FormulaItemsTable,
          FormulaItem,
          $$FormulaItemsTableFilterComposer,
          $$FormulaItemsTableOrderingComposer,
          $$FormulaItemsTableAnnotationComposer,
          $$FormulaItemsTableCreateCompanionBuilder,
          $$FormulaItemsTableUpdateCompanionBuilder,
          (FormulaItem, $$FormulaItemsTableReferences),
          FormulaItem,
          PrefetchHooks Function({bool formulaId, bool materialId})
        > {
  $$FormulaItemsTableTableManager(_$AppDatabase db, $FormulaItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FormulaItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FormulaItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FormulaItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> formulaId = const Value.absent(),
                Value<String> materialId = const Value.absent(),
                Value<double> partsPerThousand = const Value.absent(),
                Value<double> specifiedDilutionPercent = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FormulaItemsCompanion(
                id: id,
                formulaId: formulaId,
                materialId: materialId,
                partsPerThousand: partsPerThousand,
                specifiedDilutionPercent: specifiedDilutionPercent,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String formulaId,
                required String materialId,
                required double partsPerThousand,
                Value<double> specifiedDilutionPercent = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FormulaItemsCompanion.insert(
                id: id,
                formulaId: formulaId,
                materialId: materialId,
                partsPerThousand: partsPerThousand,
                specifiedDilutionPercent: specifiedDilutionPercent,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FormulaItemsTable, FormulaItem>(table),
                  $$FormulaItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({formulaId = false, materialId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (formulaId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.formulaId,
                        referencedTable: $$FormulaItemsTableReferences
                            ._formulaIdTable(db),
                        referencedColumn: $$FormulaItemsTableReferences
                            ._formulaIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (materialId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.materialId,
                        referencedTable: $$FormulaItemsTableReferences
                            ._materialIdTable(db),
                        referencedColumn: $$FormulaItemsTableReferences
                            ._materialIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FormulaItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FormulaItemsTable,
      FormulaItem,
      $$FormulaItemsTableFilterComposer,
      $$FormulaItemsTableOrderingComposer,
      $$FormulaItemsTableAnnotationComposer,
      $$FormulaItemsTableCreateCompanionBuilder,
      $$FormulaItemsTableUpdateCompanionBuilder,
      (FormulaItem, $$FormulaItemsTableReferences),
      FormulaItem,
      PrefetchHooks Function({bool formulaId, bool materialId})
    >;
typedef $$AgingBatchesTableCreateCompanionBuilder =
    AgingBatchesCompanion Function({
      required String id,
      required String batchNumber,
      required String name,
      required String sourceType,
      required String sourceId,
      required String stage,
      required double totalWeightGrams,
      required double concentrationPercent,
      Value<String?> alcoholType,
      Value<double> waterPercent,
      required DateTime startDate,
      Value<int> targetAgingDays,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$AgingBatchesTableUpdateCompanionBuilder =
    AgingBatchesCompanion Function({
      Value<String> id,
      Value<String> batchNumber,
      Value<String> name,
      Value<String> sourceType,
      Value<String> sourceId,
      Value<String> stage,
      Value<double> totalWeightGrams,
      Value<double> concentrationPercent,
      Value<String?> alcoholType,
      Value<double> waterPercent,
      Value<DateTime> startDate,
      Value<int> targetAgingDays,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$AgingBatchesTableReferences
    extends BaseReferences<_$AppDatabase, $AgingBatchesTable, AgingBatche> {
  $$AgingBatchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AgingEvaluationsTable, List<AgingEvaluation>>
  _agingEvaluationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.agingEvaluations,
    aliasName: 'aging_batches__id__aging_evaluations__batch_id',
  );

  $$AgingEvaluationsTableProcessedTableManager get agingEvaluationsRefs {
    final manager = $$AgingEvaluationsTableTableManager(
      $_db,
      $_db.agingEvaluations,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _agingEvaluationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AgingBatchesTableFilterComposer
    extends Composer<_$AppDatabase, $AgingBatchesTable> {
  $$AgingBatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalWeightGrams => $composableBuilder(
    column: $table.totalWeightGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get concentrationPercent => $composableBuilder(
    column: $table.concentrationPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alcoholType => $composableBuilder(
    column: $table.alcoholType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterPercent => $composableBuilder(
    column: $table.waterPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetAgingDays => $composableBuilder(
    column: $table.targetAgingDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> agingEvaluationsRefs(
    Expression<bool> Function($$AgingEvaluationsTableFilterComposer f) f,
  ) {
    final $$AgingEvaluationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.agingEvaluations,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgingEvaluationsTableFilterComposer(
            $db: $db,
            $table: $db.agingEvaluations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AgingBatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $AgingBatchesTable> {
  $$AgingBatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalWeightGrams => $composableBuilder(
    column: $table.totalWeightGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get concentrationPercent => $composableBuilder(
    column: $table.concentrationPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alcoholType => $composableBuilder(
    column: $table.alcoholType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterPercent => $composableBuilder(
    column: $table.waterPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetAgingDays => $composableBuilder(
    column: $table.targetAgingDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AgingBatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AgingBatchesTable> {
  $$AgingBatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<double> get totalWeightGrams => $composableBuilder(
    column: $table.totalWeightGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get concentrationPercent => $composableBuilder(
    column: $table.concentrationPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get alcoholType => $composableBuilder(
    column: $table.alcoholType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waterPercent => $composableBuilder(
    column: $table.waterPercent,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get targetAgingDays => $composableBuilder(
    column: $table.targetAgingDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> agingEvaluationsRefs<T extends Object>(
    Expression<T> Function($$AgingEvaluationsTableAnnotationComposer a) f,
  ) {
    final $$AgingEvaluationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.agingEvaluations,
      getReferencedColumn: (t) => t.batchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgingEvaluationsTableAnnotationComposer(
            $db: $db,
            $table: $db.agingEvaluations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AgingBatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AgingBatchesTable,
          AgingBatche,
          $$AgingBatchesTableFilterComposer,
          $$AgingBatchesTableOrderingComposer,
          $$AgingBatchesTableAnnotationComposer,
          $$AgingBatchesTableCreateCompanionBuilder,
          $$AgingBatchesTableUpdateCompanionBuilder,
          (AgingBatche, $$AgingBatchesTableReferences),
          AgingBatche,
          PrefetchHooks Function({bool agingEvaluationsRefs})
        > {
  $$AgingBatchesTableTableManager(_$AppDatabase db, $AgingBatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgingBatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgingBatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgingBatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> batchNumber = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<String> stage = const Value.absent(),
                Value<double> totalWeightGrams = const Value.absent(),
                Value<double> concentrationPercent = const Value.absent(),
                Value<String?> alcoholType = const Value.absent(),
                Value<double> waterPercent = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<int> targetAgingDays = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgingBatchesCompanion(
                id: id,
                batchNumber: batchNumber,
                name: name,
                sourceType: sourceType,
                sourceId: sourceId,
                stage: stage,
                totalWeightGrams: totalWeightGrams,
                concentrationPercent: concentrationPercent,
                alcoholType: alcoholType,
                waterPercent: waterPercent,
                startDate: startDate,
                targetAgingDays: targetAgingDays,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String batchNumber,
                required String name,
                required String sourceType,
                required String sourceId,
                required String stage,
                required double totalWeightGrams,
                required double concentrationPercent,
                Value<String?> alcoholType = const Value.absent(),
                Value<double> waterPercent = const Value.absent(),
                required DateTime startDate,
                Value<int> targetAgingDays = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgingBatchesCompanion.insert(
                id: id,
                batchNumber: batchNumber,
                name: name,
                sourceType: sourceType,
                sourceId: sourceId,
                stage: stage,
                totalWeightGrams: totalWeightGrams,
                concentrationPercent: concentrationPercent,
                alcoholType: alcoholType,
                waterPercent: waterPercent,
                startDate: startDate,
                targetAgingDays: targetAgingDays,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AgingBatchesTable, AgingBatche>(table),
                  $$AgingBatchesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({agingEvaluationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (agingEvaluationsRefs) db.agingEvaluations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (agingEvaluationsRefs)
                    await $_getPrefetchedDataByColumns<
                      AgingBatche,
                      $AgingBatchesTable,
                      AgingEvaluation,
                      $AgingEvaluationsTable
                    >(
                      currentTable: table,
                      referencedTable: $$AgingBatchesTableReferences
                          ._agingEvaluationsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AgingBatchesTableReferences(
                            db,
                            table,
                            p0,
                          ).agingEvaluationsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'batch_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AgingBatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AgingBatchesTable,
      AgingBatche,
      $$AgingBatchesTableFilterComposer,
      $$AgingBatchesTableOrderingComposer,
      $$AgingBatchesTableAnnotationComposer,
      $$AgingBatchesTableCreateCompanionBuilder,
      $$AgingBatchesTableUpdateCompanionBuilder,
      (AgingBatche, $$AgingBatchesTableReferences),
      AgingBatche,
      PrefetchHooks Function({bool agingEvaluationsRefs})
    >;
typedef $$AgingEvaluationsTableCreateCompanionBuilder =
    AgingEvaluationsCompanion Function({
      required String id,
      required String batchId,
      required DateTime evaluationDate,
      required int dayNumber,
      required String clarity,
      required String colorDescription,
      required int alcoholSoftness,
      required int harmonyScore,
      Value<String?> perfumerNotes,
      Value<bool> isChillFiltered,
      Value<int> rowid,
    });
typedef $$AgingEvaluationsTableUpdateCompanionBuilder =
    AgingEvaluationsCompanion Function({
      Value<String> id,
      Value<String> batchId,
      Value<DateTime> evaluationDate,
      Value<int> dayNumber,
      Value<String> clarity,
      Value<String> colorDescription,
      Value<int> alcoholSoftness,
      Value<int> harmonyScore,
      Value<String?> perfumerNotes,
      Value<bool> isChillFiltered,
      Value<int> rowid,
    });

final class $$AgingEvaluationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $AgingEvaluationsTable, AgingEvaluation> {
  $$AgingEvaluationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AgingBatchesTable _batchIdTable(_$AppDatabase db) => db.agingBatches
      .createAlias('aging_evaluations__batch_id__aging_batches__id');

  $$AgingBatchesTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<String>('batch_id')!;

    final manager = $$AgingBatchesTableTableManager(
      $_db,
      $_db.agingBatches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AgingEvaluationsTableFilterComposer
    extends Composer<_$AppDatabase, $AgingEvaluationsTable> {
  $$AgingEvaluationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get evaluationDate => $composableBuilder(
    column: $table.evaluationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clarity => $composableBuilder(
    column: $table.clarity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorDescription => $composableBuilder(
    column: $table.colorDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alcoholSoftness => $composableBuilder(
    column: $table.alcoholSoftness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get harmonyScore => $composableBuilder(
    column: $table.harmonyScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get perfumerNotes => $composableBuilder(
    column: $table.perfumerNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isChillFiltered => $composableBuilder(
    column: $table.isChillFiltered,
    builder: (column) => ColumnFilters(column),
  );

  $$AgingBatchesTableFilterComposer get batchId {
    final $$AgingBatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.agingBatches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgingBatchesTableFilterComposer(
            $db: $db,
            $table: $db.agingBatches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AgingEvaluationsTableOrderingComposer
    extends Composer<_$AppDatabase, $AgingEvaluationsTable> {
  $$AgingEvaluationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get evaluationDate => $composableBuilder(
    column: $table.evaluationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clarity => $composableBuilder(
    column: $table.clarity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorDescription => $composableBuilder(
    column: $table.colorDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alcoholSoftness => $composableBuilder(
    column: $table.alcoholSoftness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get harmonyScore => $composableBuilder(
    column: $table.harmonyScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get perfumerNotes => $composableBuilder(
    column: $table.perfumerNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isChillFiltered => $composableBuilder(
    column: $table.isChillFiltered,
    builder: (column) => ColumnOrderings(column),
  );

  $$AgingBatchesTableOrderingComposer get batchId {
    final $$AgingBatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.agingBatches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgingBatchesTableOrderingComposer(
            $db: $db,
            $table: $db.agingBatches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AgingEvaluationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AgingEvaluationsTable> {
  $$AgingEvaluationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get evaluationDate => $composableBuilder(
    column: $table.evaluationDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dayNumber =>
      $composableBuilder(column: $table.dayNumber, builder: (column) => column);

  GeneratedColumn<String> get clarity =>
      $composableBuilder(column: $table.clarity, builder: (column) => column);

  GeneratedColumn<String> get colorDescription => $composableBuilder(
    column: $table.colorDescription,
    builder: (column) => column,
  );

  GeneratedColumn<int> get alcoholSoftness => $composableBuilder(
    column: $table.alcoholSoftness,
    builder: (column) => column,
  );

  GeneratedColumn<int> get harmonyScore => $composableBuilder(
    column: $table.harmonyScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get perfumerNotes => $composableBuilder(
    column: $table.perfumerNotes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isChillFiltered => $composableBuilder(
    column: $table.isChillFiltered,
    builder: (column) => column,
  );

  $$AgingBatchesTableAnnotationComposer get batchId {
    final $$AgingBatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.agingBatches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AgingBatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.agingBatches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AgingEvaluationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AgingEvaluationsTable,
          AgingEvaluation,
          $$AgingEvaluationsTableFilterComposer,
          $$AgingEvaluationsTableOrderingComposer,
          $$AgingEvaluationsTableAnnotationComposer,
          $$AgingEvaluationsTableCreateCompanionBuilder,
          $$AgingEvaluationsTableUpdateCompanionBuilder,
          (AgingEvaluation, $$AgingEvaluationsTableReferences),
          AgingEvaluation,
          PrefetchHooks Function({bool batchId})
        > {
  $$AgingEvaluationsTableTableManager(
    _$AppDatabase db,
    $AgingEvaluationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgingEvaluationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgingEvaluationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgingEvaluationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> batchId = const Value.absent(),
                Value<DateTime> evaluationDate = const Value.absent(),
                Value<int> dayNumber = const Value.absent(),
                Value<String> clarity = const Value.absent(),
                Value<String> colorDescription = const Value.absent(),
                Value<int> alcoholSoftness = const Value.absent(),
                Value<int> harmonyScore = const Value.absent(),
                Value<String?> perfumerNotes = const Value.absent(),
                Value<bool> isChillFiltered = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgingEvaluationsCompanion(
                id: id,
                batchId: batchId,
                evaluationDate: evaluationDate,
                dayNumber: dayNumber,
                clarity: clarity,
                colorDescription: colorDescription,
                alcoholSoftness: alcoholSoftness,
                harmonyScore: harmonyScore,
                perfumerNotes: perfumerNotes,
                isChillFiltered: isChillFiltered,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String batchId,
                required DateTime evaluationDate,
                required int dayNumber,
                required String clarity,
                required String colorDescription,
                required int alcoholSoftness,
                required int harmonyScore,
                Value<String?> perfumerNotes = const Value.absent(),
                Value<bool> isChillFiltered = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AgingEvaluationsCompanion.insert(
                id: id,
                batchId: batchId,
                evaluationDate: evaluationDate,
                dayNumber: dayNumber,
                clarity: clarity,
                colorDescription: colorDescription,
                alcoholSoftness: alcoholSoftness,
                harmonyScore: harmonyScore,
                perfumerNotes: perfumerNotes,
                isChillFiltered: isChillFiltered,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AgingEvaluationsTable, AgingEvaluation>(table),
                  $$AgingEvaluationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({batchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (batchId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.batchId,
                        referencedTable: $$AgingEvaluationsTableReferences
                            ._batchIdTable(db),
                        referencedColumn: $$AgingEvaluationsTableReferences
                            ._batchIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AgingEvaluationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AgingEvaluationsTable,
      AgingEvaluation,
      $$AgingEvaluationsTableFilterComposer,
      $$AgingEvaluationsTableOrderingComposer,
      $$AgingEvaluationsTableAnnotationComposer,
      $$AgingEvaluationsTableCreateCompanionBuilder,
      $$AgingEvaluationsTableUpdateCompanionBuilder,
      (AgingEvaluation, $$AgingEvaluationsTableReferences),
      AgingEvaluation,
      PrefetchHooks Function({bool batchId})
    >;
typedef $$InventoryLogsTableCreateCompanionBuilder =
    InventoryLogsCompanion Function({
      required String id,
      required String materialId,
      required double deltaGrams,
      required double remainingStockGrams,
      required String reason,
      Value<String?> referenceBatchId,
      Value<DateTime> timestamp,
      Value<int> rowid,
    });
typedef $$InventoryLogsTableUpdateCompanionBuilder =
    InventoryLogsCompanion Function({
      Value<String> id,
      Value<String> materialId,
      Value<double> deltaGrams,
      Value<double> remainingStockGrams,
      Value<String> reason,
      Value<String?> referenceBatchId,
      Value<DateTime> timestamp,
      Value<int> rowid,
    });

final class $$InventoryLogsTableReferences
    extends BaseReferences<_$AppDatabase, $InventoryLogsTable, InventoryLog> {
  $$InventoryLogsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MaterialsTable _materialIdTable(_$AppDatabase db) =>
      db.materials.createAlias('inventory_logs__material_id__materials__id');

  $$MaterialsTableProcessedTableManager get materialId {
    final $_column = $_itemColumn<String>('material_id')!;

    final manager = $$MaterialsTableTableManager(
      $_db,
      $_db.materials,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_materialIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventoryLogsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryLogsTable> {
  $$InventoryLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deltaGrams => $composableBuilder(
    column: $table.deltaGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get remainingStockGrams => $composableBuilder(
    column: $table.remainingStockGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceBatchId => $composableBuilder(
    column: $table.referenceBatchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  $$MaterialsTableFilterComposer get materialId {
    final $$MaterialsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.materialId,
      referencedTable: $db.materials,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaterialsTableFilterComposer(
            $db: $db,
            $table: $db.materials,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryLogsTable> {
  $$InventoryLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deltaGrams => $composableBuilder(
    column: $table.deltaGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get remainingStockGrams => $composableBuilder(
    column: $table.remainingStockGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceBatchId => $composableBuilder(
    column: $table.referenceBatchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  $$MaterialsTableOrderingComposer get materialId {
    final $$MaterialsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.materialId,
      referencedTable: $db.materials,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaterialsTableOrderingComposer(
            $db: $db,
            $table: $db.materials,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryLogsTable> {
  $$InventoryLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get deltaGrams => $composableBuilder(
    column: $table.deltaGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get remainingStockGrams => $composableBuilder(
    column: $table.remainingStockGrams,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get referenceBatchId => $composableBuilder(
    column: $table.referenceBatchId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  $$MaterialsTableAnnotationComposer get materialId {
    final $$MaterialsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.materialId,
      referencedTable: $db.materials,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaterialsTableAnnotationComposer(
            $db: $db,
            $table: $db.materials,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryLogsTable,
          InventoryLog,
          $$InventoryLogsTableFilterComposer,
          $$InventoryLogsTableOrderingComposer,
          $$InventoryLogsTableAnnotationComposer,
          $$InventoryLogsTableCreateCompanionBuilder,
          $$InventoryLogsTableUpdateCompanionBuilder,
          (InventoryLog, $$InventoryLogsTableReferences),
          InventoryLog,
          PrefetchHooks Function({bool materialId})
        > {
  $$InventoryLogsTableTableManager(_$AppDatabase db, $InventoryLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> materialId = const Value.absent(),
                Value<double> deltaGrams = const Value.absent(),
                Value<double> remainingStockGrams = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String?> referenceBatchId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryLogsCompanion(
                id: id,
                materialId: materialId,
                deltaGrams: deltaGrams,
                remainingStockGrams: remainingStockGrams,
                reason: reason,
                referenceBatchId: referenceBatchId,
                timestamp: timestamp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String materialId,
                required double deltaGrams,
                required double remainingStockGrams,
                required String reason,
                Value<String?> referenceBatchId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryLogsCompanion.insert(
                id: id,
                materialId: materialId,
                deltaGrams: deltaGrams,
                remainingStockGrams: remainingStockGrams,
                reason: reason,
                referenceBatchId: referenceBatchId,
                timestamp: timestamp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InventoryLogsTable, InventoryLog>(table),
                  $$InventoryLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({materialId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (materialId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.materialId,
                        referencedTable: $$InventoryLogsTableReferences
                            ._materialIdTable(db),
                        referencedColumn: $$InventoryLogsTableReferences
                            ._materialIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InventoryLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryLogsTable,
      InventoryLog,
      $$InventoryLogsTableFilterComposer,
      $$InventoryLogsTableOrderingComposer,
      $$InventoryLogsTableAnnotationComposer,
      $$InventoryLogsTableCreateCompanionBuilder,
      $$InventoryLogsTableUpdateCompanionBuilder,
      (InventoryLog, $$InventoryLogsTableReferences),
      InventoryLog,
      PrefetchHooks Function({bool materialId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MaterialsTableTableManager get materials =>
      $$MaterialsTableTableManager(_db, _db.materials);
  $$ReadyOilsTableTableManager get readyOils =>
      $$ReadyOilsTableTableManager(_db, _db.readyOils);
  $$FormulasTableTableManager get formulas =>
      $$FormulasTableTableManager(_db, _db.formulas);
  $$FormulaItemsTableTableManager get formulaItems =>
      $$FormulaItemsTableTableManager(_db, _db.formulaItems);
  $$AgingBatchesTableTableManager get agingBatches =>
      $$AgingBatchesTableTableManager(_db, _db.agingBatches);
  $$AgingEvaluationsTableTableManager get agingEvaluations =>
      $$AgingEvaluationsTableTableManager(_db, _db.agingEvaluations);
  $$InventoryLogsTableTableManager get inventoryLogs =>
      $$InventoryLogsTableTableManager(_db, _db.inventoryLogs);
}

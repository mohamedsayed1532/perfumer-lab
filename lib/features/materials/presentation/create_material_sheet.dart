import 'dart:convert';
import 'package:drift/drift.dart' as drift;
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/services/ifra_catalog_service.dart';
import 'package:perfumery_lab/core/services/materials_catalog_service.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import '../data/materials_repository.dart';
import 'widgets/ghs_picker.dart';
import 'widgets/pyramid_note_selector.dart';

class CreateMaterialSheet extends ConsumerStatefulWidget {
  final Material? existing;
  const CreateMaterialSheet({super.key, this.existing});

  @override
  ConsumerState<CreateMaterialSheet> createState() => _CreateMaterialSheetState();
}

class _CreateMaterialSheetState extends ConsumerState<CreateMaterialSheet> {
  bool _isDirty = false;
  bool _userEditedIdealMax = false;
  bool _userEditedSafety = false;
  bool _userEditedIdentity = false;
  bool _suppressFieldCallbacks = false;
  String? _lastAutoAppliedCas;
  String? _autoFilledName;
  String? _autoFilledBotanical;
  String? _autoFilledIupac;

  late TextEditingController _nameController;
  late TextEditingController _casController;
  late TextEditingController _botanicalController;
  late TextEditingController _iupacController;
  late TextEditingController _dilutionController;
  late TextEditingController _densityController;
  late TextEditingController _odorLifeController;
  late TextEditingController _idealMaxController;
  late TextEditingController _stockGramsController;
  late TextEditingController _costPerGramController;
  late TextEditingController _tgscUrlController;
  late TextEditingController _descriptionController;

  String _pyramidNote = 'heart';
  String _defaultSolvent = 'Neat (100%)';
  int _intensity = 3;
  List<String> _categories = ['Synthetic'];
  List<String> _ghsPictograms = [];

  static const List<String> solventOptions = [
    'Neat (100%)',
    'DPG (Dipropylene Glycol)',
    'TEC (Triethyl Citrate)',
    'IPM (Isopropyl Myristate)',
    'Ethanol 96°',
    'Fractionated Coconut Oil',
  ];

  static const List<String> categoryOptions = [
    'Natural',
    'Synthetic',
    'Essential Oil',
    'Absolute',
    'Isolate',
    'Mix',
    'Solvent',
  ];

  @override
  void initState() {
    super.initState();
    final mat = widget.existing;
    _nameController = TextEditingController(text: mat?.name ?? '');
    _casController = TextEditingController(text: mat?.casNumber ?? '');
    _botanicalController = TextEditingController(text: mat?.botanicalName ?? '');
    _iupacController = TextEditingController(text: mat?.iupacName ?? '');
    _dilutionController =
        TextEditingController(text: mat != null ? '${mat.dilutionPercent}' : '100');
    _densityController =
        TextEditingController(text: mat?.density != null ? '${mat!.density}' : '');
    _odorLifeController = TextEditingController(text: mat?.odorLife ?? '');
    _idealMaxController = TextEditingController(
        text: mat?.idealMaxPercent != null ? '${mat!.idealMaxPercent}' : '');
    _stockGramsController =
        TextEditingController(text: mat != null ? '${mat.stockGrams}' : '0.0');
    _costPerGramController =
        TextEditingController(text: mat != null ? '${mat.costPerGram}' : '0.0');
    _tgscUrlController = TextEditingController(text: mat?.tgscUrl ?? '');
    _descriptionController = TextEditingController(text: mat?.description ?? '');

    if (mat != null) {
      _pyramidNote = mat.pyramidNote;
      _defaultSolvent = mat.defaultSolvent ?? 'Neat (100%)';
      _intensity = mat.intensity;
      try {
        _categories = List<String>.from(jsonDecode(mat.categoriesJson));
        _ghsPictograms = List<String>.from(jsonDecode(mat.hazardPictogramsJson));
      } catch (_) {}
      _userEditedIdentity = true;
      _userEditedIdealMax = mat.idealMaxPercent != null;
      _userEditedSafety = _ghsPictograms.isNotEmpty;
    }

    _casController.addListener(_onCasChanged);
    _nameController.addListener(_onNameChanged);
    _idealMaxController.addListener(_onIdealMaxChanged);
  }

  void _onCasChanged() {
    if (_suppressFieldCallbacks) return;
    final clean = MaterialsCatalogData.cleanCas(_casController.text);
    final matCatalog = ref.read(materialsCatalogProvider).value;
    final ifraCatalog = ref.read(ifraCatalogProvider).value;
    final catMatch = matCatalog?.findByCas(clean);
    final ifraMatch = clean.isEmpty
        ? null
        : ifraCatalog?.findStandardForMaterial(casNumber: clean);

    if (widget.existing == null &&
        clean.isNotEmpty &&
        clean != _lastAutoAppliedCas &&
        (catMatch != null || ifraMatch != null)) {
      _applyDatabaseMatch(catMatch, ifraMatch, forceOverwrite: false);
    } else if (mounted) {
      setState(() {});
    }
  }

  void _onNameChanged() {
    if (_suppressFieldCallbacks) return;
    if (_nameController.text != _autoFilledName) {
      _userEditedIdentity = _nameController.text.trim().isNotEmpty;
    }
    if (mounted) setState(() {});
  }

  void _onIdealMaxChanged() {
    if (_suppressFieldCallbacks) return;
    _userEditedIdealMax = _idealMaxController.text.trim().isNotEmpty;
  }

  List<String> _hazardsFromIfra(IfraStandard std) {
    final ep = std.endpoint.toUpperCase();
    final out = <String>{};
    if (ep.contains('DERMAL SENSITIZATION') ||
        ep.contains('SKIN') ||
        ep.contains('DEPIGMENTATION') ||
        ep.contains('PHOTOTOXICITY') ||
        ep.contains('PHOTOSENSITIZATION')) {
      out.add('irritant');
    }
    if (ep.contains('CARCINOGEN') ||
        ep.contains('GENOTOXIC') ||
        ep.contains('MUTAGEN') ||
        ep.contains('REPRODUCTIVE') ||
        ep.contains('TERATOGEN') ||
        ep.contains('SYSTEMIC') ||
        ep.contains('NEUROTOXIC') ||
        ep.contains('NITROSAMINE')) {
      out.add('health_hazard');
    }
    if (ep.contains('ACUTE TOXICITY') || ep.contains('CYANIDE')) {
      out.add('acute_toxic');
    }
    if (ep.contains('VPVB')) {
      out.add('environmental');
    }
    return kValidHazardIds.where(out.contains).toList();
  }

  void _applyDatabaseMatch(
    CatalogMaterialEntry? cat,
    IfraStandard? ifra, {
    required bool forceOverwrite,
  }) {
    if (cat == null && ifra == null) return;
    _suppressFieldCallbacks = true;
    try {
      final resolvedCas =
          cat?.cas ?? MaterialsCatalogData.cleanCas(_casController.text);
      _lastAutoAppliedCas = resolvedCas;

      final double? suggestedMax =
          ifra?.numericLimitFor('Cat 4') ?? cat?.idealMaxPercent;
      if (forceOverwrite || !_userEditedIdealMax) {
        _idealMaxController.text =
            suggestedMax != null ? suggestedMax.toString() : '';
      }

      final List<String> suggestedHazards =
          cat != null ? cat.hazards : _hazardsFromIfra(ifra!);
      if (forceOverwrite || !_userEditedSafety) {
        _ghsPictograms = List<String>.from(suggestedHazards);
      }

      if (cat != null) {
        final canUpdateName = forceOverwrite ||
            (!_userEditedIdentity &&
                (_nameController.text.trim().isEmpty ||
                    _nameController.text == _autoFilledName));
        if (canUpdateName && cat.name.isNotEmpty) {
          _nameController.text = cat.name;
          _autoFilledName = cat.name;
        }
        final canUpdateBot = forceOverwrite ||
            _botanicalController.text.trim().isEmpty ||
            _botanicalController.text == _autoFilledBotanical;
        if (canUpdateBot && (cat.botanicalName ?? '').isNotEmpty) {
          _botanicalController.text = cat.botanicalName!;
          _autoFilledBotanical = cat.botanicalName;
        }
        final canUpdateIupac = forceOverwrite ||
            _iupacController.text.trim().isEmpty ||
            _iupacController.text == _autoFilledIupac;
        if (canUpdateIupac && (cat.iupacName ?? '').isNotEmpty) {
          _iupacController.text = cat.iupacName!;
          _autoFilledIupac = cat.iupacName;
        }
        if (forceOverwrite || !_userEditedIdentity) {
          if (cat.pyramidNote != null &&
              const ['top', 'heart', 'base'].contains(cat.pyramidNote)) {
            _pyramidNote = cat.pyramidNote!;
          }
          if (cat.categories.isNotEmpty) {
            _categories = List<String>.from(cat.categories);
          }
        }
      }
      _isDirty = true;
    } finally {
      _suppressFieldCallbacks = false;
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _casController.removeListener(_onCasChanged);
    _nameController.removeListener(_onNameChanged);
    _idealMaxController.removeListener(_onIdealMaxChanged);
    _nameController.dispose();
    _casController.dispose();
    _botanicalController.dispose();
    _iupacController.dispose();
    _dilutionController.dispose();
    _densityController.dispose();
    _odorLifeController.dispose();
    _idealMaxController.dispose();
    _stockGramsController.dispose();
    _costPerGramController.dispose();
    _tgscUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _markDirty() {
    if (!_isDirty) setState(() => _isDirty = true);
  }

  Future<bool> _onWillPop() async {
    if (!_isDirty) return true;
    final shouldDiscard = await showCupertinoModalPopup<bool>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: const Text('Discard Changes?'),
        message: const Text(
            'You have unsaved changes in this material form. Are you sure you want to discard them?'),
        actions: [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Discard Changes'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Keep Editing'),
        ),
      ),
    );
    return shouldDiscard ?? false;
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      LabHaptics.warning();
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Material Name Required'),
          content: const Text('Please enter a material name to save.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      );
      return;
    }

    final id = widget.existing?.id ?? const Uuid().v4();
    final repo = ref.read(materialsRepositoryProvider);

    final companion = MaterialsCompanion(
      id: drift.Value(id),
      name: drift.Value(name),
      casNumber: drift.Value(_casController.text.trim().isEmpty
          ? null
          : _casController.text.trim()),
      botanicalName: drift.Value(_botanicalController.text.trim().isEmpty
          ? null
          : _botanicalController.text.trim()),
      iupacName: drift.Value(_iupacController.text.trim().isEmpty
          ? null
          : _iupacController.text.trim()),
      pyramidNote: drift.Value(_pyramidNote),
      categoriesJson: drift.Value(jsonEncode(_categories)),
      hazardPictogramsJson: drift.Value(jsonEncode(_ghsPictograms)),
      dilutionPercent:
          drift.Value(double.tryParse(_dilutionController.text) ?? 100.0),
      density: drift.Value(double.tryParse(_densityController.text)),
      defaultSolvent: drift.Value(_defaultSolvent),
      intensity: drift.Value(_intensity),
      odorLife: drift.Value(_odorLifeController.text.trim().isEmpty
          ? null
          : _odorLifeController.text.trim()),
      idealMaxPercent: drift.Value(double.tryParse(_idealMaxController.text)),
      stockGrams:
          drift.Value(double.tryParse(_stockGramsController.text) ?? 0.0),
      costPerGram:
          drift.Value(double.tryParse(_costPerGramController.text) ?? 0.0),
      tgscUrl: drift.Value(_tgscUrlController.text.trim().isEmpty
          ? null
          : _tgscUrlController.text.trim()),
      description: drift.Value(_descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim()),
      updatedAt: drift.Value(DateTime.now()),
    );

    await repo.createOrUpdateMaterial(companion);
    await LabHaptics.stepCompleted();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<MaterialsCatalogData>>(
      materialsCatalogProvider,
      (_, next) {
        if (next.hasValue) _onCasChanged();
      },
    );
    ref.listen<AsyncValue<IfraCatalogData>>(
      ifraCatalogProvider,
      (_, next) {
        if (next.hasValue) _onCasChanged();
      },
    );

    return PopScope(
      canPop: !_isDirty,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) Navigator.pop(context);
      },
      child: CupertinoPageScaffold(
        backgroundColor:
            AppColors.systemGroupedBackground.resolveFrom(context),
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            widget.existing == null ? 'New Material' : 'Edit Material',
            style: AppTypography.headline(context),
          ),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              final shouldPop = await _onWillPop();
              if (shouldPop && context.mounted) Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _save,
            child: const Text(
              'Save',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              _buildSectionHeader('ACCORD IDENTITY'),
              _buildCard([
                _buildTextField('Material Name *', _nameController,
                    placeholder: 'e.g. Iso E Super, Bergamot Oil'),
                _buildDivider(),
                _buildTextField('CAS Number', _casController,
                    placeholder: 'e.g. 54464-57-2'),
                _buildDivider(),
                _buildCasLookupRow(),
                _buildDivider(),
                _buildTextField('Botanical Name', _botanicalController,
                    placeholder: 'e.g. Citrus bergamia'),
                _buildDivider(),
                _buildTextField('IUPAC Name', _iupacController,
                    placeholder: 'Chemical systematic name'),
              ]),
              const SizedBox(height: 24),
              _buildSectionHeader('OLFACTORY PYRAMID NOTE'),
              PyramidNoteSelector(
                selectedNote: _pyramidNote,
                onChanged: (val) {
                  _markDirty();
                  setState(() => _pyramidNote = val);
                },
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('CATEGORIES'),
              _buildCategoriesWrap(),
              const SizedBox(height: 24),
              _buildSectionHeader('DILUTION & BENCH STOCK'),
              _buildCard([
                _buildTextField('Stock Dilution %', _dilutionController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    placeholder: '100 for neat, 10 for 10%'),
                _buildDivider(),
                _buildSolventPicker(),
                _buildDivider(),
                _buildTextField('Stock Available (g)', _stockGramsController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    placeholder: 'e.g. 250.00'),
                _buildDivider(),
                _buildTextField('Cost per Gram (\$)', _costPerGramController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    placeholder: '0.15'),
              ]),
              const SizedBox(height: 24),
              _buildSectionHeader('MATERIAL PROFILE'),
              _buildCard([
                _buildTextField('Density (g/cm³)', _densityController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    placeholder: 'e.g. 0.965'),
                _buildDivider(),
                _buildTextField('Odor Life (Blotter)', _odorLifeController,
                    placeholder: 'e.g. 400 hours'),
                _buildDivider(),
                _buildTextField('Ideal Max % (IFRA)', _idealMaxController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    placeholder: 'e.g. 21.4%'),
                _buildDivider(),
                _buildIfraLookupRow(),
                _buildDivider(),
                _buildIntensitySlider(),
              ]),
              const SizedBox(height: 24),
              _buildSectionHeader('SAFETY CLASSIFICATION'),
              GhsPicker(
                selected: _ghsPictograms,
                onChanged: (list) {
                  _markDirty();
                  _userEditedSafety = true;
                  setState(() => _ghsPictograms = list);
                },
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('REFERENCES & NOTES'),
              _buildCard([
                _buildTextField('TGSC Link', _tgscUrlController,
                    placeholder: 'http://www.thegoodscentscompany.com/...'),
                _buildDivider(),
                _buildTextField('Perfumer Notes', _descriptionController,
                    maxLines: 4, placeholder: 'Sensory characteristics, pairings...'),
              ]),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.accent.resolveFrom(context).withValues(alpha: 0.85),
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondarySystemGroupedBackground.resolveFrom(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.separator.resolveFrom(context),
          width: 0.5,
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {String? placeholder, TextInputType? keyboardType, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment:
            maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.label.resolveFrom(context),
              ),
            ),
          ),
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              placeholderStyle: TextStyle(
                color: AppColors.tertiaryLabel.resolveFrom(context),
                fontSize: 15,
              ),
              maxLines: maxLines,
              keyboardType: keyboardType,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.label.resolveFrom(context),
              ),
              decoration: const BoxDecoration(),
              onChanged: (_) => _markDirty(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 0.5,
      margin: const EdgeInsets.only(left: 16),
      color: AppColors.separator.resolveFrom(context),
    );
  }

  Widget _buildSolventPicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Default Solvent',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.label.resolveFrom(context),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (ctx) => CupertinoActionSheet(
                  title: const Text('Select Default Solvent'),
                  actions: solventOptions
                      .map(
                        (solv) => CupertinoActionSheetAction(
                          onPressed: () {
                            _markDirty();
                            setState(() => _defaultSolvent = solv);
                            Navigator.pop(ctx);
                          },
                          child: Text(solv),
                        ),
                      )
                      .toList(),
                  cancelButton: CupertinoActionSheetAction(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  _defaultSolvent.split(' ')[0],
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.accent.resolveFrom(context),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  CupertinoIcons.chevron_up_chevron_down,
                  size: 14,
                  color: AppColors.secondaryLabel.resolveFrom(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntensitySlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Intensity: $_intensity / 5',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.label.resolveFrom(context),
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              final active = index < _intensity;
              return GestureDetector(
                onTap: () {
                  _markDirty();
                  setState(() => _intensity = index + 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    active
                        ? CupertinoIcons.circle_fill
                        : CupertinoIcons.circle,
                    size: 20,
                    color: active
                        ? AppColors.amberRose.resolveFrom(context)
                        : AppColors.tertiaryLabel.resolveFrom(context),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesWrap() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categoryOptions.map((cat) {
        final isSelected = _categories.contains(cat);
        return GestureDetector(
          onTap: () {
            _markDirty();
            setState(() {
              if (isSelected) {
                _categories.remove(cat);
              } else {
                _categories.add(cat);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.accent.resolveFrom(context).withValues(alpha: 0.18)
                  : AppColors.secondarySystemGroupedBackground.resolveFrom(context),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? AppColors.accent.resolveFrom(context)
                    : AppColors.separator.resolveFrom(context),
                width: isSelected ? 1.5 : 0.5,
              ),
            ),
            child: Text(
              cat,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? AppColors.accent.resolveFrom(context)
                    : AppColors.label.resolveFrom(context),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  static String _formatHazardLabel(String id) => switch (id) {
        'flammable' => 'Flammable',
        'irritant' => 'Irritant',
        'health_hazard' => 'Health Hazard',
        'environmental' => 'Environmental',
        'corrosive' => 'Corrosive',
        'acute_toxic' => 'Acute Toxic',
        _ => id,
      };

  Widget _buildCasLookupRow() {
    final matCatalog = ref.watch(materialsCatalogProvider).value;
    final ifraCatalog = ref.watch(ifraCatalogProvider).value;
    final cleanCas = MaterialsCatalogData.cleanCas(_casController.text);
    final catMatch = cleanCas.isEmpty ? null : matCatalog?.findByCas(cleanCas);
    final ifraMatch = cleanCas.isEmpty
        ? null
        : ifraCatalog?.findStandardForMaterial(casNumber: cleanCas);

    final hasMatch = catMatch != null || ifraMatch != null;
    final hazards =
        catMatch?.hazards ?? (ifraMatch != null ? _hazardsFromIfra(ifraMatch) : const <String>[]);
    final double? maxLimit =
        ifraMatch?.numericLimitFor('Cat 4') ?? catMatch?.idealMaxPercent;
    final maxText = ifraMatch != null
        ? 'IFRA Cat 4: ${ifraMatch.displayLimitFor('Cat 4')}'
        : (maxLimit != null ? 'Guide Max: $maxLimit%' : 'No IFRA limit');
    final safetyText = hazards.isEmpty
        ? 'No GHS hazards'
        : hazards.map(_formatHazardLabel).join(', ');
    final countText = matCatalog != null ? '${matCatalog.entries.length} CAS' : 'DB';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(
            hasMatch
                ? CupertinoIcons.checkmark_seal_fill
                : CupertinoIcons.search,
            size: 16,
            color: hasMatch
                ? (ifraMatch?.isProhibited == true
                    ? CupertinoColors.systemRed
                    : AppColors.naturalGreen.resolveFrom(context))
                : AppColors.tertiaryLabel.resolveFrom(context),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasMatch
                      ? 'DB Match · ${catMatch?.name ?? ifraMatch!.name}'
                      : 'Hidden CAS Reference ($countText)',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: hasMatch
                        ? AppColors.label.resolveFrom(context)
                        : AppColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  hasMatch
                      ? '$maxText · $safetyText'
                      : (cleanCas.isEmpty
                          ? 'Type CAS number to auto-fill Ideal Max & Safety'
                          : 'No entry found for $cleanCas'),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: hasMatch
                        ? AppColors.secondaryLabel.resolveFrom(context)
                        : AppColors.tertiaryLabel.resolveFrom(context),
                  ),
                ),
              ],
            ),
          ),
          if (hasMatch) ...[
            const SizedBox(width: 8),
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              minimumSize: Size.zero,
              color: AppColors.accent.resolveFrom(context),
              borderRadius: BorderRadius.circular(8),
              onPressed: () => _applyDatabaseMatch(
                catMatch,
                ifraMatch,
                forceOverwrite: true,
              ),
              child: Text(
                'Apply',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onAccent(context),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIfraLookupRow() {
    final catalog = ref.watch(ifraCatalogProvider).value;
    final matCatalog = ref.watch(materialsCatalogProvider).value;
    final match = catalog?.findStandardForMaterial(
      casNumber: _casController.text,
      name: _nameController.text,
    );
    final catMatch = matCatalog?.findByCas(_casController.text);
    final double? limit =
        match?.numericLimitFor('Cat 4') ?? catMatch?.idealMaxPercent;
    final labelText = match != null
        ? '${match.name} · Cat 4: ${match.displayLimitFor('Cat 4')}'
        : (catMatch != null
            ? '${catMatch.name} · ${limit != null ? 'TGSC Guide: $limit%' : 'No IFRA restriction'}'
            : 'Type name or CAS to auto-match IFRA & Materials DB');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'IFRA 51st & Guide Max Match',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryLabel.resolveFrom(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  labelText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: (match == null && catMatch == null)
                        ? AppColors.tertiaryLabel.resolveFrom(context)
                        : (match?.type == 'PROHIBITION'
                            ? CupertinoColors.systemRed
                            : AppColors.naturalGreen.resolveFrom(context)),
                  ),
                ),
              ],
            ),
          ),
          if (limit != null)
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              minimumSize: Size.zero,
              color: AppColors.accent.resolveFrom(context),
              borderRadius: BorderRadius.circular(8),
              onPressed: () {
                _markDirty();
                setState(() {
                  _suppressFieldCallbacks = true;
                  _idealMaxController.text = limit.toString();
                  _suppressFieldCallbacks = false;
                });
              },
              child: Text(
                'Apply',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onAccent(context),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

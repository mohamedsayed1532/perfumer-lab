import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import 'package:perfumery_lab/features/materials/data/materials_repository.dart';
import '../data/formulas_repository.dart';

class AddOrEditIngredientSheet extends ConsumerStatefulWidget {
  final String formulaId;
  final FormulaItemWithMaterial? existing;

  const AddOrEditIngredientSheet({
    super.key,
    required this.formulaId,
    this.existing,
  });

  @override
  ConsumerState<AddOrEditIngredientSheet> createState() =>
      _AddOrEditIngredientSheetState();
}

class _AddOrEditIngredientSheetState
    extends ConsumerState<AddOrEditIngredientSheet> {
  String _unitMode = 'ppt'; // 'ppt' or 'percent'
  late final TextEditingController _valueController;
  late final TextEditingController _dilutionController;
  String? _selectedMaterialId;

  @override
  void initState() {
    super.initState();
    if (widget.existing != null) {
      final item = widget.existing!.item;
      _selectedMaterialId = item.materialId;
      _valueController = TextEditingController(
          text: item.partsPerThousand.toStringAsFixed(1));
      _dilutionController = TextEditingController(
          text: item.specifiedDilutionPercent.toStringAsFixed(0));
    } else {
      _valueController = TextEditingController(text: '10.0');
      _dilutionController = TextEditingController(text: '100');
    }
  }

  @override
  void dispose() {
    _valueController.dispose();
    _dilutionController.dispose();
    super.dispose();
  }

  void _onUnitModeChanged(String? val) {
    if (val == null || val == _unitMode) return;
    final currentVal = double.tryParse(_valueController.text.trim()) ?? 0.0;
    setState(() {
      _unitMode = val;
      if (val == 'percent') {
        // Converting ppt to % (ppt / 10.0)
        _valueController.text = (currentVal / 10.0).toStringAsFixed(2);
      } else {
        // Converting % to ppt (% * 10.0)
        _valueController.text = (currentVal * 10.0).toStringAsFixed(1);
      }
    });
  }

  double get _calculatedPpt {
    final raw = double.tryParse(_valueController.text.trim()) ?? 0.0;
    return _unitMode == 'percent' ? raw * 10.0 : raw;
  }

  double get _calculatedPercent {
    return _calculatedPpt / 10.0;
  }

  Future<void> _save(List<Material> materials) async {
    final matId = _selectedMaterialId ??
        (materials.isNotEmpty ? materials.first.id : null);

    if (matId == null) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('No Material Selected'),
          content: const Text('Please select a raw material.'),
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

    final ppt = _calculatedPpt;
    if (ppt <= 0) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid Quantity'),
          content: const Text('Please enter an amount greater than 0.'),
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

    final dilution =
        double.tryParse(_dilutionController.text.trim()) ?? 100.0;

    final repo = ref.read(formulasRepositoryProvider);
    final itemId = widget.existing?.item.id ?? const Uuid().v4();

    await repo.addOrUpdateItem(
      FormulaItemsCompanion.insert(
        id: itemId,
        formulaId: widget.formulaId,
        materialId: matId,
        partsPerThousand: ppt,
        specifiedDilutionPercent: drift.Value(dilution),
      ),
    );

    await LabHaptics.stepCompleted();
    if (mounted) Navigator.pop(context);
  }

  void _confirmDelete() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text('Remove "${widget.existing!.material.name}"?'),
        content: const Text(
          'This will remove this aroma chemical ingredient from this formula.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Remove'),
            onPressed: () async {
              Navigator.pop(ctx);
              final repo = ref.read(formulasRepositoryProvider);
              await repo.deleteItem(widget.existing!.item.id);
              await LabHaptics.stepCompleted();
              if (mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final materialsAsync = ref.watch(materialsStreamProvider);
    final isEditing = widget.existing != null;

    return materialsAsync.when(
      data: (materials) {
        if (materials.isEmpty) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Add Ingredient'),
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'No raw materials in catalog. Please catalog aroma chemicals in Materials tab first.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        if (_selectedMaterialId == null && materials.isNotEmpty) {
          _selectedMaterialId = materials.first.id;
        }

        return CupertinoPageScaffold(
          backgroundColor:
              AppColors.systemGroupedBackground.resolveFrom(context),
          navigationBar: CupertinoNavigationBar(
            middle: Text(
              isEditing ? 'Edit Ingredient' : 'Add Ingredient',
              style: AppTypography.headline(context),
            ),
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _save(materials),
              child: Text(
                isEditing ? 'Save' : 'Add',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          child: SafeArea(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                _buildSectionHeader('RAW MATERIAL'),
                if (isEditing) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.secondarySystemGroupedBackground
                          .resolveFrom(context),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      widget.existing!.material.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ] else ...[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondarySystemGroupedBackground
                          .resolveFrom(context),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: SizedBox(
                      height: 140,
                      child: CupertinoPicker(
                        itemExtent: 38,
                        scrollController: FixedExtentScrollController(
                          initialItem: materials.indexWhere(
                              (m) => m.id == _selectedMaterialId),
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedMaterialId = materials[index].id;
                            _dilutionController.text = materials[index]
                                .dilutionPercent
                                .toStringAsFixed(0);
                          });
                        },
                        children: materials
                            .map(
                              (m) => Center(
                                child: Text(
                                  '${m.name} (${m.pyramidNote.toUpperCase()})',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        AppColors.label.resolveFrom(context),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                _buildSectionHeader('CONCENTRATION UNIT'),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoSlidingSegmentedControl<String>(
                    groupValue: _unitMode,
                    thumbColor: AppColors.accent.resolveFrom(context),
                    backgroundColor: AppColors.secondarySystemGroupedBackground
                        .resolveFrom(context),
                    children: {
                      'ppt': _buildSegmentLabel(
                          'Parts / Thousand (ppt)', _unitMode == 'ppt'),
                      'percent': _buildSegmentLabel(
                          'Percentage (%)', _unitMode == 'percent'),
                    },
                    onValueChanged: _onUnitModeChanged,
                  ),
                ),
                const SizedBox(height: 14),
                _buildGroupedCard([
                  _buildRow(
                    _unitMode == 'ppt' ? 'Amount (ppt) *' : 'Amount (%) *',
                    _valueController,
                    placeholder: _unitMode == 'ppt' ? '10.0' : '1.00',
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    onChanged: (val) => setState(() {}),
                  ),
                  _buildDivider(),
                  _buildRow(
                    'Specified Dilution %',
                    _dilutionController,
                    placeholder: '100',
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                  ),
                ]),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Equivalent Conversion:',
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              AppColors.secondaryLabel.resolveFrom(context),
                        ),
                      ),
                      Text(
                        '${_calculatedPpt.toStringAsFixed(1)} ppt  =  ${_calculatedPercent.toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent.resolveFrom(context),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isEditing) ...[
                  const SizedBox(height: 36),
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    color: CupertinoColors.systemRed.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                    onPressed: _confirmDelete,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.trash,
                            size: 18, color: CupertinoColors.systemRed),
                        SizedBox(width: 8),
                        Text(
                          'Remove Ingredient',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.systemRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
      loading: () => const CupertinoPageScaffold(
        child: Center(child: CupertinoActivityIndicator()),
      ),
      error: (err, _) => CupertinoPageScaffold(
        child: Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildSegmentLabel(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected
              ? AppColors.onAccent(context)
              : AppColors.label.resolveFrom(context),
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
          color: AppColors.secondaryLabel.resolveFrom(context),
        ),
      ),
    );
  }

  Widget _buildGroupedCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color:
            AppColors.secondarySystemGroupedBackground.resolveFrom(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildRow(
    String label,
    TextEditingController controller, {
    String? placeholder,
    TextInputType keyboardType = TextInputType.text,
    ValueChanged<String>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
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
              style: TextStyle(
                color: AppColors.label.resolveFrom(context),
                fontSize: 15,
              ),
              decoration: null,
              keyboardType: keyboardType,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      height: 0.5,
      color: AppColors.separator.resolveFrom(context),
    );
  }
}

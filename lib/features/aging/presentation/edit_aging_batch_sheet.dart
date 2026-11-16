import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import '../data/aging_repository.dart';

class EditAgingBatchSheet extends ConsumerStatefulWidget {
  final AgingBatche batch;
  const EditAgingBatchSheet({super.key, required this.batch});

  @override
  ConsumerState<EditAgingBatchSheet> createState() =>
      _EditAgingBatchSheetState();
}

class _EditAgingBatchSheetState extends ConsumerState<EditAgingBatchSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _targetDaysController;
  late final TextEditingController _weightController;
  late final TextEditingController _concentrationController;
  late String _stage;

  @override
  void initState() {
    super.initState();
    final b = widget.batch;
    _nameController = TextEditingController(text: b.name);
    _targetDaysController =
        TextEditingController(text: b.targetAgingDays.toString());
    _weightController =
        TextEditingController(text: b.totalWeightGrams.toStringAsFixed(1));
    _concentrationController =
        TextEditingController(text: b.concentrationPercent.toStringAsFixed(0));
    _stage = b.stage.toLowerCase();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _targetDaysController.dispose();
    _weightController.dispose();
    _concentrationController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final targetDays = int.tryParse(_targetDaysController.text.trim()) ?? 30;
    final weight =
        double.tryParse(_weightController.text.trim()) ?? widget.batch.totalWeightGrams;
    final conc = double.tryParse(_concentrationController.text.trim()) ??
        widget.batch.concentrationPercent;

    final repo = ref.read(agingRepositoryProvider);
    await repo.updateAgingBatch(
      widget.batch.toCompanion(true).copyWith(
            name: drift.Value(name),
            stage: drift.Value(_stage),
            targetAgingDays: drift.Value(targetDays),
            totalWeightGrams: drift.Value(weight),
            concentrationPercent: drift.Value(conc),
          ),
    );

    await LabHaptics.stepCompleted();
    if (mounted) Navigator.pop(context);
  }

  void _confirmComplete() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Mark Batch as Completed?'),
        content: const Text(
          'This will move this batch to completed aging history and conclude the maceration/maturation schedule.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Complete Batch'),
            onPressed: () async {
              Navigator.pop(ctx);
              final repo = ref.read(agingRepositoryProvider);
              await repo.completeAgingBatch(widget.batch.id);
              await LabHaptics.batchSuccess();
              if (mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _confirmDelete() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text('Delete "${widget.batch.name}"?'),
        content: const Text(
          'This will permanently delete this aging batch and all its sensory evaluation records. This cannot be undone.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Delete'),
            onPressed: () async {
              Navigator.pop(ctx);
              final repo = ref.read(agingRepositoryProvider);
              await repo.deleteAgingBatch(widget.batch.id);
              await LabHaptics.batchSuccess();
              if (mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        middle: Text('Edit Aging Batch', style: AppTypography.headline(context)),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
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
            _buildSectionHeader('BATCH DETAILS'),
            _buildGroupedCard([
              _buildRow('Batch Name *', _nameController,
                  placeholder: 'e.g. Alexandria 2 20% EdP'),
              _buildDivider(),
              _buildRow('Batch Code', TextEditingController(text: widget.batch.batchNumber),
                  placeholder: '', enabled: false),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('AGING STAGE'),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<String>(
                  groupValue: _stage,
                  thumbColor: AppColors.accent.resolveFrom(context),
                  backgroundColor: AppColors.secondarySystemGroupedBackground
                      .resolveFrom(context),
                  children: {
                    'maturation': _buildSegmentLabel(
                        'Maturation (Oil)', _stage == 'maturation'),
                    'maceration': _buildSegmentLabel(
                        'Maceration (Perfume)', _stage == 'maceration'),
                  },
                  onValueChanged: (val) {
                    if (val != null) setState(() => _stage = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildSectionHeader('PARAMETERS'),
            _buildGroupedCard([
              _buildRow(
                'Target Days',
                _targetDaysController,
                placeholder: '30',
                keyboardType: TextInputType.number,
              ),
              _buildDivider(),
              _buildRow(
                'Total Batch (g)',
                _weightController,
                placeholder: '100.0',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              _buildDivider(),
              _buildRow(
                'Concentration %',
                _concentrationController,
                placeholder: '20',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ]),
            const SizedBox(height: 32),
            CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 14),
              color: CupertinoColors.systemGreen.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
              onPressed: _confirmComplete,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.checkmark_seal_fill,
                      size: 18, color: CupertinoColors.systemGreen),
                  SizedBox(width: 8),
                  Text(
                    'Mark Batch as Completed',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.systemGreen,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
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
                    'Delete Aging Batch',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
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
              ? CupertinoColors.white
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
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: AppColors.secondaryLabel.resolveFrom(context),
        ),
      ),
    );
  }

  Widget _buildGroupedCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondarySystemGroupedBackground.resolveFrom(context),
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
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: enabled
                    ? AppColors.label.resolveFrom(context)
                    : AppColors.tertiaryLabel.resolveFrom(context),
              ),
            ),
          ),
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              enabled: enabled,
              placeholderStyle: TextStyle(
                color: AppColors.tertiaryLabel.resolveFrom(context),
                fontSize: 15,
              ),
              style: TextStyle(
                color: enabled
                    ? AppColors.label.resolveFrom(context)
                    : AppColors.secondaryLabel.resolveFrom(context),
                fontSize: 15,
              ),
              decoration: null,
              keyboardType: keyboardType,
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

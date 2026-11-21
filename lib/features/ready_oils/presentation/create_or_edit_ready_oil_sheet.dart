import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import '../data/ready_oils_repository.dart';

class CreateOrEditReadyOilSheet extends ConsumerStatefulWidget {
  final ReadyOil? existing;
  const CreateOrEditReadyOilSheet({super.key, this.existing});

  @override
  ConsumerState<CreateOrEditReadyOilSheet> createState() =>
      _CreateOrEditReadyOilSheetState();
}

class _CreateOrEditReadyOilSheetState
    extends ConsumerState<CreateOrEditReadyOilSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _supplierController;
  late final TextEditingController _lotController;
  late final TextEditingController _stockController;
  late final TextEditingController _dosageController;
  late final TextEditingController _costController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _nameController = TextEditingController(text: e?.name ?? '');
    _supplierController = TextEditingController(text: e?.supplier ?? '');
    _lotController = TextEditingController(text: e?.lotNumber ?? '');
    _stockController = TextEditingController(
        text: e != null ? e.stockGrams.toStringAsFixed(1) : '100.0');
    _dosageController = TextEditingController(
        text: e?.recommendedDosagePercent?.toStringAsFixed(0) ?? '20');
    _costController = TextEditingController(
        text: e != null && e.costPerGram > 0
            ? e.costPerGram.toStringAsFixed(2)
            : '');
    _notesController = TextEditingController(text: e?.notes ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _supplierController.dispose();
    _lotController.dispose();
    _stockController.dispose();
    _dosageController.dispose();
    _costController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Oil Name Required'),
          content: const Text('Please enter a name for the fragrance oil.'),
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

    final repo = ref.read(readyOilsRepositoryProvider);
    final id = widget.existing?.id ?? const Uuid().v4();

    await repo.createOrUpdateReadyOil(
      ReadyOilsCompanion.insert(
        id: id,
        name: name,
        supplier: drift.Value(_supplierController.text.trim().isEmpty
            ? null
            : _supplierController.text.trim()),
        lotNumber: drift.Value(_lotController.text.trim().isEmpty
            ? null
            : _lotController.text.trim()),
        stockGrams: drift.Value(
            double.tryParse(_stockController.text.trim()) ?? 100.0),
        recommendedDosagePercent: drift.Value(
            double.tryParse(_dosageController.text.trim())),
        costPerGram: drift.Value(
            double.tryParse(_costController.text.trim()) ?? 0.0),
        notes: drift.Value(_notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim()),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );

    await LabHaptics.stepCompleted();
    if (mounted) Navigator.pop(context);
  }

  void _confirmDelete() {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text('Delete "${widget.existing!.name}"?'),
        content: const Text(
          'This will permanently delete this ready fragrance oil from your inventory. This cannot be undone.',
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
              final repo = ref.read(readyOilsRepositoryProvider);
              await repo.deleteReadyOil(widget.existing!.id);
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
    final isEditing = widget.existing != null;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          isEditing ? 'Edit Fragrance Oil' : 'Add Fragrance Oil',
          style: AppTypography.headline(context),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _save,
          child: Text(
            isEditing ? 'Done' : 'Save',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            _buildSectionHeader('OIL INFORMATION'),
            _buildGroupedCard([
              _buildRow('Oil Name *', _nameController,
                  placeholder: 'e.g. Alexandria 2, Aventus Type'),
              _buildDivider(),
              _buildRow('Supplier', _supplierController,
                  placeholder: 'e.g. Luzi, Expressions Parfumées'),
              _buildDivider(),
              _buildRow('Lot / Batch #', _lotController,
                  placeholder: 'e.g. LZ-2026-99'),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('INVENTORY & DOSAGE'),
            _buildGroupedCard([
              _buildRow(
                'Stock (g)',
                _stockController,
                placeholder: '100.0',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              _buildDivider(),
              _buildRow(
                'Rec. Dosage %',
                _dosageController,
                placeholder: '20',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              _buildDivider(),
              _buildRow(
                'Cost / Gram (\$)',
                _costController,
                placeholder: '0.45',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('PERFUMER NOTES'),
            _buildGroupedCard([
              _buildRow(
                'Notes',
                _notesController,
                placeholder: 'e.g. Rich agarwood and lavender oriental blend',
                maxLines: 2,
              ),
            ]),
            if (isEditing) ...[
              const SizedBox(height: 32),
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
                      'Delete Fragrance Oil',
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
          color: AppColors.accent.resolveFrom(context).withValues(alpha: 0.85),
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
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment:
            maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
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
              maxLines: maxLines,
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

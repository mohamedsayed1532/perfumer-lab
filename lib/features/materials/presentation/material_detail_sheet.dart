import 'dart:convert';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import '../data/materials_repository.dart';
import 'create_material_sheet.dart';

class MaterialDetailSheet extends ConsumerWidget {
  final Material material;
  const MaterialDetailSheet({super.key, required this.material});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    IconData noteIcon;
    Color noteColor;
    String noteLabel;
    switch (material.pyramidNote.toLowerCase()) {
      case 'top':
        noteIcon = CupertinoIcons.triangle;
        noteColor = CupertinoColors.systemYellow;
        noteLabel = 'TOP NOTE';
        break;
      case 'heart':
        noteIcon = CupertinoIcons.heart_fill;
        noteColor = CupertinoColors.systemPink;
        noteLabel = 'HEART NOTE';
        break;
      case 'base':
      default:
        noteIcon = CupertinoIcons.triangle_fill;
        noteColor = CupertinoColors.systemPurple;
        noteLabel = 'BASE NOTE';
        break;
    }

    List<String> pictograms = [];
    if (material.hazardPictogramsJson.isNotEmpty) {
      try {
        pictograms = List<String>.from(
            jsonDecode(material.hazardPictogramsJson) as List);
      } catch (_) {}
    }

    return CupertinoPageScaffold(
      backgroundColor: AppColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        middle: Text(material.name, style: AppTypography.headline(context)),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Text('Done'),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context);
            showCupertinoModalPopup(
              context: context,
              builder: (ctx) => CreateMaterialSheet(existing: material),
            );
          },
          child: const Text(
            'Edit',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            // Header Hero Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.secondarySystemGroupedBackground
                    .resolveFrom(context),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: noteColor.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Icon(noteIcon, size: 28, color: noteColor),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          material.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: noteColor.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                noteLabel,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: noteColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (material.casNumber != null)
                              Text(
                                'CAS: ${material.casNumber}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.secondaryLabel
                                      .resolveFrom(context),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Organ & Dilution Specifications
            _buildSectionHeader(context, 'DILUTION & PROPERTIES'),
            _buildGroupedCard(context, [
              _buildDetailRow(
                context,
                'Dilution Ratio',
                '${material.dilutionPercent.toStringAsFixed(0)}% in ${material.defaultSolvent ?? "Neat"}',
              ),
              _buildDivider(context),
              _buildDetailRow(
                context,
                'Odor Intensity',
                '${material.intensity} / 5',
              ),
              if (material.odorLife != null &&
                  material.odorLife!.trim().isNotEmpty) ...[
                _buildDivider(context),
                _buildDetailRow(
                  context,
                  'Odor Life on Blotter',
                  material.odorLife!,
                ),
              ],
              if (material.density != null) ...[
                _buildDivider(context),
                _buildDetailRow(
                  context,
                  'Specific Gravity',
                  '${material.density!.toStringAsFixed(4)} g/ml',
                ),
              ],
              if (material.idealMaxPercent != null) ...[
                _buildDivider(context),
                _buildDetailRow(
                  context,
                  'IFRA Max Usage',
                  '${material.idealMaxPercent!.toStringAsFixed(2)}%',
                ),
              ],
            ]),
            const SizedBox(height: 20),

            // Stock & Cost
            _buildSectionHeader(context, 'INVENTORY & COSTS'),
            _buildGroupedCard(context, [
              _buildDetailRow(
                context,
                'Current Stock',
                '${material.stockGrams.toStringAsFixed(1)} g',
                valueColor: material.stockGrams > 0
                    ? CupertinoColors.systemGreen
                    : CupertinoColors.systemRed,
                isBold: true,
              ),
              if (material.costPerGram > 0) ...[
                _buildDivider(context),
                _buildDetailRow(
                  context,
                  'Cost per Gram',
                  '\$${material.costPerGram.toStringAsFixed(2)} / g',
                ),
                _buildDivider(context),
                _buildDetailRow(
                  context,
                  'Inventory Value',
                  '\$${(material.stockGrams * material.costPerGram).toStringAsFixed(2)}',
                ),
              ],
            ]),
            const SizedBox(height: 20),

            // Botanical / Chemical Nomenclature
            if (material.botanicalName != null ||
                material.iupacName != null) ...[
              _buildSectionHeader(context, 'NOMENCLATURE'),
              _buildGroupedCard(context, [
                if (material.botanicalName != null) ...[
                  _buildDetailRow(
                    context,
                    'Botanical Name',
                    material.botanicalName!,
                  ),
                ],
                if (material.botanicalName != null &&
                    material.iupacName != null)
                  _buildDivider(context),
                if (material.iupacName != null) ...[
                  _buildDetailRow(
                    context,
                    'IUPAC Name',
                    material.iupacName!,
                  ),
                ],
              ]),
              const SizedBox(height: 20),
            ],

            // Notes / Description
            if (material.description != null &&
                material.description!.trim().isNotEmpty) ...[
              _buildSectionHeader(context, 'PERFUMER NOTES'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.secondarySystemGroupedBackground
                      .resolveFrom(context),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  material.description!,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: AppColors.label.resolveFrom(context),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // GHS Hazards
            if (pictograms.isNotEmpty) ...[
              _buildSectionHeader(context, 'SAFETY CLASSIFICATION'),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.secondarySystemGroupedBackground
                      .resolveFrom(context),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: pictograms
                      .map(
                        (pic) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemRed
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: CupertinoColors.systemRed
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                CupertinoIcons.exclamationmark_triangle_fill,
                                size: 14,
                                color: CupertinoColors.systemRed,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                pic.replaceAll('_', ' ').toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: CupertinoColors.systemRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Actions: Edit and Delete
            CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 14),
              color: AppColors.secondarySystemGroupedBackground
                  .resolveFrom(context),
              borderRadius: BorderRadius.circular(14),
              onPressed: () {
                Navigator.pop(context);
                showCupertinoModalPopup(
                  context: context,
                  builder: (ctx) => CreateMaterialSheet(existing: material),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.pencil, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Edit Material Information',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
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
              onPressed: () => _confirmDelete(context, ref),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.trash,
                      size: 18, color: CupertinoColors.systemRed),
                  SizedBox(width: 8),
                  Text(
                    'Delete Material',
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

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text('Delete "${material.name}"?'),
        content: const Text(
          'This will permanently delete this raw material from your lab inventory. This cannot be undone.',
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
              final repo = ref.read(materialsRepositoryProvider);
              await repo.deleteMaterial(material.id);
              await LabHaptics.batchSuccess();
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
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

  Widget _buildGroupedCard(BuildContext context, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondarySystemGroupedBackground.resolveFrom(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.secondaryLabel.resolveFrom(context),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
                color: valueColor ?? AppColors.label.resolveFrom(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      height: 0.5,
      color: AppColors.separator.resolveFrom(context),
    );
  }
}

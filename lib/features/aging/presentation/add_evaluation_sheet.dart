import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import '../data/aging_repository.dart';

class AddEvaluationSheet extends ConsumerStatefulWidget {
  final AgingBatche batch;
  const AddEvaluationSheet({super.key, required this.batch});

  @override
  ConsumerState<AddEvaluationSheet> createState() => _AddEvaluationSheetState();
}

class _AddEvaluationSheetState extends ConsumerState<AddEvaluationSheet> {
  String _clarity = 'crystal_clear';
  late TextEditingController _colorController;
  late TextEditingController _notesController;
  int _alcoholSoftness = 3; // 1-5 scale
  int _harmonyScore = 3; // 1-5 scale
  bool _isChillFiltered = false;

  @override
  void initState() {
    super.initState();
    _colorController = TextEditingController(text: 'Pale Straw Yellow');
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _colorController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final repo = ref.read(agingRepositoryProvider);
    final daysElapsed =
        DateTime.now().difference(widget.batch.startDate).inDays;

    await repo.logEvaluation(
      AgingEvaluationsCompanion.insert(
        id: const Uuid().v4(),
        batchId: widget.batch.id,
        evaluationDate: DateTime.now(),
        dayNumber: daysElapsed >= 0 ? daysElapsed : 0,
        clarity: _clarity,
        colorDescription: _colorController.text.trim().isEmpty
            ? 'Clear'
            : _colorController.text.trim(),
        alcoholSoftness: _alcoholSoftness,
        harmonyScore: _harmonyScore,
        perfumerNotes: drift.Value(_notesController.text.trim()),
        isChillFiltered: drift.Value(_isChillFiltered),
      ),
    );

    await LabHaptics.stepCompleted();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        middle: Text('Evaluation: Day ${DateTime.now().difference(widget.batch.startDate).inDays}',
            style: AppTypography.headline(context)),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _save,
          child: const Text('Save', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Visual clarity',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryLabel.resolveFrom(context),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: CupertinoSlidingSegmentedControl<String>(
                groupValue: _clarity,
                thumbColor: AppColors.accent.resolveFrom(context),
                backgroundColor: AppColors.secondarySystemGroupedBackground
                    .resolveFrom(context),
                children: {
                  'crystal_clear': _buildClarityLabel(
                      'Crystal Clear', _clarity == 'crystal_clear'),
                  'slightly_hazy': _buildClarityLabel(
                      'Slight Haze', _clarity == 'slightly_hazy'),
                  'sediment':
                      _buildClarityLabel('Sediment', _clarity == 'sediment'),
                },
                onValueChanged: (val) {
                  if (val != null) setState(() => _clarity = val);
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Solution color',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryLabel.resolveFrom(context),
              ),
            ),
            const SizedBox(height: 8),
            CupertinoTextField(
              controller: _colorController,
              placeholder: 'Pale straw, amber, colorless',
              padding: const EdgeInsets.all(12),
            ),
            const SizedBox(height: 24),
            Text(
              'Sensory maturity scores (1–5)',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryLabel.resolveFrom(context),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.secondarySystemGroupedBackground
                    .resolveFrom(context),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.separator.resolveFrom(context),
                  width: 0.5,
                ),
              ),
              child: Column(
                children: [
                  _buildRatingRow(
                    'Alcohol Softness / Dissipation',
                    _alcoholSoftness,
                    (val) => setState(() => _alcoholSoftness = val),
                  ),
                  Container(
                    height: 0.5,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    color: AppColors.separator.resolveFrom(context),
                  ),
                  _buildRatingRow(
                    'Blend Balance & Harmony',
                    _harmonyScore,
                    (val) => setState(() => _harmonyScore = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chill-Filtered Solution?',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.label.resolveFrom(context),
                  ),
                ),
                CupertinoSwitch(
                  value: _isChillFiltered,
                  onChanged: (val) => setState(() => _isChillFiltered = val),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Perfumer sensory log',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryLabel.resolveFrom(context),
              ),
            ),
            const SizedBox(height: 8),
            CupertinoTextField(
              controller: _notesController,
              maxLines: 4,
              placeholder:
                  'Top notes smoothing, drydown longevity, off-notes',
              padding: const EdgeInsets.all(12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClarityLabel(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected
              ? AppColors.onAccent(context)
              : AppColors.label.resolveFrom(context),
        ),
      ),
    );
  }

  Widget _buildRatingRow(
      String title, int currentVal, ValueChanged<int> onSelect) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.label.resolveFrom(context),
            ),
          ),
        ),
        Row(
          children: List.generate(5, (index) {
            final active = index < currentVal;
            return GestureDetector(
              onTap: () => onSelect(index + 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  active ? CupertinoIcons.circle_fill : CupertinoIcons.circle,
                  size: 20,
                  color: active
                      ? AppColors.accent.resolveFrom(context)
                      : AppColors.tertiaryLabel.resolveFrom(context),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

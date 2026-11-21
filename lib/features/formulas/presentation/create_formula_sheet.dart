import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as drift;
import 'package:perfumery_lab/core/database/app_database.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/utils/haptics.dart';
import '../data/formulas_repository.dart';
import 'formula_detail_screen.dart';

class CreateFormulaSheet extends ConsumerStatefulWidget {
  const CreateFormulaSheet({super.key});

  @override
  ConsumerState<CreateFormulaSheet> createState() => _CreateFormulaSheetState();
}

class _CreateFormulaSheetState extends ConsumerState<CreateFormulaSheet> {
  final _nameController = TextEditingController();
  final _versionController = TextEditingController(text: '1.0');
  final _descriptionController = TextEditingController();
  final _customConcentrationController = TextEditingController(text: '20.0');

  double _targetConcentration = 20.0;
  String _concentrationType = 'edp20';

  @override
  void dispose() {
    _nameController.dispose();
    _versionController.dispose();
    _descriptionController.dispose();
    _customConcentrationController.dispose();
    super.dispose();
  }

  void _onConcentrationSegmentChanged(String? val) {
    if (val == null) return;
    setState(() {
      _concentrationType = val;
      switch (val) {
        case 'edt10':
          _targetConcentration = 10.0;
          _customConcentrationController.text = '10.0';
          break;
        case 'edt15':
          _targetConcentration = 15.0;
          _customConcentrationController.text = '15.0';
          break;
        case 'edp20':
          _targetConcentration = 20.0;
          _customConcentrationController.text = '20.0';
          break;
        case 'extrait25':
          _targetConcentration = 25.0;
          _customConcentrationController.text = '25.0';
          break;
        case 'custom':
          _targetConcentration =
              double.tryParse(_customConcentrationController.text) ?? 20.0;
          break;
      }
    });
  }

  Future<void> _create() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Formula Name Required'),
          content: const Text('Please enter a name for your fragrance formula.'),
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

    final formulaId = const Uuid().v4();
    final repo = ref.read(formulasRepositoryProvider);

    await repo.createFormula(
      FormulasCompanion.insert(
        id: formulaId,
        name: name,
        version: drift.Value(_versionController.text.trim().isEmpty
            ? '1.0'
            : _versionController.text.trim()),
        targetConcentrationPercent: drift.Value(_targetConcentration),
        description: drift.Value(_descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim()),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );

    await LabHaptics.stepCompleted();

    if (!mounted) return;
    Navigator.pop(context);

    // Immediately push formula detail screen so perfumer can start adding materials
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => FormulaDetailScreen(formulaId: formulaId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        middle: Text('New Formula', style: AppTypography.headline(context)),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _create,
          child: const Text(
            'Create',
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
              _buildTextField('Formula Name *', _nameController,
                  placeholder: 'e.g. Santal Minimal, Citrus Amber'),
              _buildDivider(),
              _buildTextField('Version', _versionController,
                  placeholder: 'e.g. 1.0, Mod 3'),
              _buildDivider(),
              _buildTextField('Description / Notes', _descriptionController,
                  placeholder: 'e.g. Warm woody profile with creamy sandalwood',
                  maxLines: 2),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('CONCENTRATION TARGET'),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<String>(
                  groupValue: _concentrationType,
                  thumbColor: AppColors.accent.resolveFrom(context),
                  backgroundColor: AppColors.secondarySystemGroupedBackground
                      .resolveFrom(context),
                  children: {
                    'edt10': _buildSegmentLabel(
                        '10% EdT', _concentrationType == 'edt10'),
                    'edt15': _buildSegmentLabel(
                        '15% EdT', _concentrationType == 'edt15'),
                    'edp20': _buildSegmentLabel(
                        '20% EdP', _concentrationType == 'edp20'),
                    'extrait25': _buildSegmentLabel(
                        '25% Ext.', _concentrationType == 'extrait25'),
                    'custom': _buildSegmentLabel(
                        'Custom', _concentrationType == 'custom'),
                  },
                  onValueChanged: _onConcentrationSegmentChanged,
                ),
              ),
            ),
            if (_concentrationType == 'custom') ...[
              _buildCard([
                _buildTextField(
                  'Custom Target %',
                  _customConcentrationController,
                  placeholder: 'e.g. 18.5',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (val) {
                    final d = double.tryParse(val);
                    if (d != null) setState(() => _targetConcentration = d);
                  },
                ),
              ]),
            ],
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Concentration determines the oil concentrate to alcohol dilution ratio during bench compounding.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.secondaryLabel.resolveFrom(context),
                ),
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
          color: AppColors.accent.resolveFrom(context).withValues(alpha: 0.85),
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color:
            AppColors.secondarySystemGroupedBackground.resolveFrom(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    String? placeholder,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    ValueChanged<String>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment:
            maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 130,
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

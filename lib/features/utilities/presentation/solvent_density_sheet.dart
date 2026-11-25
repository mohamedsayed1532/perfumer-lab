import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';

class SolventDensitySheet extends StatefulWidget {
  const SolventDensitySheet({super.key});

  @override
  State<SolventDensitySheet> createState() => _SolventDensitySheetState();
}

class _SolventDensitySheetState extends State<SolventDensitySheet> {
  static const Map<String, double> _solvents = {
    'DPG (Dipropylene Glycol)': 1.023,
    'TEC (Triethyl Citrate)': 1.137,
    'IPM (Isopropyl Myristate)': 0.853,
    'Ethanol 96°': 0.806,
    'Water': 1.000,
  };

  String _selectedSolvent = 'DPG (Dipropylene Glycol)';
  final _amountController = TextEditingController(text: '100.0');
  bool _isConvertingFromVolume = true; // true: ml -> grams, false: grams -> ml

  double _result = 102.3;

  @override
  void initState() {
    super.initState();
    _recalculate();
  }

  void _recalculate() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final density = _solvents[_selectedSolvent] ?? 1.0;

    setState(() {
      if (_isConvertingFromVolume) {
        // mass (g) = volume (ml) * density (g/cm3)
        _result = amount * density;
      } else {
        // volume (ml) = mass (g) / density (g/cm3)
        _result = density > 0 ? amount / density : 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final density = _solvents[_selectedSolvent] ?? 1.0;

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.75,
      decoration: BoxDecoration(
        color: AppColors.systemGroupedBackground.resolveFrom(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 8),
              width: 36,
              height: 4.5,
              decoration: BoxDecoration(
                color: AppColors.secondaryLabel.resolveFrom(context).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Solvent Density & Mass', style: AppTypography.headline(context)),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                LiquidGlass(
                  padding: const EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select solvent',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryLabel.resolveFrom(context),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ..._solvents.keys.map((solvent) {
                        final isSelected = solvent == _selectedSolvent;
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            setState(() => _selectedSolvent = solvent);
                            _recalculate();
                          },
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 44),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  solvent,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                    color: isSelected
                                        ? AppColors.accent.resolveFrom(context)
                                        : AppColors.label.resolveFrom(context),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    CupertinoIcons.checkmark_alt,
                                    size: 18,
                                    color: AppColors.accent.resolveFrom(context),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                LiquidGlass(
                  padding: const EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoSlidingSegmentedControl<bool>(
                          groupValue: _isConvertingFromVolume,
                          thumbColor: AppColors.accent.resolveFrom(context),
                          backgroundColor: AppColors
                              .tertiarySystemGroupedBackground
                              .resolveFrom(context),
                          children: {
                            true: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: Text(
                                'ml → grams',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: _isConvertingFromVolume
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: _isConvertingFromVolume
                                      ? AppColors.onAccent(context)
                                      : AppColors.label.resolveFrom(context),
                                ),
                              ),
                            ),
                            false: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: Text(
                                'grams → ml',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: !_isConvertingFromVolume
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: !_isConvertingFromVolume
                                      ? AppColors.onAccent(context)
                                      : AppColors.label.resolveFrom(context),
                                ),
                              ),
                            ),
                          },
                          onValueChanged: (val) {
                            if (val != null) {
                              setState(() => _isConvertingFromVolume = val);
                              _recalculate();
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        _isConvertingFromVolume ? 'Input Volume (ml)' : 'Input Mass (grams)',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.secondaryLabel.resolveFrom(context),
                        ),
                      ),
                      const SizedBox(height: 6),
                      CupertinoTextField(
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.label.resolveFrom(context),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondarySystemGroupedBackground.resolveFrom(context),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.separator.resolveFrom(context),
                            width: 0.5,
                          ),
                        ),
                        onChanged: (_) => _recalculate(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                LiquidGlass(
                  padding: const EdgeInsets.all(18),
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Calculated value (density ${density.toStringAsFixed(3)} g/cm³)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryLabel.resolveFrom(context),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _isConvertingFromVolume ? 'Target Weight (Scale):' : 'Volume:',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            _isConvertingFromVolume
                                ? '${_result.toStringAsFixed(2)} g'
                                : '${_result.toStringAsFixed(2)} ml',
                            style: AppTypography.precisionNumber(context, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

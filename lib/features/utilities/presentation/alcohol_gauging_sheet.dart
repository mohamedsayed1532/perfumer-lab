import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';

class AlcoholGaugingSheet extends StatefulWidget {
  const AlcoholGaugingSheet({super.key});

  @override
  State<AlcoholGaugingSheet> createState() => _AlcoholGaugingSheetState();
}

class _AlcoholGaugingSheetState extends State<AlcoholGaugingSheet> {
  final _startABVController = TextEditingController(text: '96.0');
  final _targetABVController = TextEditingController(text: '80.0');
  final _targetVolumeController = TextEditingController(text: '1000.0');

  double _alcoholNeededMl = 833.3;
  double _waterNeededMl = 188.7; // Includes contraction allowance (~2.2%)

  @override
  void initState() {
    super.initState();
    _recalculate();
  }

  void _recalculate() {
    final startABV = double.tryParse(_startABVController.text) ?? 96.0;
    final targetABV = double.tryParse(_targetABVController.text) ?? 80.0;
    final targetVol = double.tryParse(_targetVolumeController.text) ?? 1000.0;

    if (startABV <= 0 || targetABV <= 0 || startABV <= targetABV || targetVol <= 0) {
      setState(() {
        _alcoholNeededMl = 0;
        _waterNeededMl = 0;
      });
      return;
    }

    // Formula: V1 = (C2 * V2) / C1
    final alcoholVol = (targetABV * targetVol) / startABV;

    // Volumetric ethanol-water contraction factor (typically ~2.2% to 2.8% volume contraction upon dilution)
    const contractionFactor = 1.022;
    final theoreticalWater = targetVol - alcoholVol;
    final waterWithContraction = theoreticalWater * contractionFactor;

    setState(() {
      _alcoholNeededMl = alcoholVol;
      _waterNeededMl = waterWithContraction;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                Text('Alcohol Gauging & Proof', style: AppTypography.headline(context)),
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
                        'TARGET COMPOUND BATCH',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: AppColors.secondaryLabel.resolveFrom(context),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInputField('Target Final Volume (ml)', _targetVolumeController),
                      const SizedBox(height: 10),
                      _buildInputField('Target Strength (% ABV / °)', _targetABVController),
                      const SizedBox(height: 10),
                      _buildInputField('Starting Spirit ABV (e.g. 96°)', _startABVController),
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
                        'REQUIRED QUANTITIES (WITH CONTRACTION)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: AppColors.secondaryLabel.resolveFrom(context),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Base Spirit Volume:', style: TextStyle(fontSize: 15)),
                          Text(
                            '${_alcoholNeededMl.toStringAsFixed(1)} ml',
                            style: AppTypography.precisionNumber(context, fontSize: 17),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Distilled Water Volume:', style: TextStyle(fontSize: 15)),
                          Text(
                            '${_waterNeededMl.toStringAsFixed(1)} ml',
                            style: AppTypography.precisionNumber(context, fontSize: 17),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Note: Water volume includes thermodynamic ethanol-water contraction compensation for ambient 20°C.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.secondaryLabel.resolveFrom(context),
                        ),
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

  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: AppColors.label.resolveFrom(context)),
        ),
        const SizedBox(height: 5),
        CupertinoTextField(
          controller: controller,
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
    );
  }
}

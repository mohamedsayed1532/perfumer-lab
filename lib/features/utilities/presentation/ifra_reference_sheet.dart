import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';

class _IfraEntry {
  final String name;
  final String cas;
  final String cat4Limit;
  final String note;
  final bool isRestricted;

  const _IfraEntry({
    required this.name,
    required this.cas,
    required this.cat4Limit,
    required this.note,
    this.isRestricted = true,
  });
}

class IfraReferenceSheet extends StatefulWidget {
  const IfraReferenceSheet({super.key});

  @override
  State<IfraReferenceSheet> createState() => _IfraReferenceSheetState();
}

class _IfraReferenceSheetState extends State<IfraReferenceSheet> {
  static const List<_IfraEntry> _entries = [
    _IfraEntry(
      name: 'Isoeugenol',
      cas: '97-54-1',
      cat4Limit: '0.02%',
      note: 'Sensitizer; strict limit in fine fragrance.',
    ),
    _IfraEntry(
      name: 'Methyl Octine Carbonate',
      cas: '111-80-8',
      cat4Limit: '0.01%',
      note: 'Trace violet-leaf ester; tight Cat 4 cap.',
    ),
    _IfraEntry(
      name: 'Bergapten (5-MOP)',
      cas: '484-20-8',
      cat4Limit: '0.015%',
      note: 'Phototoxicity cap in expressed citrus oils.',
    ),
    _IfraEntry(
      name: 'Cinnamal',
      cas: '104-55-2',
      cat4Limit: '0.05%',
      note: 'Sensitizer; use FCF or low-cinnamal grades.',
    ),
    _IfraEntry(
      name: 'Oakmoss Absolute (Evernia prunastri)',
      cas: '90028-68-5',
      cat4Limit: '0.10%',
      note: 'Atranol & chloroatranol must each be < 100 ppm.',
    ),
    _IfraEntry(
      name: 'Treemoss Absolute (Evernia furfuracea)',
      cas: '90028-67-4',
      cat4Limit: '0.10%',
      note: 'Same atranol/chloroatranol purity standard.',
    ),
    _IfraEntry(
      name: 'Eugenol',
      cas: '97-53-0',
      cat4Limit: '0.50%',
      note: 'Clove/spicy phenol; cumulative across naturals.',
    ),
    _IfraEntry(
      name: 'Citral',
      cas: '5392-40-5',
      cat4Limit: '0.60%',
      note: 'Includes citral from lemongrass, litsea & lemon.',
    ),
    _IfraEntry(
      name: 'Hydroxycitronellal',
      cas: '107-75-5',
      cat4Limit: '1.00%',
      note: 'Muguet aldehyde; Cat 4 dermal sensitization cap.',
    ),
    _IfraEntry(
      name: 'Farnesol',
      cas: '4602-84-0',
      cat4Limit: '1.20%',
      note: 'Floral sesquiterpene alcohol.',
    ),
    _IfraEntry(
      name: 'Coumarin',
      cas: '91-64-5',
      cat4Limit: '1.50%',
      note: 'Tonka lactone; standard Cat 4 fine fragrance limit.',
    ),
    _IfraEntry(
      name: 'Benzyl Salicylate',
      cas: '118-58-1',
      cat4Limit: '2.50%',
      note: 'Solar floral fixative; Cat 4 threshold.',
      isRestricted: false,
    ),
  ];

  String _query = '';
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _entries.where((e) {
      if (_query.isEmpty) return true;
      return e.name.toLowerCase().contains(_query) ||
          e.cas.toLowerCase().contains(_query) ||
          e.note.toLowerCase().contains(_query);
    }).toList();

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.82,
      decoration: BoxDecoration(
        color: AppColors.systemGroupedBackground.resolveFrom(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 8),
              width: 36,
              height: 4.5,
              decoration: BoxDecoration(
                color: AppColors.secondaryLabel
                    .resolveFrom(context)
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('IFRA 51st Reference',
                    style: AppTypography.headline(context)),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
            child: CupertinoSearchTextField(
              focusNode: _focusNode,
              placeholder: 'Search material or CAS',
              placeholderStyle: TextStyle(
                color: AppColors.tertiaryLabel.resolveFrom(context),
                fontSize: 14.5,
              ),
              style: TextStyle(
                color: AppColors.label.resolveFrom(context),
                fontSize: 14.5,
              ),
              itemColor: AppColors.accent.resolveFrom(context),
              cursorColor: AppColors.accent.resolveFrom(context),
              decoration: BoxDecoration(
                color: AppColors.secondarySystemGroupedBackground
                    .resolveFrom(context),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _focusNode.hasFocus
                      ? AppColors.accent.resolveFrom(context)
                      : AppColors.cardBorder.resolveFrom(context),
                  width: _focusNode.hasFocus ? 1.25 : 0.75,
                ),
              ),
              padding: const EdgeInsetsDirectional.fromSTEB(6, 10, 6, 10),
              prefixInsets:
                  const EdgeInsetsDirectional.fromSTEB(10, 10, 6, 10),
              onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
              itemCount: filtered.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final entry = filtered[index];
                return LiquidGlass(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  borderRadius: BorderRadius.circular(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.name,
                              style: AppTypography.atelierCardTitle(context,
                                  fontSize: 15.5),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'CAS ${entry.cas} • ${entry.note}',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.secondaryLabel
                                    .resolveFrom(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            entry.cat4Limit,
                            style: AppTypography.precisionNumber(context,
                                    fontSize: 16)
                                .copyWith(
                              color: entry.isRestricted
                                  ? AppColors.accent.resolveFrom(context)
                                  : CupertinoColors.systemGreen,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Cat 4 max',
                            style: TextStyle(
                              fontSize: 11,
                              color:
                                  AppColors.tertiaryLabel.resolveFrom(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

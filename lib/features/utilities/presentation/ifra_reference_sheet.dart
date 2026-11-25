import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:perfumery_lab/core/services/ifra_catalog_service.dart';
import 'package:perfumery_lab/core/theme/app_colors.dart';
import 'package:perfumery_lab/core/theme/app_typography.dart';
import 'package:perfumery_lab/core/theme/liquid_glass.dart';

class IfraReferenceSheet extends ConsumerStatefulWidget {
  const IfraReferenceSheet({super.key});

  @override
  ConsumerState<IfraReferenceSheet> createState() =>
      _IfraReferenceSheetState();
}

class _IfraReferenceSheetState extends ConsumerState<IfraReferenceSheet> {
  String _mode = 'standards'; // 'standards' | 'ncs'
  String _typeFilter = 'all'; // 'all' | 'restricted' | 'prohibited' | 'spec' | '51'
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
    final catalogAsync = ref.watch(ifraCatalogProvider);

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.88,
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('IFRA 51st Library',
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
          catalogAsync.when(
            loading: () => const Expanded(
              child: Center(child: CupertinoActivityIndicator()),
            ),
            error: (err, _) => Expanded(
              child: Center(child: Text('Error loading IFRA database: $err')),
            ),
            data: (catalog) => Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: CupertinoSlidingSegmentedControl<String>(
                        groupValue: _mode,
                        thumbColor: AppColors.accent.resolveFrom(context),
                        backgroundColor: AppColors
                            .secondarySystemGroupedBackground
                            .resolveFrom(context),
                        children: {
                          'standards': _buildModeTab(
                            context,
                            'Standards (${catalog.standards.length})',
                            _mode == 'standards',
                          ),
                          'ncs': _buildModeTab(
                            context,
                            'Natural Extracts (${catalog.ncsEntries.length})',
                            _mode == 'ncs',
                          ),
                        },
                        onValueChanged: (v) {
                          if (v != null) setState(() => _mode = v);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: CupertinoSearchTextField(
                      focusNode: _focusNode,
                      placeholder: _mode == 'standards'
                          ? 'Search 263 standards, CAS, synonym'
                          : 'Search 302 essential oils, botanical, CAS',
                      placeholderStyle: TextStyle(
                        color: AppColors.tertiaryLabel.resolveFrom(context),
                        fontSize: 14,
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
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _focusNode.hasFocus
                              ? AppColors.accent.resolveFrom(context)
                              : AppColors.cardBorder.resolveFrom(context),
                          width: _focusNode.hasFocus ? 1.25 : 0.75,
                        ),
                      ),
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(6, 10, 6, 10),
                      prefixInsets:
                          const EdgeInsetsDirectional.fromSTEB(10, 10, 6, 10),
                      onChanged: (v) =>
                          setState(() => _query = v.trim().toLowerCase()),
                    ),
                  ),
                  if (_mode == 'standards')
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                      child: Row(
                        children: [
                          _buildFilterChip('all', 'All'),
                          const SizedBox(width: 8),
                          _buildFilterChip('restricted', 'Restricted'),
                          const SizedBox(width: 8),
                          _buildFilterChip('prohibited', 'Prohibited'),
                          const SizedBox(width: 8),
                          _buildFilterChip('spec', 'Specification'),
                          const SizedBox(width: 8),
                          _buildFilterChip('51', '51st Amdt'),
                        ],
                      ),
                    ),
                  Expanded(
                    child: _mode == 'standards'
                        ? _buildStandardsList(context, catalog)
                        : _buildNcsList(context, catalog),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeTab(BuildContext context, String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected
              ? AppColors.onAccent(context)
              : AppColors.label.resolveFrom(context),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String id, String label) {
    final isSelected = _typeFilter == id;
    return GestureDetector(
      onTap: () => setState(() => _typeFilter = id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent.resolveFrom(context)
              : AppColors.secondarySystemGroupedBackground.resolveFrom(context),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.accent.resolveFrom(context)
                : AppColors.cardBorder.resolveFrom(context),
            width: 0.75,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? AppColors.onAccent(context)
                : AppColors.secondaryLabel.resolveFrom(context),
          ),
        ),
      ),
    );
  }

  Widget _buildStandardsList(BuildContext context, IfraCatalogData catalog) {
    final filtered = catalog.standards.where((s) {
      if (_typeFilter == 'restricted' && !s.isRestricted) return false;
      if (_typeFilter == 'prohibited' && !s.isProhibited) return false;
      if (_typeFilter == 'spec' && !s.isSpecification) return false;
      if (_typeFilter == '51' && s.amendment != '51') return false;

      if (_query.isEmpty) return true;
      return s.name.toLowerCase().contains(_query) ||
          s.key.toLowerCase().contains(_query) ||
          s.cas.any((c) => c.toLowerCase().contains(_query)) ||
          s.synonyms.any((syn) => syn.toLowerCase().contains(_query));
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          'No matching IFRA standards',
          style: AppTypography.subheadline(context),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 28),
      itemCount: filtered.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final std = filtered[index];
        final isProh = std.type == 'PROHIBITION';
        final cat4Text = std.displayLimitFor('Cat 4');
        final statusColor = isProh
            ? CupertinoColors.systemRed
            : (std.isRestricted
                ? AppColors.accentInk.resolveFrom(context)
                : AppColors.naturalGreen.resolveFrom(context));

        return GestureDetector(
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (_) => IfraStandardDetailSheet(standard: std),
            );
          },
          child: LiquidGlass(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            borderRadius: BorderRadius.circular(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        std.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.atelierCardTitle(context,
                            fontSize: 15.5),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${std.cas.isNotEmpty ? 'CAS ${std.cas.first}' : std.key} • Amdt ${std.amendment} • ${std.type.replaceAll('_', ' / ')}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.monoData(context, fontSize: 11),
                      ),
                      if (std.endpoint.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          std.endpoint,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.5,
                            color: AppColors.tertiaryLabel.resolveFrom(context),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      cat4Text,
                      style: AppTypography.monoData(
                        context,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Cat 4 max',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: AppColors.tertiaryLabel.resolveFrom(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNcsList(BuildContext context, IfraCatalogData catalog) {
    final filtered = catalog.ncsEntries.where((n) {
      if (_query.isEmpty) return true;
      return n.name.toLowerCase().contains(_query) ||
          n.botanical.toLowerCase().contains(_query) ||
          n.cas.any((c) => c.toLowerCase().contains(_query)) ||
          n.constituents.any((c) => c.name.toLowerCase().contains(_query));
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          'No matching natural extracts',
          style: AppTypography.subheadline(context),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 28),
      itemCount: filtered.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final ncs = filtered[index];
        return GestureDetector(
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (_) => IfraNcsDetailSheet(ncs: ncs),
            );
          },
          child: LiquidGlass(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            borderRadius: BorderRadius.circular(14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ncs.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.atelierCardTitle(context,
                            fontSize: 15.5),
                      ),
                      const SizedBox(height: 2),
                      if (ncs.botanical.isNotEmpty)
                        Text(
                          ncs.botanical,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.secondaryLabel.resolveFrom(context),
                          ),
                        ),
                      const SizedBox(height: 2),
                      Text(
                        '${ncs.cas.isNotEmpty ? 'CAS ${ncs.cas.first} • ' : ''}${ncs.constituents.length} regulated constituents',
                        style: AppTypography.monoData(context, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Icon(
                  CupertinoIcons.chevron_forward,
                  size: 16,
                  color: AppColors.tertiaryLabel.resolveFrom(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class IfraStandardDetailSheet extends StatelessWidget {
  final IfraStandard standard;
  const IfraStandardDetailSheet({super.key, required this.standard});

  @override
  Widget build(BuildContext context) {
    final isProh = standard.type == 'PROHIBITION';
    final badgeColor = isProh
        ? CupertinoColors.systemRed
        : (standard.isRestricted
            ? AppColors.accent.resolveFrom(context)
            : AppColors.naturalGreen.resolveFrom(context));

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.86,
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${standard.key} • Amdt ${standard.amendment}',
                  style: AppTypography.monoData(
                    context,
                    fontSize: 12.5,
                    color: AppColors.accentInk.resolveFrom(context),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
              children: [
                LiquidGlass(
                  padding: const EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: badgeColor.withValues(alpha: 0.35),
                            width: 0.6,
                          ),
                        ),
                        child: Text(
                          standard.type.replaceAll('_', ' / '),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: badgeColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        standard.name,
                        style: AppTypography.title2(context),
                      ),
                      if (standard.cas.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          'CAS: ${standard.cas.join(', ')}',
                          style: AppTypography.monoData(context, fontSize: 12),
                        ),
                      ],
                      if (standard.endpoint.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Risk endpoint: ${standard.endpoint}',
                          style: TextStyle(
                            fontSize: 13,
                            color:
                                AppColors.secondaryLabel.resolveFrom(context),
                          ),
                        ),
                      ],
                      if (standard.deadlineNew.isNotEmpty ||
                          standard.deadlineExisting.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Deadlines — New: ${standard.deadlineNew} • Existing: ${standard.deadlineExisting}',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: AppColors.tertiaryLabel.resolveFrom(context),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (standard.synonyms.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildHeader(context, 'Synonyms'),
                  LiquidGlass(
                    padding: const EdgeInsets.all(14),
                    borderRadius: BorderRadius.circular(14),
                    child: Text(
                      standard.synonyms.join(' • '),
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.secondaryLabel.resolveFrom(context),
                      ),
                    ),
                  ),
                ],
                if (standard.notes.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildHeader(context, 'Official Notes & Specifications'),
                  LiquidGlass(
                    padding: const EdgeInsets.all(14),
                    borderRadius: BorderRadius.circular(14),
                    child: Text(
                      standard.notes,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.45,
                        color: AppColors.secondaryLabel.resolveFrom(context),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                _buildHeader(context, 'All 18 IFRA Product Category Limits'),
                LiquidGlass(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  borderRadius: BorderRadius.circular(14),
                  child: Column(
                    children: [
                      for (int i = 0; i < ifraCategories.length; i++) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  ifraCategories[i].$2,
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: ifraCategories[i].$1 == 'Cat 4'
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: ifraCategories[i].$1 == 'Cat 4'
                                        ? AppColors.accentInk
                                            .resolveFrom(context)
                                        : AppColors.label.resolveFrom(context),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                standard.displayLimitFor(ifraCategories[i].$1),
                                style: AppTypography.monoData(
                                  context,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isProh
                                      ? CupertinoColors.systemRed
                                      : (ifraCategories[i].$1 == 'Cat 4'
                                          ? AppColors.accent
                                              .resolveFrom(context)
                                          : AppColors.label
                                              .resolveFrom(context)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (i < ifraCategories.length - 1)
                          Container(
                            height: 0.5,
                            margin: const EdgeInsets.only(left: 14),
                            color: AppColors.separator.resolveFrom(context),
                          ),
                      ],
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

  Widget _buildHeader(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryLabel.resolveFrom(context),
        ),
      ),
    );
  }
}

class IfraNcsDetailSheet extends ConsumerWidget {
  final IfraNcsEntry ncs;
  const IfraNcsDetailSheet({super.key, required this.ncs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(ifraCatalogProvider).value;

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.78,
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Natural Complex Substance · Amdt ${ncs.amendment}',
                  style: AppTypography.monoData(
                    context,
                    fontSize: 12,
                    color: AppColors.naturalGreen.resolveFrom(context),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
              children: [
                LiquidGlass(
                  padding: const EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ncs.name, style: AppTypography.title2(context)),
                      if (ncs.botanical.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          ncs.botanical,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                AppColors.secondaryLabel.resolveFrom(context),
                          ),
                        ),
                      ],
                      if (ncs.cas.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          'CAS: ${ncs.cas.join(', ')}',
                          style: AppTypography.monoData(context, fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 8),
                  child: Text(
                    'IFRA-regulated constituents (${ncs.constituents.length})',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryLabel.resolveFrom(context),
                    ),
                  ),
                ),
                LiquidGlass(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  borderRadius: BorderRadius.circular(14),
                  child: Column(
                    children: [
                      for (int i = 0; i < ncs.constituents.length; i++) ...[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: catalog == null
                              ? null
                              : () {
                                  final std = catalog.findStandardForMaterial(
                                    casNumber: ncs.constituents[i].cas,
                                    name: ncs.constituents[i].name,
                                  );
                                  if (std != null) {
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (_) => IfraStandardDetailSheet(
                                          standard: std),
                                    );
                                  }
                                },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ncs.constituents[i].name,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              AppColors.label.resolveFrom(context),
                                        ),
                                      ),
                                      Text(
                                        'CAS ${ncs.constituents[i].cas}',
                                        style: AppTypography.monoData(
                                            context,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  ncs.constituents[i].typicalPercentDisplay,
                                  style: AppTypography.monoData(
                                    context,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        AppColors.accentInk.resolveFrom(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (i < ncs.constituents.length - 1)
                          Container(
                            height: 0.5,
                            margin: const EdgeInsets.only(left: 14),
                            color: AppColors.separator.resolveFrom(context),
                          ),
                      ],
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

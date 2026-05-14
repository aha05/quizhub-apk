import 'package:flutter/material.dart';
import 'package:quizhub/features/home/presentation/theme/home_colors.dart';
import 'package:quizhub/features/home/presentation/widgets/temp-data/category.dart';

class SearchDropdown extends StatelessWidget {
  final List<Category> results;
  final VoidCallback onDismiss;
  final String searchQuery;
  final LayerLink searchLayerLink;

  const SearchDropdown({
    super.key,
    required this.results,
    required this.onDismiss,
    required this.searchQuery,
    required this.searchLayerLink,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.translucent,
            child: const SizedBox.expand(),
          ),
        ),
        CompositedTransformFollower(
          link: searchLayerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 52),
          child: Align(
            alignment: Alignment.topLeft,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width - 32,
                constraints: const BoxConstraints(maxHeight: 320),
                decoration: BoxDecoration(
                  color: HomeColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: HomeColors.border, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: results.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search_off_rounded,
                              color: HomeColors.textLight,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'No results for "$searchQuery"',
                              style: const TextStyle(
                                color: HomeColors.textLight,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          itemCount: results.length,
                          separatorBuilder: (_, __) => const Divider(
                            color: HomeColors.border,
                            height: 1,
                            indent: 56,
                            endIndent: 12,
                          ),
                          itemBuilder: (_, i) {
                            final cat = results[i];
                            return InkWell(
                              onTap: () {
                                onDismiss;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Opening ${cat.name}…'),
                                    duration: const Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 38,
                                      height: 38,
                                      decoration: BoxDecoration(
                                        color: cat.color.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          cat.icon,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cat.name,
                                            style: const TextStyle(
                                              color: HomeColors.textDark,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            '${cat.questions} questions',
                                            style: const TextStyle(
                                              color: HomeColors.textLight,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 14,
                                      color: cat.color,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

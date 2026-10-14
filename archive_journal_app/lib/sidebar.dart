import 'package:flutter/material.dart';

import 'theme.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
    required this.labels,
    required this.icons,
    required this.selected,
    required this.onSelect,
    required this.onQuickScribble,
  });

  final List<String> labels;
  final List<IconData> icons;
  final int selected;
  final ValueChanged<int> onSelect;
  final VoidCallback onQuickScribble;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: const BoxDecoration(
        color: AppColors.sidebar,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PERSONAL JOURNAL',
                        style: labelStyle.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text('VOLUME ${DateTime.now().year}',
                        style: labelStyle.copyWith(fontSize: 10)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              for (var i = 0; i < labels.length; i++)
                GestureDetector(
                  onTap: () => onSelect(i),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: i == selected
                          ? AppColors.cream
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(children: [
                      Icon(icons[i], size: 20, color: AppColors.brown),
                      const SizedBox(width: 12),
                      Text(
                        labels[i].toUpperCase(),
                        style: labelStyle.copyWith(
                          fontWeight:
                              i == selected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ]),
                  ),
                ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.brown,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: onQuickScribble,
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('QUICK SCRIBBLE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

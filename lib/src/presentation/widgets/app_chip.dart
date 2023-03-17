import 'package:flutter/material.dart';

class AppMaterialYouChip extends StatelessWidget {
  const AppMaterialYouChip({
    required this.title,
    required this.onPressed,
    required this.isSelected,
  });

  final String title;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final borderRadius = isSelected ? BorderRadius.circular(28) : BorderRadius.circular(12);
    final colorPrimary =
        isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface;
    final colorOnPrimary = isSelected
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSurface;
    return Row(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: colorPrimary,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Text(
                title,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8)
      ],
    );
  }
}

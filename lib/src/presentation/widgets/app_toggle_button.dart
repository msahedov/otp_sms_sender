import 'package:flutter/material.dart';

enum ItemIndex { first, middle, last }

class AppToggleButton extends StatelessWidget {
  const AppToggleButton({
    required this.title,
    required this.isSelected,
    required this.onPressed,
    this.itemIndex = ItemIndex.middle,
  });
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;
  final ItemIndex itemIndex;
  @override
  Widget build(BuildContext context) {
    final textColor = isSelected ? Theme.of(context).colorScheme.primary : null;
    final color = isSelected ? Theme.of(context).colorScheme.primaryVariant : null;
    final BorderRadius borderRadius = itemIndex == ItemIndex.first
        ? const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )
        : itemIndex == ItemIndex.last
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              )
            : const BorderRadius.only();
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.all(14.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

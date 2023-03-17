import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.elevation,
    this.color,
    this.shape,
  });

  final Widget child;
  final double? elevation;
  final Color? color;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: color ?? Theme.of(context).colorScheme.surface,
        clipBehavior: Clip.antiAlias,
        elevation: elevation ?? 2.0,
        shadowColor: color ?? Theme.of(context).colorScheme.background,
        child: child,
      ),
    );
  }
}

class AppOutlineCard extends StatelessWidget {
  const AppOutlineCard({
    required this.child,
    this.shape,
  });

  final Widget child;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                width: 1,
                color: Theme.of(context).colorScheme.surface,
              )),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shadowColor: Theme.of(context).colorScheme.background,
      child: child,
    );
  }
}

class AppFilledCard extends StatelessWidget {
  const AppFilledCard({
    required this.child,
    this.shape,
  });

  final Widget child;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shadowColor: Theme.of(context).colorScheme.background,
      child: child,
    );
  }
}

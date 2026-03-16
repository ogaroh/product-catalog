import 'package:flutter/material.dart';

/// Full-screen empty / no-results state.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.message,
    this.subtitle,
    this.illustration,
  });

  final String message;
  final String? subtitle;
  final Widget? illustration;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            illustration ??
                Icon(
                  Icons.inbox_outlined,
                  size: 72,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../l10n/l10n.dart';

/// Full-screen error state with a retry button.
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.message,
    required this.onRetry,
    this.retryLabel,
    this.icon,
  });

  final String message;
  final VoidCallback onRetry;
  final String? retryLabel;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ??
                Icon(
                  Icons.error_outline_rounded,
                  size: 64,
                  color: Theme.of(context).colorScheme.error,
                ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(retryLabel ?? context.l10n.retryButton),
            ),
          ],
        ),
      ),
    );
  }
}

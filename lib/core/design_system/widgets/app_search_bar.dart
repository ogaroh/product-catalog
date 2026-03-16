import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../l10n/l10n.dart';
import '../../../core/utils/debouncer.dart';

/// A search input with built-in debounce.
///
/// [onChanged] is called after [debounceDuration] of inactivity.
class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    required this.onChanged,
    this.onClear,
    this.hintText,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.controller,
  });

  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  final String? hintText;
  final Duration debounceDuration;

  /// Provide an external [TextEditingController] to control the field.
  final TextEditingController? controller;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final TextEditingController _controller;
  late final Debouncer _debouncer;
  bool _isExternal = false;

  @override
  void initState() {
    super.initState();
    _isExternal = widget.controller != null;
    _controller = widget.controller ?? TextEditingController();
    _debouncer = Debouncer(duration: widget.debounceDuration);
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _debouncer(() => widget.onChanged(_controller.text));
    setState(() {});
  }

  void _clear() {
    _controller.clear();
    widget.onClear?.call();
    widget.onChanged('');
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.removeListener(_onTextChanged);
    if (!_isExternal) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hintText ?? context.l10n.searchHint,
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear_rounded),
                onPressed: _clear,
                tooltip: context.l10n.backButton,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
    );
  }
}

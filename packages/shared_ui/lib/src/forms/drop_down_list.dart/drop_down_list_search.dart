import 'package:flutter/material.dart';
import 'package:shared_ui/src/k_text_field.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    required this.onTextChanged,
    this.searchHintText,
    this.searchFillColor,
    this.searchCursorColor,
    super.key,
  });

  final Function(String) onTextChanged;
  final String? searchHintText;
  final Color? searchFillColor;
  final Color? searchCursorColor;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KTextField(
      controller: _editingController,
      hintText: widget.searchHintText,
      fillColor: widget.searchFillColor,
      textInputAction: TextInputAction.search,
      onChanged: (value) => widget.onTextChanged(value ?? ''),
      prefixIcon: const Icon(Icons.search),
      suffixIcon: GestureDetector(
        onTap: onClearTap,
        child: const Icon(Icons.cancel, color: Colors.grey),
      ),
    );
  }

  void onClearTap() {
    widget.onTextChanged('');
    _editingController.clear();
  }
}

class SelectedListItem<T> {
  SelectedListItem({required this.data, this.isSelected = false});
  bool isSelected;
  final T data;
}

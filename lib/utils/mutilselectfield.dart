import 'package:flutter/material.dart';

class MultiSelectFormField extends FormField<List<String>> {
  MultiSelectFormField({
    Key? key,
    required List<String> options,
    FormFieldSetter<List<String>>? onSaved,
    FormFieldValidator<List<String>>? validator,
    List<String>? initialValue,
    String hintText = '',
  }) : super(
    key: key,
    initialValue: initialValue ?? [],
    onSaved: onSaved,
    validator: validator,
    builder: (FormFieldState<List<String>> state) {
      return InputDecorator(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(12, 16, 0, 8),
          border: OutlineInputBorder(),
          hintText: hintText,
        ),
        child: MultiSelectDropdown(
          options: options,
          selectedOptions: state.value!,
          onSelectedOptionsChanged: (selectedOptions) {
            state.didChange(selectedOptions);
          },
        ),
      );
    },
  );
}

class MultiSelectDropdown extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final ValueChanged<List<String>> onSelectedOptionsChanged;

  MultiSelectDropdown({
    required this.options,
    required this.selectedOptions,
    required this.onSelectedOptionsChanged,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> _selectedOptions = [];

  @override
  void initState() {
    super.initState();
    _selectedOptions.addAll(widget.selectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isDense: true,
      items: widget.options.map((option) {
        return DropdownMenuItem(
          value: option,
          child: CheckboxListTile(
            title: Text(option),
            value: _selectedOptions.contains(option),
            onChanged: (selected) {
              setState(() {
                if (selected != null && selected) {
                  _selectedOptions.add(option);
                } else {
                  _selectedOptions.remove(option);
                }
              });
              widget.onSelectedOptionsChanged(_selectedOptions);
            },
          ),
        );
      }).toList(),
      onChanged: (selected) {},
      onSaved: (selected) {},
    );
  }
}

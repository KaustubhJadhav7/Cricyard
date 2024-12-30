import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String? hintText;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final void Function(T?)? onChanged;
  final void Function(T?)? onSaved;
  final String? Function(T?)? validator;

  CustomDropdownField(
      {this.hintText,
      required this.items,
      this.value,
      this.onChanged,
      this.onSaved,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            hintStyle: TextStyle(color: Colors.black.withOpacity(.4)),
            contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 6),
            errorText: state.errorText,
          ),
          child: DropdownButtonFormField<T>(
              value: value,
              items: items,
              onChanged: (T? newValue) {
                state.didChange(newValue);
                if (onChanged != null) {
                  onChanged!(newValue);
                }
              },
              onSaved: onSaved,
              hint: Text(hintText ?? ''),
              style: TextStyle(color: Colors.black.withOpacity(.8)),
              //isExpanded: true,
              validator: validator),
        );
      },
    );
  }
}

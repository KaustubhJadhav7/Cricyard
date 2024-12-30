import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final Function(String)? onSaved;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextInputType? textInputType;
  final IconButton? suffixIcon;
  final Function(String)? onChanged;
  final bool? isObscureText;
  FocusNode? focusNode;
  String? initialValue ;
  TextEditingController? controller;
  

  CustomTextField(
      {required this.hintText,
     
      this.controller,
      this.onChanged,
      this.focusNode,
      this.isObscureText,
      this.initialValue,
      this.suffixIcon,
      this.onSaved,
      this.validator,
      this.onTap,
      this.textInputType});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      initialValue: widget.initialValue ,
      obscureText: widget.isObscureText ?? false,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      controller: _controller,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        hintStyle: TextStyle(color: Colors.black.withOpacity(.4)),
        hintText: widget.hintText,
        border: UnderlineInputBorder(),
      ),
      validator: widget.validator,
      onSaved: (String? value) {
        if (widget.onSaved != null) {
          widget.onSaved!(_controller.text);
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

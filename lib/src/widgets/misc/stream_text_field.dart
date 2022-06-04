import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StreamTextField extends StatelessWidget {
  final Stream stream;
  final void Function(String)? onChanged;
  final String hintText, labelText;
  final String? text;
  final TextInputType textInputType;
  final bool obscureText;
  final FocusNode? focusNode;
  final int minLines, maxLines;
  final EdgeInsets? margin, padding;
  final BoxDecoration? decoration;
  TextStyle? style;

  StreamTextField({
    required this.hintText,
    required this.labelText,
    required this.stream,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.margin,
    this.padding,
    this.decoration,
    this.style,
    this.focusNode,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, snapshot) {
        return Container(
          margin: margin,
          padding: padding,
          decoration: decoration,
          child: TextField(
            controller: text == null ? null : TextEditingController(text: text),
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: hintText,
              labelText: labelText,
              errorText: snapshot.hasError ? snapshot.error.toString() : "",
              errorStyle:
                  style == null ? null : const TextStyle(color: Colors.amber),
              labelStyle:
                  style == null ? null : const TextStyle(color: Colors.white),
              hintStyle:
                  style == null ? null : const TextStyle(color: Colors.white60),
            ),
            style: style,
            keyboardType: textInputType,
            obscureText: obscureText,
            onChanged: onChanged,
            minLines: minLines,
            maxLines: maxLines,
            focusNode: focusNode,
          ),
        );
      },
    );
  }
}

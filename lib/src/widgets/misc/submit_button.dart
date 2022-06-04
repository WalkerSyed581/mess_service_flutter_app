import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final IconData? iconData;
  final String text;
  final TextStyle? style;
  final void Function()? onPressed;

  SubmitButton(
      {required this.text, required this.onPressed, this.iconData, this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData),
        const SizedBox(width: 15),
        Expanded(
          child: SizedBox(
            height: 45,
            child: TextButton(
              onPressed: onPressed,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor)),
              child: Text(
                text,
                style: style ??
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

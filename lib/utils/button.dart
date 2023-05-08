import 'package:flutter/material.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/text_styles.dart';

class Button extends StatefulWidget {
  String text;
  bool filledButton;
  bool disable;
  bool removeStroke;
  VoidCallback? ontap;
  Color? textColor;
  Button(
      {required this.text,
      this.filledButton = true,
      this.ontap,
      this.disable = false,
      this.removeStroke = false,
      this.textColor,
      super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: widget.filledButton
                ? const Border()
                : widget.removeStroke
                    ? const Border()
                    : Border.all(color: Colors.grey.shade500),
            borderRadius: BorderRadius.circular(8),
            color: (widget.filledButton && !widget.disable)
                ? primaryColor
                : widget.disable
                    ? lightGreeyColor
                    : Colors.transparent),
        child: Center(
          child: Text(
            widget.text,
            style: TextStylingWidget.buttonText.copyWith(
                color: (widget.filledButton && !widget.disable)
                    ? Colors.white
                    : widget.disable
                        ? greyColor
                        : widget.textColor ?? Colors.black),
          ),
        ),
      ),
    );
  }
}

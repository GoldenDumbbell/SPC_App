import 'package:flutter/material.dart';
import 'package:webspc/widget/sizer.dart';

import 'colors.dart';

class EntryField extends StatefulWidget {
  final String? hint;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final Color? color;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? readOnly;
  final TextAlign? textAlign;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final String? label;
  final int? maxLines;
  final Function? onTap;
  final IconData? suffix;
  bool obscureText;

  EntryField({
    super.key,
    this.hint,
    this.prefixIcon,
    this.color,
    this.controller,
    this.initialValue,
    this.readOnly,
    this.textAlign,
    this.suffixIcon,
    this.textInputType,
    this.label,
    this.maxLines,
    this.onTap,
    this.suffix,
    this.prefixIconColor,
    this.obscureText = true,
  });

  @override
  State<EntryField> createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.label != null
            ? Text(
                '\n${widget.label!}\n',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.black, fontSize: 15),
              )
            : const SizedBox.shrink(),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                style: Theme.of(context).textTheme.bodyLarge,
                initialValue: widget.initialValue,
                readOnly: widget.readOnly ?? false,
                maxLines: widget.maxLines ?? 1,
                textAlign: widget.textAlign ?? TextAlign.left,
                keyboardType: widget.textInputType,
                obscureText:
                    widget.suffixIcon != null ? widget.obscureText : false,
                decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(
                          widget.prefixIcon,
                          color: widget.prefixIconColor ?? kMainColor,
                          size: 20.sp,
                        )
                      : null,
                  suffixIcon: widget.suffixIcon != null
                      ? IconButton(
                          onPressed: () {
                            if (widget.obscureText == true) {
                              setState(() {
                                widget.obscureText = false;
                              });
                            } else if (widget.obscureText == false) {
                              setState(() {
                                widget.obscureText = true;
                              });
                            }
                          },
                          icon: Icon(
                            widget.obscureText == true
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 24.sp,
                          ),
                        )
                      : null,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: black2, fontSize: 15),
                  hintText: widget.hint,
                  filled: true,
                  fillColor: widget.color ?? secondaryBackgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
                onTap: widget.onTap as void Function()?,
              ),
            ),
            if (widget.suffix != null)
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsetsDirectional.only(start: 8),
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: kButtonBorderColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    widget.suffix,
                    color: kButtonBorderColor,
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}

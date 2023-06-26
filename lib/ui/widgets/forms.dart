import 'package:film_explorer/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final bool isObsecure;
  final bool isShowTitle;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmited;
  final Function(String)? onChanged;

  const CustomTextFormField(
      {Key? key,
      required this.title,
      required this.hintText,
      this.isObsecure = false,
      required this.controller,
      this.isShowTitle = true,
      this.keyboardType,
      this.onFieldSubmited,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle) ...[
          Text(
            title,
            style: whiteTextStyle.copyWith(
              fontWeight: medium,
            ),
          )
        ],
        const SizedBox(
          height: 14,
        ),
        TextFormField(
          obscureText: isObsecure,
          style: whiteTextStyle,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundInput,
            hintText: hintText,
            hintStyle: grayTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: backgroundInput,
              ),
            ),
            contentPadding: const EdgeInsets.all(12),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: grayColor,
              ),
            ),
          ),
          controller: controller,
          keyboardType: keyboardType,
          onFieldSubmitted: onFieldSubmited,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

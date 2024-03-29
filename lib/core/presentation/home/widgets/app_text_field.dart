import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:rock_weather/design/colors/app_colors.dart';

class AppTextField extends StatefulWidget {
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final FocusNode focusNode;
  final String? hintText;
  final TextInputType keyboardType;
  final EdgeInsetsGeometry? padding;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorMessage;
  final bool showErrorMessage;

  const AppTextField({
    required this.focusNode,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.hintText,
    this.textInputAction,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.errorMessage,
    this.showErrorMessage = false,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(textFormListener);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(textFormListener);
    super.dispose();
  }

  void textFormListener() {
    if (widget.focusNode.hasFocus) {
      setState(() {
        hasFocus = true;
      });
    } else {
      setState(() {
        hasFocus = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 45,
            child: TextField(
              focusNode: widget.focusNode,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              inputFormatters: widget.inputFormatters,
              textCapitalization: TextCapitalization.none,
              style: TextStyle(
                fontSize: 18,
                color: (hasFocus || widget.controller!.text.isNotEmpty) ? AppColors.darkBlue : AppColors.grey.withOpacity(0.9),
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 1),
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: hasFocus ? AppColors.darkBlue : AppColors.grey.withOpacity(0.9),
                ),
                filled: true,
                isDense: true,
                fillColor: AppColors.white,
                hintText: widget.hintText,
                prefixIcon: Icon(
                  widget.prefixIcon,
                  size: 24,
                  color: (hasFocus || widget.controller!.text.isNotEmpty) ? AppColors.darkBlue : AppColors.grey.withOpacity(0.9),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Gap(4),
          Visibility(
            visible: widget.showErrorMessage,
            child: Text(
              widget.errorMessage ?? '',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}

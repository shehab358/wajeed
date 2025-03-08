import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wajeed/core/resources/color_manager.dart';
import 'package:wajeed/core/resources/font_manager.dart';
import 'package:wajeed/core/resources/styles_manager.dart';
import 'package:wajeed/core/resources/values_manager.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.label,
      this.hint,
      this.isObscured = false,
      this.iconData,
      this.textInputType = TextInputType.text,
      this.backgroundColor,
      this.hintTextStyle,
      this.labelTextStyle,
      this.cursorColor,
      this.readOnly = false,
      this.validation,
      this.onTap,
      this.maxLines,
      this.maxLength,
      this.prefixIcon,
      this.borderBackgroundColor,
      this.suffixIcon,
      this.enabled,
      this.onChanged});

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool isObscured;
  final String? label;
  final String? hint;
  final TextInputType textInputType;
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? borderBackgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color? cursorColor;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enabled;
  final String? Function(String?)? validation;
  final void Function()? onTap;
  final ValueChanged<String>? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool hidden = widget.isObscured;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.enabled ?? true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(top: Insets.s2),
            child: Text(
              widget.label!,
              style: widget.labelTextStyle ??
                  getMediumStyle(
                    color: isEnabled ? ColorManager.white : ColorManager.grey,
                  ).copyWith(fontSize: FontSize.s18),
            ),
          ),
        Container(
          margin: EdgeInsets.only(top: Insets.s5.h),
          decoration: BoxDecoration(
            color: isEnabled
                ? widget.backgroundColor ?? ColorManager.white
                : ColorManager.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(Sizes.s8),
            border: Border.all(
              color: isEnabled
                  ? widget.borderBackgroundColor ?? ColorManager.grey
                  : ColorManager.grey,
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: TextFormField(
            maxLength: widget.maxLength,
            enabled: isEnabled,
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            focusNode: widget.focusNode,
            readOnly: widget.readOnly,
            style: getMediumStyle(
                    color: isEnabled ? ColorManager.black : ColorManager.grey)
                .copyWith(fontSize: FontSize.s18),
            obscureText: hidden,
            keyboardType: widget.textInputType,
            obscuringCharacter: '*',
            cursorColor: isEnabled
                ? widget.cursorColor ?? ColorManager.black
                : ColorManager.grey,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            onEditingComplete: () {
              widget.focusNode?.unfocus();
              if (widget.nextFocus != null) {
                FocusScope.of(context).requestFocus(widget.nextFocus);
              }
            },
            textInputAction: widget.nextFocus == null
                ? TextInputAction.done
                : TextInputAction.next,
            validator: (value) {
              if (widget.validation == null) {
                setState(() => errorText = null);
              } else {
                setState(() => errorText = widget.validation!(value));
              }
              return errorText;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(Insets.s12.sp),
              hintText: widget.hint,
              hintStyle: widget.hintTextStyle ??
                  getRegularStyle(
                          color: isEnabled
                              ? ColorManager.grey
                              : ColorManager.lightGrey)
                      .copyWith(fontSize: 18.sp),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isObscured
                  ? IconButton(
                      onPressed: isEnabled
                          ? () => setState(() => hidden = !hidden)
                          : null,
                      iconSize: Sizes.s24.sp,
                      splashRadius: Sizes.s1,
                      isSelected: !hidden,
                      color: isEnabled ? widget.cursorColor : ColorManager.grey,
                      selectedIcon: const Icon(Icons.visibility),
                      icon: Icon(Icons.visibility_off),
                    )
                  : widget.suffixIcon,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorStyle: TextStyle(
                fontSize: FontSize.s0,
                color: ColorManager.transparent,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: Insets.s8.h,
              start: Insets.s8.w,
            ),
            child: Text(
              errorText!,
              style: getMediumStyle(color: ColorManager.error)
                  .copyWith(fontSize: 18.sp),
            ),
          ),
      ],
    );
  }
}

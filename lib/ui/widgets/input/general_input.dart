import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../styles/color.dart';
import '../../styles/dimens.dart';
import '../../styles/texts.dart';

class GeneralInput extends StatefulWidget {
  final String? hintText;
  final bool isPassword;
  final TextInputType inputType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Color? fillColor;
  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final EdgeInsets? margin;
  final bool autoUnFocus;
  final BuildContext appContext;
  final void Function()? onTap;

  const GeneralInput({
    Key? key,
    required this.appContext,
    this.hintText,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.suffixIcon,
    this.onChanged,
    this.fillColor,
    this.controller,
    this.focusNode,
    this.label,
    this.autoUnFocus = true,
    this.margin,
    this.onTap,
  }) : super(key: key);

  @override
  State<GeneralInput> createState() => _GeneralInputState();
}

class _GeneralInputState extends State<GeneralInput> {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  bool activeErrorState = false;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });

    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocus() {
    if (widget.autoUnFocus) {
      if (_focusNode.hasFocus &&
          MediaQuery.of(widget.appContext).viewInsets.bottom == 0) {
        _focusNode.unfocus();
        Future.delayed(
            const Duration(microseconds: 1), () => _focusNode.requestFocus());
      } else {
        _focusNode.requestFocus();
      }
    } else {
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.only(bottom: 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null && widget.label!.isNotEmpty)
            Text(
              widget.label!,
              style: headerPoppins.copyWith(
                  color: AppColors.textSecondary,),
              // style: kInputLabelStyle,
            ),
          Container(
            child: Stack(
              children: [
                TextFormField(
                  focusNode: _focusNode,
                  // enableInteractiveSelection: false,
                  showCursor: false,
                  // using same as background color so tha it can blend into the view
                  cursorWidth: 0.01,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    errorStyle: TextStyle(inherit: true, height: 2),
                    border: InputBorder.none,
                    fillColor: Colors.transparent,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  // readOnly: true,
                  style: const TextStyle(
                    color: Colors.transparent,
                    height: .01,
                    fontSize: kIsWeb
                        ? 1
                        : 0.01, // it is a hidden textfield which should remain transparent and extremely small
                  ),
                  validator: (val) {
                    // if (widget.validator != null &&
                    //     (widget.validator!(val) != null &&
                    //         widget.validator!(val)!.isNotEmpty)) {
                    //   setState(() {
                    //     activeErrorState = true;
                    //   });
                    //   return "\u274C ${widget.validator!(val)}";
                    // }
                    // setState(() {
                    //   activeErrorState = false;
                    // });
                    val!.isEmpty?"Value cannot be empty":null;
                  },
                  controller: _controller,
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.onTap != null) widget.onTap!();
                    _onFocus();
                  },
                  child: AnimatedContainer(
                    constraints: const BoxConstraints(minHeight: 65),
                    duration: const Duration(milliseconds: 200),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                    margin: widget.label != null
                        ? const EdgeInsets.only(top: 8.0, bottom: 4.0)
                        : widget.margin,
                    decoration: BoxDecoration(
                      color: _focusNode.hasFocus || _controller.text.isNotEmpty
                          ? AppColors.fieldColor
                          : widget.fillColor,
                      borderRadius:
                          BorderRadius.circular(Dimens.inputFieldRadius),
                      border: border(),
                    ),
                    child: TextFormField(
                      focusNode: _focusNode,
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      // cursorHeight: 24.0,
                      keyboardType: widget.inputType,
                      obscureText: widget.isPassword,
                      textInputAction: widget.textInputAction,
                      onChanged: widget.onChanged,
                      controller: widget.controller,
                      onEditingComplete: () {
                        // if (widget.textInputAction == TextInputAction.next) {
                        //   context.nextEditableTextFocus();
                        // }
                      },
                      style: kInputFieldTextStyle,
                      decoration: buildInputDecoration(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Border border() {
    if (activeErrorState) {
      return Border.all(
        color: AppColors.error,
        width: 0.7,
      );
    }
    return _focusNode.hasFocus || _controller.text.isNotEmpty
        ? Border.all(
            color: AppColors.primary,
            width: 0.7,
          )
        : Border.all(
            width: 0.5,
            color: AppColors.inputBorder,
          );
  }

  InputDecoration buildInputDecoration(BuildContext context) {
    return InputDecoration(
      hintText: widget.hintText,
      suffixIcon: widget.suffixIcon,
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      // errorBorder: buildErrorBorder(),
    );
  }

  OutlineInputBorder buildErrorBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: 0.7),
        borderRadius: BorderRadius.circular(10));
  }
}

import 'dart:js_interop';

import 'package:flutter/material.dart';

import '../../core/models/zone_model.dart';
import '../styles/color.dart';
import '../styles/dimens.dart';
import '../styles/texts.dart';

class CustomInstitutionDropdown extends StatefulWidget {
  final Function(String?) onChanged;

  CustomInstitutionDropdown(
      {super.key,
      this.label,
      this.focusNode,
      this.margin,
      this.autoUnFocus = false,
      required this.appContext,
      this.hintText,
      this.fillColor, this.selectedInstitution, required this.value, required this.onChanged});
  final String? label;
  final String? hintText;
  final FocusNode? focusNode;
  final EdgeInsets? margin;
  final bool autoUnFocus;
  final BuildContext appContext;
  final Color? fillColor;
  String? selectedInstitution;
  final List<Institution> value;

  @override
  State<CustomInstitutionDropdown> createState() =>
      _CustomInstitutionDropdownState();
}

class _CustomInstitutionDropdownState extends State<CustomInstitutionDropdown> {
  late FocusNode _focusNode;
  bool activeErrorState = false;
  String? selectedInstitution;

  @override
  void initState() {
    selectedInstitution = widget.value[0].fellowshipName;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.label != null && widget.label!.isNotEmpty)
            Text(
              widget.label!,
              style: headerPoppins.copyWith(
                color: AppColors.textSecondary,
              ),
              // style: kInputLabelStyle,
            ),
          AnimatedContainer(
            constraints: const BoxConstraints(minHeight: 65),
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 8.0, right: 4.0),
            margin: widget.label != null
                ? const EdgeInsets.only(top: 8.0, bottom: 4.0)
                : widget.margin,
            decoration: BoxDecoration(
              color: _focusNode.hasFocus ||
                      widget.value.isNotEmpty
                  ? AppColors.fieldColor
                  : widget.fillColor,
              borderRadius: BorderRadius.circular(Dimens.inputFieldRadius),
              border: border(selectedInstitution!),
            ),
            child: DropdownButton<String>(
                    value: widget.selectedInstitution,
                    focusNode: _focusNode,
                    onTap: () {
                      // if (widget.onTap != null) widget.onTap!();
                      _onFocus();
                    },
                    style: kInputFieldTextStyle,
                    // decoration: buildInputDecoration(context),
                    underline: const SizedBox.shrink(),
                    isExpanded: true,
                    hint: Text(widget.hintText.toString()),
                    onChanged: widget.onChanged,
                    items: widget.value
                        .map<DropdownMenuItem<String>>((Institution value) {
                      return DropdownMenuItem<String>(
                        value: value.fellowshipName,
                        child: Text(value.fellowshipName ?? ''),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  Border border(String value) {
    if (activeErrorState) {
      return Border.all(
        color: AppColors.error,
        width: 0.7,
      );
    }
    return _focusNode.hasFocus || value.isDefinedAndNotNull
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
      prefixIcon: const Icon(Icons.arrow_drop_down),
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

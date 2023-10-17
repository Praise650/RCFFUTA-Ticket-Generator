import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rcf_attendance_generator/ui/pages/generate_qr_page/view_model/generate_qr_view_model.dart';

import '../../core/models/zone_model.dart';
import '../styles/color.dart';
import '../styles/dimens.dart';
import '../styles/texts.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown(
      {super.key,
      this.label,
      this.focusNode,
      this.margin,
      this.autoUnFocus = false,
      required this.appContext,
      this.hintText,
      this.fillColor});

  final String? label;
  final String? hintText;
  final FocusNode? focusNode;
  final EdgeInsets? margin;
  final bool autoUnFocus;
  final BuildContext appContext;
  final Color? fillColor;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  
  late FocusNode _focusNode;
  bool activeErrorState = false;

  @override
  void initState() {
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
    
    return Consumer<GenerateQrViewModel>(
      builder: (context,model,_) {
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
                  color: _focusNode.hasFocus || model.selectedRcfZone.isDefinedAndNotNull
                      ? AppColors.fieldColor
                      : widget.fillColor,
                  borderRadius: BorderRadius.circular(Dimens.inputFieldRadius),
                  border: border(model.rcfZonesList),
                ),
                child: DropdownButton<RcfZones>(
                  value: model.selectedRcfZone,
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
                  onChanged: (RcfZones? newValue) {
                      model.selectedRcfZone = newValue;
                      print("Selected Zone ${model.selectedRcfZone!.zone!}");
                      model.updateInstitution();
                  },
                  items: model.rcfZonesList
                      .map<DropdownMenuItem<RcfZones>>((RcfZones value) {
                    return DropdownMenuItem<RcfZones>(
                      value: value,
                      child: Text(value.zone ?? ''),
                    );
                  }).toList(),
                ),
              ),
              // if (model.selectedRcfZone != null)
              //   Column(
              //     children: model.selectedRcfZone!.institutions!.map((institution) {
              //       return ListTile(
              //         title: Text(institution.fellowshipName ?? ''),
              //         subtitle: Text(institution.schoolName ?? ''),
              //       );
              //     }).toList(),
              //   ),
            ],
          ),
        );
      }
    );
  }

  Border border(List<RcfZones> selectedRcfZone) {
    if (activeErrorState) {
      return Border.all(
        color: AppColors.error,
        width: 0.7,
      );
    }
    return _focusNode.hasFocus || selectedRcfZone.isDefinedAndNotNull
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

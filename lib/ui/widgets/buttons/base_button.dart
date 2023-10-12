import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../styles/color.dart';
import '../layout/responsive_widget.dart';

class BaseButton extends StatefulWidget {
  final Function() onPressed;
  final String? btnText;
  final IconData? icon;
  final double? materialIconSize;
  final String? svgIcon;
  final Widget? child;
  final Color? iconColor;
  final double? width;
  final bool isBusy;

  const BaseButton(
      {Key? key,
      required this.onPressed,
      this.btnText,
      this.width,
      this.icon,
      this.materialIconSize,
      this.svgIcon,
      this.child,
      this.isBusy = false,
      this.iconColor})
      : super(key: key);

  @override
  State<BaseButton> createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {
  final TextStyle textStyle = const TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      // elevation: 0,
      child: Container(
        height: 50,
        width: widget.width ??
            (ResponsiveWidget.isMobile(context)
                ? MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width / 1.25),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryBtnBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.isBusy == true
            ? const CircularProgressIndicator()
            : getChild(),
      ),
    );
  }

  Widget getChild() {
    if (widget.child != null) {
      return widget.child!;
    } else if (widget.svgIcon != null) {
      return Row(
        children: [
          SvgPicture.asset(
            widget.svgIcon!,
            height: 24,
            width: 24,
            color: widget.iconColor ?? Colors.transparent,
          ),
          Text(
            widget.btnText!,
            style: textStyle,
          )
        ],
      );
    } else if (widget.icon != null) {
      return Icon(
        widget.icon,
        size: 40,
        color: widget.iconColor ?? Colors.black,
      );
    } else {
      return Text(widget.btnText ?? '', softWrap: true, style: textStyle);
    }
  }
}

import 'package:flutter/material.dart';

import '../../styles/color.dart';

class NavButtonWithArrow extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final AlignmentGeometry alignment;

  const NavButtonWithArrow({
    Key? key,
    required this.onPressed,
    this.icon = Icons.east_outlined,
    this.alignment = Alignment.centerRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Material(
        elevation: 0,
        color: AppColors.primaryBtnBg,
        child: Container(
          width: 105,
          height: 50,
          child: InkWell(
            child: Icon(
              // Icons.arrow_right_alt,
              icon,
              color: AppColors.white,
              size: 40,
            ),
            onTap: onPressed,
          ),
        ),
      ),
    );
  }
}

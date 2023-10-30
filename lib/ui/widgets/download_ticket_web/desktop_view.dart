import 'package:flutter/material.dart';


import '../../../app/images.dart';
import '../../layouts/scrollable_base_scaffold_body.dart';
import '../../pages/download_qr/controller/download_qr_controller.dart';
import '../../styles/color.dart';
import '../../styles/texts.dart';
import 'form_left_widget.dart';
import 'infos_right_widget.dart';

class DownloadQrDesktopView extends StatelessWidget {
  const DownloadQrDesktopView({
    Key? key,
    required this.linearGradient,
    required this.constraints,
    required this.controller,
  }) : super(key: key);
  final DownloadQrController controller;
  final Shader linearGradient;
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: constraints.maxHeight,
      child: ScrollableBaseScaffoldBody(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImages.crmLogo,
                    width: 70,
                    height: 100,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "LTP 2023 Ticket".toUpperCase(),
                    style: kHeadline1TextStyle.copyWith(
                      color: AppColors.white,
                      height: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FormLeftWidget(
                      linearGradient: AppColors.linearGradient,
                      constraints: constraints,
                      controller: controller,
                    ),
                  ),
                  const SizedBox(width: 32),
                  RepaintBoundary(
                    key: controller.qrKey,
                    child: InfosRightWidget(
                      constraints: constraints,
                      controller: controller,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

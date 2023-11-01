import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcf_attendance_generator/ui/widgets/loader.dart';

import '../../pages/download_qr/controller/download_qr_controller.dart';
import '../../layouts/scrollable_base_scaffold_body.dart';
import '../../../core/states/ticket_state.dart';
import '../../../app/images.dart';
import '../../styles/color.dart';
import '../../styles/texts.dart';
import 'form_left_mobile.dart';
import 'infos_right_mobile.dart';

class DownloadQrMobileView extends StatelessWidget {
  const DownloadQrMobileView({
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
          padding: constraints.maxWidth > 1000
              ? const EdgeInsets.symmetric(horizontal: 40, vertical: 45)
              : const EdgeInsets.symmetric(horizontal: 11),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              showInfo(),
              const SizedBox(height:10),
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
              const SizedBox(height: 20),
              FormLeftMobile(
                linearGradient: linearGradient,
                constraints: constraints,
                controller: controller,
              ),
              RepaintBoundary(
                key: controller.qrKey,
                child: SizedBox(
                  height: 350,
                  child: InfosRightMobile(
                    constraints: constraints,
                    controller: controller,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: constraints.maxWidth,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.state.runtimeType == SuccessTicketState) {
                      controller.captureAndSavePng();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purpleNormal,
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 40,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: controller.isLoading == true? buildLoaderWidget():Text(
                    'DOWNLOAD',
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

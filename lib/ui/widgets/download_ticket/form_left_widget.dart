import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rcf_attendance_generator/app/images.dart';

import '../../pages/download_qr/controller/download_qr_controller.dart';
import '../../../core/states/ticket_state.dart';
import '../../styles/color.dart';


class FormLeft extends StatelessWidget {
  const FormLeft({
    super.key,
    required this.linearGradient,
    required this.constraints,
    required this.controller,
  });
  final DownloadQrController controller;
  final Shader linearGradient;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.spaceGrotesk(
              fontSize: 40,
              fontWeight: FontWeight.w400,
              foreground: Paint()..shader = linearGradient,
            ),
            children: const [
              TextSpan(
                text: 'DOWNLOAD YOUR TICKET\n',
              ),
              TextSpan(
                text: 'AND SHARE\n',
              ),
              TextSpan(
                text: 'WITH THE WORLD',
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Obx(() {
          return Visibility(
            visible: controller.state.value.runtimeType != SuccessTicketState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ENTER YOUR GITHUB USER',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 20,
                    color: AppColors.grayLight,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: constraints.maxWidth < 600
                      ? constraints.maxWidth
                      : constraints.maxWidth * 0.5,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  constraints: const BoxConstraints(maxWidth: 380),
                  decoration: const BoxDecoration(color: AppColors.grayLight),
                  child: TextField(
                    controller: controller.userController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Image.asset(
                        AppImages.github,
                      ),
                      hintText: 'Username',
                      hintStyle: GoogleFonts.spaceGrotesk(
                        color: AppColors.greyDark,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Visibility(
                  visible:
                      controller.state.value.runtimeType == FailureTicketState,
                  child: Text(
                    'Invalid user. Check and try again.',
                    style: GoogleFonts.roboto(
                      color: AppColors.danger,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        Obx(() {
          return Visibility(
            visible: controller.state.value.runtimeType == SuccessTicketState,
            child: Row(
              children: [
                const Icon(
                  Icons.check,
                  color: AppColors.success,
                ),
                const SizedBox(width: 10),
                Text(
                  'TICKET GENERATED SUCCESSFULLY',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 20,
                    color: AppColors.grayLight,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
        Container(
          width: constraints.maxWidth < 600
              ? constraints.maxWidth
              : constraints.maxWidth * 0.5,
          constraints: const BoxConstraints(maxWidth: 380),
          child: Obx(() {
            return ElevatedButton(
              onPressed: () {
                if (controller.state.value.runtimeType != LoadingTicketState) {
                  controller.getProfile();
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
              child: controller.state.value.runtimeType == LoadingTicketState
                  ? const CircularProgressIndicator()
                  : Text(
                      // controller.state.value.runtimeType == SuccessTicketState
                      //     ?
                      'DOWNLOAD',
                          // : "GENERATE MY TICKET",
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
            );
          }),
        )
      ],
    );
  }
}

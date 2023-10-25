import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        Visibility(
          visible: controller.state.runtimeType == LoadingTicketState,
          child: const CircularProgressIndicator(),
        ),
        Visibility(
          visible: controller.state.runtimeType == FailureTicketState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invalid user, Check and try again.',
                style: GoogleFonts.roboto(
                  color: AppColors.danger,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: controller.state.runtimeType == SuccessTicketState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dear ${controller.user?.fullname!}\n".toUpperCase(),
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 20,
                  color: AppColors.grayLight,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
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
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: constraints.maxWidth * 0.5,
          constraints: const BoxConstraints(maxWidth: 380),
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
            child: Text(
                    'DOWNLOAD',
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
          ),
        )
      ],
    );
  }
}


class FormLeftMobile extends StatelessWidget {
  const FormLeftMobile({
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
                text: 'AND SHARE WITH THE WORLD\n',
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Visibility(
          visible: controller.state.runtimeType == LoadingTicketState,
          child: const CircularProgressIndicator(),
        ),
        Visibility(
          visible: controller.state.runtimeType == FailureTicketState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invalid user, Check and try again.',
                style: GoogleFonts.roboto(
                  color: AppColors.danger,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: controller.state.runtimeType == SuccessTicketState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dear ${controller.user?.fullname!}\n".toUpperCase(),
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 20,
                  color: AppColors.grayLight,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
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
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../app/images.dart';
import '../../pages/download_qr/controller/download_qr_controller.dart';
import '../../styles/color.dart';

class InfosRight extends StatelessWidget {
  const InfosRight({
    super.key,
    required this.constraints,
    required this.controller,
  });
  final DownloadQrController controller;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth * 0.6,
      constraints: const BoxConstraints(maxWidth: 1000),
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 40),
      decoration: const BoxDecoration(
        color: AppColors.purpleNormal,
      ),
      child: LayoutBuilder(
        builder: (context, constraints2) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: constraints2.maxWidth * 0.6,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.asset(
                    AppImages.cover,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                width: constraints2.maxWidth * 0.3,
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      'ATTENDEE',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.purpleNormal,
                      ),
                    ),
                    Text(
                      controller.user?.fullname == null
                          ? 'Your name here'
                          : controller.user!.fullname!,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.greyDark,
                      ),
                    ),
                    Text(
                      controller.user?.id == null
                          ? 'Your ID here'
                          : controller.user!.uuid!,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.greyDark,
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(63),
                        ),
                        child: controller.user?.imageUrl == null
                            ? QrImageView(
                                data: controller.user!.uuid.toString(),
                                version: QrVersions.auto,
                                // size: 190.0,
                                gapless: true,
                                errorStateBuilder: (ctx, err) {
                                  return const Center(
                                    child: Text(
                                      'Something went wrong!!!',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              )
                            : Image.network(
                                controller.user!.imageUrl!,
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        SizedBox(
                          width: constraints2.maxWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'EVENT',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.greyDark,
                                ),
                              ),
                              Text(
                                'RISING ARMY',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.greyDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: constraints2.maxWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'DATE',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.greyDark,
                                ),
                              ),
                              Text(
                                '14 - 16 OCT.2023',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.greyDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: constraints2.maxWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'HOURS',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.greyDark,
                                ),
                              ),
                              Text(
                                'LIVE',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.greyDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Image.asset('assets/images/lines.png')
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

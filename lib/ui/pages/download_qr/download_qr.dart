import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rcf_attendance_generator/app/images.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../../core/data/download_qr_datasource.dart';
import '../../../core/repos/download_qr_repo.dart';
import '../../styles/color.dart';
import '../../widgets/download_ticket/form_left_widget.dart';
import '../../widgets/download_ticket/infos_right_widget.dart';
import 'controller/download_qr_controller.dart';

class DownloadQR extends StatelessWidget {
  // WidgetsToImageController to access widget
  WidgetsToImageController controllers = WidgetsToImageController();
  // to save image bytes of widget
  Uint8List? bytes;

  DownloadQR({super.key});
  final DownloadQrController controller = DownloadQrController(
    repository: DownloadQrRepo(
      data: HomeDatasource(httpClient: http.Client()),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return constraints.maxWidth < 600
                    ? SizedBox(
                        height: constraints.maxHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FormLeft(
                              linearGradient: AppColors.linearGradient,
                              constraints: constraints,
                              controller: controller,
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: constraints.maxHeight * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FormLeft(
                              linearGradient: AppColors.linearGradient,
                              constraints: constraints,
                              controller: controller,
                            ),
                            const SizedBox(width: 32),
                            InfosRight(
                              constraints: constraints,
                              controller: controller,
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:typed_data';
import 'package:flutter/material.dart';


import '../../../app/images.dart';
import '../../../core/states/ticket_state.dart';
import '../../../utils/app_response.dart';
import '../../widgets/download_ticket_mobile/mobile_view.dart';
import 'controller/download_qr_controller.dart';
import 'package:provider/provider.dart';
import '../../widgets/loader.dart';
import '../../styles/color.dart';

class DownloadQRPage extends StatefulWidget {
  const DownloadQRPage({super.key, required this.userId});
  final String userId;

  @override
  State<DownloadQRPage> createState() => _DownloadQRPageState();
}

class _DownloadQRPageState extends State<DownloadQRPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  _init() async {
    try {
      // final userId = ModalRoute.of(context)!.settings.arguments as String;
      print("User Id: ${widget.userId}");
      await context.read<DownloadQrController>().getProfile(widget.userId);
    } catch (e) {
      print(e);
      AppResponse.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadQrController>(
      builder: (context, model, _) {
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background),
                fit: BoxFit.fill,
              ),
            ),
            child: model.state.runtimeType == LoadingTicketState
                ? buildLoaderWidget()
                : LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 600) {
                        return DownloadQrMobileView(
                          linearGradient: AppColors.linearGradient,
                          controller: model,
                          constraints: constraints,
                        );
                      } else if (constraints.maxWidth > 600 &&
                          constraints.maxWidth < 1000) {
                        return DownloadQrMobileView(
                          linearGradient: AppColors.linearGradient,
                          controller: model,
                          constraints: constraints,
                        );
                      } else {
                        return DownloadQrMobileView(
                          linearGradient: AppColors.linearGradient,
                          controller: model,
                          constraints: constraints,
                        );
                        // return DownloadQrDesktopView(
                        //   linearGradient: AppColors.linearGradient,
                        //   controller: model,
                        //   constraints: constraints,
                        // );
                      }
                    },
                  ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    final _qrKey = context.read<DownloadQrController>().qrKey;
    _qrKey.currentState!.dispose();
  }

  Widget buildImage(Uint8List bytes) => Image.memory(bytes);
}

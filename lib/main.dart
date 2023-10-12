import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'ui/pages/generate_qr_page/view_model/generate_qr_view_model.dart';
import 'ui/pages/generate_qr_page/general_qr_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GenerateQrViewModel()),
      ],
      child: const GetMaterialApp(
        // builder: (context,snaps){},
        home: GenerateQRPage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/pages/auth/view_model/login_controller.dart';
import 'ui/pages/display_attendee/view_model/list_member_controller.dart';
import 'ui/pages/download_qr/controller/download_qr_controller.dart';
import 'ui/pages/generate_qr_page/view_model/generate_qr_view_model.dart';
import 'ui/pages/generate_qr_page/generate_qr_page.dart';
import 'app/app.dart';

void main() async {
  await App.initialize();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text(
                    "Something Went Wrong!... Could not initialize connection."),
              ),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => GenerateQrViewModel()),
              ChangeNotifierProvider(create: (_) => DownloadQrController()),
              ChangeNotifierProvider(create: (_) => AuthViewModel()),
              ChangeNotifierProvider(create: (_) => DispController()),
            ],
            child: const MaterialApp(
              // builder: (context,snaps){},
              home: GenerateQRPage(),
              debugShowCheckedModeBanner: false,
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        );
      },
    );
  }
}

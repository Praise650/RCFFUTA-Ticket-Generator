import 'package:flutter/material.dart';

Widget buildLoaderWidget() {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.blue,
    ),
  );
}

Widget showInfo({bool showAlert = true}) => Visibility(
      visible: showAlert,
      replacement: const SizedBox.shrink(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(2),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Enable desktop mode on mobile to download ticket"),
            TextButton(
              onPressed: () {
                showAlert = false;
              },
              child: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );

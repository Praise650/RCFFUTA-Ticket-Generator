import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../core/models/user_model.dart';
import '../../../../core/service/home_service.dart';
import '../../../../core/states/ticket_state.dart';

class DownloadQrController extends GetxController {
  IHomeRepository repository;

  TextEditingController userController = TextEditingController();
  Rx<UserModel?> user = Rx<UserModel?>(null);
  Rx<ITicketState> state = ITicketState().obs;
  DownloadQrController({
    required this.repository,
  });

  Future<void> getProfile() async {
    state.value = LoadingTicketState();
    await repository.getProfile(userController.text).then((value) {
      value.fold((l) {
        state.value = SuccessTicketState();
        user.value = l;
      }, (r) {
        state.value = FailureTicketState();
        userController.text = '';
      });
    });
  }
}

import 'package:provider/provider.dart';
import 'package:rcf_attendance_generator/ui/styles/color.dart';
import 'package:flutter/material.dart';
import '../../layouts/base_scaffold.dart';
import '../../layouts/scrollable_base_scaffold_body.dart';
import '../../widgets/buttons/base_button.dart';
import '../../widgets/input/general_input.dart';
import 'view_model/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, model, _) {
      return BaseScaffold(
          body: ScrollableBaseScaffoldBody(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: Form(
                key: model.login,
                child: Column(
                  children: [
                    GeneralInput(
                      appContext: context,
                      hintText: 'Ayodele',
                      label: 'Last Name',
                      controller: model.lastname,
                    ),
                    GeneralInput(
                      appContext: context,
                      hintText: 'ayokanmi12@gmail.com',
                      controller: model.email,
                      label: 'Email',
                    ),
                    BaseButton(
                      isBusy: model.isLoading,
                      // width: 100,
                      onPressed: () {
                        model.createAndSaveUser();
                      },
                      btnText: 'Login',
                      iconColor: AppColors.white,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}

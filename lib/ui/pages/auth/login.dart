import 'package:provider/provider.dart';
import 'package:rcf_attendance_generator/ui/styles/color.dart';
import 'package:flutter/material.dart';
import '../../layouts/base_scaffold.dart';
import '../../layouts/scrollable_base_scaffold_body.dart';
import '../../widgets/buttons/base_button.dart';
import '../../widgets/input/general_input.dart';
import '../../widgets/loader.dart';
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
                showInfo(),
                const SizedBox(height:10),
                GeneralInput(
                  appContext: context,
                  hintText: 'ayokanmi12@gmail.com',
                  controller: model.email,
                  label: 'Email',
                ),
                GeneralInput(
                  appContext: context,
                  hintText: '+2348141234546',
                  label: 'PhoneNumber',
                  controller: model.lastname,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BaseButton(
                        isBusy: model.isAdminLoading,
                        // width: 100,
                        onPressed: () {
                          model.loginAsAdmin();
                        },
                        btnText: 'Login As Admin',
                        iconColor: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: BaseButton(
                        isBusy: model.isLoading,
                        // width: 100,
                        onPressed: () {
                          model.createAndSaveUser();
                        },
                        btnText: 'Login',
                        iconColor: AppColors.white,
                      ),
                    ),
                  ],
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

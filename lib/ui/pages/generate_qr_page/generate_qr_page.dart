import 'package:provider/provider.dart';
import 'package:rcf_attendance_generator/ui/pages/auth/login.dart';
import 'package:rcf_attendance_generator/ui/styles/color.dart';
import 'package:flutter/material.dart';
import '../../layouts/base_scaffold.dart';
import '../../layouts/scrollable_base_scaffold_body.dart';
import '../../widgets/buttons/base_button.dart';
import '../../widgets/input/general_input.dart';
import '../../widgets/radio_widget.dart';
import 'view_model/generate_qr_view_model.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({Key? key}) : super(key: key);

  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GenerateQrViewModel>(builder: (context, model, _) {
      return BaseScaffold(
          body: ScrollableBaseScaffoldBody(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Form(
            key: model.formKey,
            child: Column(
              children: [
                GeneralInput(
                  appContext: context,
                  hintText: 'Praise',
                  label: 'First Name',
                  controller: model.firstname,
                ),
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
                GeneralInput(
                  appContext: context,
                  label: 'Phone Number',
                  controller: model.phoneNumber,
                  hintText: '08142663737',
                ),
                RadioWidget(
                  label: 'Gender',
                  value: model.gender,
                  textValue: const ['Male', 'Female'],
                ),
                GeneralInput(
                    appContext: context,
                    label: 'Zone',
                    controller: model.zone,
                    hintText: 'RCF UNIMED Akure'),
                GeneralInput(
                  appContext: context,
                  label: 'Unit',
                  controller: model.unit,
                  hintText: 'Editorial Unit',
                ),
                GeneralInput(
                  appContext: context,
                  label: 'Worker/Executive',
                  hintText: 'Executive',
                  controller: model.workerOrExec,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseButton(
                      isBusy: model.isLoading,
                      width: 100,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      iconColor: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Login as Admin',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    BaseButton(
                      isBusy: model.isLoading,
                      width: 100,
                      onPressed: () {
                        model.createAndSaveUser(context);
                      },
                      icon: Icons.east_outlined,
                      iconColor: AppColors.white,
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

import 'dart:js_interop';

import 'package:provider/provider.dart';
import 'package:rcf_attendance_generator/ui/pages/auth/login.dart';
import 'package:rcf_attendance_generator/ui/styles/color.dart';
import 'package:flutter/material.dart';
import '../../../core/states/ticket_state.dart';
import '../../layouts/base_scaffold.dart';
import '../../layouts/scrollable_base_scaffold_body.dart';
import '../../widgets/buttons/base_button.dart';
import '../../widgets/custom_institution_dropdown.dart';
import '../../widgets/custom_zone_dropdown.dart';
import '../../widgets/input/general_input.dart';
import '../../widgets/radio_widget.dart';
import 'view_model/generate_qr_view_model.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({Key? key}) : super(key: key);

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<GenerateQrViewModel>().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GenerateQrViewModel>(builder: (context, model, _) {
      return BaseScaffold(
          body: model.isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : ScrollableBaseScaffoldBody(
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
                          CustomDropdown(
                            label: "Zone",
                            appContext: context,
                            hintText: 'Select a zone',
                          ),
                          model.selectedRcfZone.isNull
                              ? const SizedBox.shrink()
                              : CustomInstitutionDropdown(
                                hintText: "Select an Institution",
                                onChanged:  (String? newValue) {
                                setState(() {
                                  model.selectedInstitution = newValue;
                                  print(model.selectedInstitution);
                                });
                              },
                                value: model.selectedRcfZone!.institutions!,
                                appContext: context,
                                selectedInstitution: model.selectedInstitution,
                                label: "Institution"),
                          GeneralInput(
                            appContext: context,
                            label: 'Unit',
                            controller: model.unit,
                            hintText: 'Editorial Unit'),
                          GeneralInput(
                            appContext: context,
                            label: 'Worker/Executive',
                            hintText: 'Executive',
                            controller: model.workerOrExec,
                          ),
                          GeneralInput(
                            appContext: context,
                            label: 'PortFolio (For Executives)',
                            hintText: 'Portfolio',
                            controller: model.portfolio,
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
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                iconColor: AppColors.white,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Login',
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

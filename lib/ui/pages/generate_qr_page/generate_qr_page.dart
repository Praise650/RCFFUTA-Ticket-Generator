import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/images.dart';
import '../../layouts/base_scaffold.dart';
import '../../layouts/scrollable_base_scaffold_body.dart';
import '../../styles/color.dart';
import '../../styles/texts.dart';
import '../../widgets/buttons/base_button.dart';
import '../../widgets/drop_downs/custom_institution_dropdown.dart';
import '../../widgets/drop_downs/custom_units_dropdown.dart';
import '../../widgets/drop_downs/custom_zone_dropdown.dart';
import '../../widgets/input/general_input.dart';
import '../../widgets/radio_widget.dart';
import '../auth/login.dart';
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
    return Consumer<GenerateQrViewModel>(
      builder: (context, model, _) {
        return BaseScaffold(
          body: ScrollableBaseScaffoldBody(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: model.isLoading == true
                  ? const Center(child: CircularProgressIndicator())
                  : Form(
                      key: model.formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImages.crmLogo,
                                width: 70,
                                height: 100,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "LTP 2023 Registration".toUpperCase(),
                                  style: kHeadline1TextStyle.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                          CustomZoneDropdown(
                            label: "Zone",
                            appContext: context,
                            hintText: 'Select a zone',
                          ),
                          model.selectedZone.isNull
                              ? const SizedBox.shrink()
                              : CustomInstitutionDropdown(
                                  appContext: context,
                                  label: "Institution",
                                  hintText: "Select an Institution",
                                  onChanged: (String? value) => setState(() {
                                    model.selectedInstitution = value;
                                    debugPrint(model.selectedInstitution);
                                  }),
                                  value: model.selectedZone!.institutions!,
                                  selectedInstitution:
                                      model.selectedInstitution,
                                ),
                          CustomUnitDropdown(
                            appContext: context,
                            label: 'Member / Worker',
                            hintText: 'Editorial Unit',
                            value: model.zonesRepo.units,
                            selectedUnit: model.selectedUnit,
                            onChanged: (String? value) => setState(() {
                              model.selectedUnit = value;
                              print(model.selectedUnit);
                            }),
                          ),
                          CustomUnitDropdown(
                            appContext: context,
                            label: 'PortFolio (For Executives)',
                            hintText: 'Portfolio',
                            value: model.zonesRepo.positions,
                            selectedUnit: model.selectedPortfolio,
                            onChanged: (String? value) {
                              setState(() {
                                model.selectedPortfolio = value;
                                print(model.selectedPortfolio);
                              });
                            },
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
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
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
                                  model.createAndSaveUser();
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
          ),
        );
      },
    );
  }
}

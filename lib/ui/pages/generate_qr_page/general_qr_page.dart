import 'package:provider/provider.dart';
import 'package:rcf_attendance_generator/ui/styles/color.dart';
import 'package:flutter/material.dart';
import '../../layouts/base_scaffold.dart';
import '../../layouts/scrollable_base_scaffold_body.dart';
import '../../widgets/buttons/base_button.dart';
import '../../widgets/input/general_input.dart';
import '../../widgets/radio_widget.dart';
import 'view_model/generate_qr_view_model.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({Key? key})
      : super(key: key);

  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  bool isLoading = false;
  setFalse() {
    setState(() => isLoading = false);
  }

  setTrue() {
    setState(() => isLoading = true);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GenerateQrViewModel>(
        builder: (context, model, _) {
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
                        label: 'Email'),
                    RadioWidget(
                      label: 'Gender',
                      value: model.gender,
                      textValue: const ['Male', 'Female'],
                    ),
                    GeneralInput(
                        appContext: context,
                        label: 'Home Address',
                        controller: model.homeAddress,
                        hintText: 'FUTA South gate'),
                    GeneralInput(
                        appContext: context,
                        label: 'Department',
                        controller: model.department,
                        hintText: 'Computer Science'),
                    GeneralInput(
                        appContext: context,
                        label: 'Year Of Graduation',
                        controller: model.yearOfGraduation,
                        hintText: '2013'),
                    RadioWidget(
                      label: 'Are you a Worker',
                      textValue: const ['Yes', 'No'],
                      value: model.isAWorker,
                    ),
                    GeneralInput(
                      appContext: context,
                      label: 'Unit',
                      hintText: 'Publicity Department',
                      controller: model.unit,
                    ),
                    RadioWidget(
                      label: 'Are you An Executive',
                      textValue: const ['Yes', 'No'],
                      value: model.isExecutive,
                    ),
                    model.isExecutive == "Yes"?
                    // Text(
                    //   "If No, please leave blank",
                    //   style: headerPoppins.copyWith(
                    //     color: AppColor.textSecondary,
                    //   ),
                    // ),
                    GeneralInput(
                        appContext: context,
                        label: 'Executive Position',
                        controller: model.executivePosition,
                        hintText: 'Gen Sec...'):const SizedBox.shrink(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: BaseButton(
                        isBusy: isLoading,
                        width: 100,
                        onPressed: () {
                          model.createAndSaveUser(context,setTrue,setFalse);
                        },
                        icon: Icons.east_outlined,
                        iconColor: AppColors.white,
                      ),
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

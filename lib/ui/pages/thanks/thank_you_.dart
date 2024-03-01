import 'package:flutter/material.dart';

import '../../../app/images.dart';
import '../../../app/locator.dart';
import '../../../core/service/navigator_service.dart';
import '../../../routes/app_routes.dart';
import '../../layouts/base_scaffold.dart';
import '../../layouts/scrollable_base_scaffold_body.dart';
import '../../styles/color.dart';
import '../../styles/texts.dart';
import '../../widgets/buttons/base_button.dart';
import '../../widgets/loader.dart';

class ThankYou extends StatelessWidget {
  const ThankYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: ScrollableBaseScaffoldBody(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          child: Column(
            children: [
              showInfo(),
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
                      "CRM 2024 Registration".toUpperCase(),
                      style: kHeadline1TextStyle.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        'Thank you for taking time out to fill this attendance'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your inputs have been recorded and please note that n we do not give out your information',
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              BaseButton(
                // isBusy: model.isLoading,
                width: 100,
                onPressed: () {
                  locator<NavigatorService>().replace(AppRoutes.generateQrPage);
                },
                icon: Icons.east_outlined,
                iconColor: AppColors.white,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

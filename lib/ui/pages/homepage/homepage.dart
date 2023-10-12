import 'package:flutter/material.dart';

import '../../../app/images.dart';
import '../../../utils/platform_size_checker.dart';
import '../../styles/texts.dart';
import '../../widgets/buttons/base_button.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 200),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SizeChecker.isMobile(context)? 10:40),
          Image.asset(
            AppImages.rcfLogo,
            width: 95,
            height: 31,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              Hero(
                tag: 'logo',
                transitionOnUserGestures: true,
                child: Image.asset(
                  AppImages.splashLogo,
                  width: 287,
                  height: 287,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: SizeChecker.isMobile(context)? 35:45),
              Text(
                'Welcome to\nRCF FUTA Database ',
                textAlign: TextAlign.center,
                style: kHeadline1TextStyle,
              ),
            ],
          ),
          SizedBox(height: SizeChecker.isMobile(context)?100:100),
          BaseButton(
            btnText: 'Register',
            isBusy: isLoading,
            onPressed: () {
              // locator<NavigationService>().navigateTo(Routes.);
              setState(() => isLoading = true);
              Future.delayed(const Duration(seconds: 3), () {
                print('Going to input phone number ');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Container(),
                  ),
                );
                setState(() => isLoading = false);
              });
            },
          ),
          const SizedBox(height: 1),
        ],
      ),
    );
  }
}

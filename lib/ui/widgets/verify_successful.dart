// import 'package:flutter/material.dart';
// import 'package:rcf_database/app/res/images.dart';
// import 'package:rcf_database/ui/layouts/base_scaffold.dart';

// import '../layouts/responsive_widget.dart';
// import '../style/color.dart';
// import '../style/texts.dart';
// import '../views/form/form_view.dart';

// class VerifySuccessfulWidget extends StatefulWidget {
//   const VerifySuccessfulWidget({Key? key}) : super(key: key);

//   @override
//   _VerifySuccessfulWidgetState createState() => _VerifySuccessfulWidgetState();
// }

// class _VerifySuccessfulWidgetState extends State<VerifySuccessfulWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return BaseScaffold(
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: Padding(
//             padding: Responsive.isMobile(context)
//                 ? const EdgeInsets.all(0)
//                 : EdgeInsets.symmetric(
//                 horizontal: MediaQuery.of(context).size.width -
//                     MediaQuery.of(context).size.width / 1.2),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                   child: Image.asset(
//                     AppImages.thumbsUp,
//                     // width: 100,
//                     // height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 SizedBox(height: 35),
//                 Text(
//                   'Verified!',
//                   style: kHeadline1TextStyle.copyWith(
//                       fontSize: 36, color: AppColor.textSecondary),
//                 ),
//                 SizedBox(height: 146),
//                 GestureDetector(
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => FormView(),
//                     ),
//                   ),
//                   child: Text(
//                     'Proceed to the next step',
//                     style: kHeadline3TextStyle.copyWith(
//                       decoration: TextDecoration.underline,
//                       color: AppColor.normalText,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

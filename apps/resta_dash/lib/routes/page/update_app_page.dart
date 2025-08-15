// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:resta_dash/main.export.dart';
// import 'package:shorebird_code_push/shorebird_code_push.dart';

// class UpdateAppPage extends HookWidget {
//   const UpdateAppPage({super.key, this.restartRequired});

//   final bool? restartRequired;

//   @override
//   Widget build(BuildContext context) {
//     final restartNeeded = useState(restartRequired ?? false);

//     final title = switch (restartNeeded.value) {
//       true => Str(context).restartRequired,
//       false => Str(context).updateAvailable,
//     };
//     final subtitle = switch (restartNeeded.value) {
//       true => Str(context).restartTheAppToApplyTheUpdate,
//       false => Str(context).newVersionIsAvailable,
//     };

//     return Scaffold(
//       body: Padding(
//         padding: Insets.padAll,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (restartNeeded.value)
//                 const Icon(
//                   Icons.restart_alt_rounded,
//                   size: 80,
//                   color: KColor.green,
//                 )
//               else
//                 RotatedBox(
//                   quarterTurns: 4,
//                   child: Assets.lottie.arrowDown.lottie(height: 80),
//                 ),
//               const Gap(Insets.offset),
//               Text(title, style: context.text.headlineSmall),
//               const Gap(Insets.med),
//               Text(
//                 subtitle,
//                 style: context.text.bodyMedium,
//                 textAlign: TextAlign.center,
//               ),
//               const Gap(Insets.offset),
//               if (restartNeeded.value)
//                 FilledButton(
//                   style: FilledButton.styleFrom(
//                     fixedSize: const Size(200, 50),
//                     backgroundColor: KColor.green,
//                   ),
//                   onPressed: () => exit(0),
//                   child: Text(Str(context).restart),
//                 )
//               else
//                 SubmitButton(
//                   width: 200,
//                   onPressed: (l) async {
//                     l.toggle();
//                     final updater = ShorebirdUpdater();
//                     await updater.update();
//                     final status = await updater.checkForUpdate();
//                     if (status == UpdateStatus.restartRequired) {}
//                     restartNeeded.value = true;
//                     l.toggle();
//                   },
//                   icon: Assets.svg.download.svg(
//                     height: 22,
//                     colorFilter: KColor.white.toFilter(),
//                   ),
//                   child: Text(Str(context).updateNow),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

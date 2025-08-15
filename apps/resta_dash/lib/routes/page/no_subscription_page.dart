import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class NoSubscriptionPage extends HookConsumerWidget {
  const NoSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: Pads.med(),
        child: Center(
          child: Column(
            children: [
              const Gap(Insets.offset),
              Assets.lottie.underMaintenance.lottie(height: 200),
              Text('You are not subscribed to any plan yet', style: context.text.titleMedium),
              Text('Please try again later', style: context.text.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              SubmitButton(
                style: OutlinedButton.styleFrom(fixedSize: const Size(200, 50)),
                onPressed: (l) async {
                  l.toggle();
                  await ref.read(eventCtrlProvider.notifier).retry();
                  l.toggle();
                },
                icon: const Icon(Icons.refresh_rounded),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

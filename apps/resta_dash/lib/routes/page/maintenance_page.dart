import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class MaintenancePage extends HookConsumerWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: Pads.sm(),
        child: Center(
          child: Column(
            children: [
              const Gap(Insets.offset),
              Assets.lottie.underMaintenance.lottie(height: 200),
              Text('We are under maintenance', style: context.text.titleMedium),
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

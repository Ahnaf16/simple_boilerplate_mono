import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';

class FeatureUnavailablePage extends HookConsumerWidget {
  const FeatureUnavailablePage({super.key, this.asPage = true, this.showButton = true});

  final bool asPage;
  final bool showButton;
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: !asPage
          ? null
          : AppBar(
              title: const Text('Feature Unavailable'),
              // leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
            ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.build, size: 80, color: Colors.blueGrey),
              const Gap(20),
              Text('This feature is not available', style: context.text.titleLarge, textAlign: TextAlign.center),
              const Gap(20),
              Text(
                'This feature is not available in this business. Contact your manager for more information.',
                textAlign: TextAlign.center,
                style: context.text.bodyMedium,
              ),
              const Gap(30),
              if (asPage && showButton)
                FilledButton(
                  onPressed: () {
                    ref.read(eventCtrlProvider.notifier).update(AppState.active);
                    RPaths.home.go(context, query: {'forced': 'true'});
                  },
                  child: const Text('Go Back'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

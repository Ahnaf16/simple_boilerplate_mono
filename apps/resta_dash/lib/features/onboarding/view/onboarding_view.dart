import 'package:flutter/material.dart';
import 'package:resta_dash/features/onboarding/controller/onboarding_ctrl.dart';
import 'package:resta_dash/features/settings/controller/settings_ctrl.dart';
import 'package:resta_dash/main.export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends HookConsumerWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configData = ref.watch(configCtrlProvider);

    final index = useState(0);
    final pageCtrl = usePageController();

    return configData.when(
      loading: () => Loader.fullScreen(true),
      error: (e, s) => ErrorView(e, s, prov: [configCtrlProvider]).withSF(),
      data: (config) {
        final isLast = index.value == config.onboarding.length - 1;
        final isFirst = index.value == 0;
        return Scaffold(
          body: Padding(
            padding: Pads.med('tb').copyWith(top: context.mq.viewPadding.top),
            child: Stack(
              fit: StackFit.expand,
              children: [
                PageView.builder(
                  controller: pageCtrl,
                  onPageChanged: (val) => index.value = val,
                  itemCount: config.onboarding.length,
                  itemBuilder: (context, index) {
                    final item = config.onboarding[index];
                    return Padding(
                      padding: Pads.med(),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: Corners.medBorder,
                            child: HostedImage(item.image, height: context.height * .4, width: context.width),
                          ),
                          const Gap(Insets.lg),
                          Text(item.title, style: context.text.titleLarge, textAlign: TextAlign.center),
                          const Gap(Insets.med),
                          Text(item.description, style: context.text.bodyMedium?.op(.6), textAlign: TextAlign.center),
                        ],
                      ),
                    );
                  },
                ),

                Positioned.fill(
                  top: context.height * .45,
                  child: Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: index.value,
                      count: config.onboarding.length,
                      effect: ExpandingDotsEffect(
                        dotWidth: 10,
                        dotHeight: 6,
                        dotColor: context.colors.outline,
                        activeDotColor: context.colors.primary,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: context.height * .60,
                  child: Center(
                    child: SubmitButton(
                      padding: Pads.med(),
                      onPressed: (l) async {
                        if (isLast) {
                          await ref.read(onboardingCtrlProvider.notifier).complete();
                          if (context.mounted) RPaths.login.go(context);
                          return;
                        }
                        await pageCtrl.nextPage(duration: 300.milliseconds, curve: Curves.easeInOut);
                      },
                      child: Text(isFirst ? 'Get Started' : (isLast ? 'Login' : 'Next')),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: context.height * .78,
                  child: Center(
                    child: SubmitButton(
                      padding: Pads.med(),
                      style: FilledButton.styleFrom(
                        backgroundColor: context.colors.surface,
                        foregroundColor: context.colors.onSurface,
                      ),
                      onPressed: (l) async {
                        await ref.read(onboardingCtrlProvider.notifier).complete();
                        if (context.mounted) RPaths.login.go(context);
                      },
                      child: const Text('Skip'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

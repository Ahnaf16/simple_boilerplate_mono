import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:resta_dash/features/auth/controller/auth_ctrl.dart';
import 'package:resta_dash/main.export.dart';

class SignUpView extends HookConsumerWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCtrl = useCallback(() => ref.read(authCtrlProvider.notifier));
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final tnc = useState(false);
    return Scaffold(
      body: SingleChildScrollView(
        padding: Pads.med().withViewPadding(context),
        child: FormBuilder(
          key: formKey,
          child: Column(
            spacing: Insets.med,
            children: [
              const CenterLeft(child: KBackButton()),
              DecoContainer(
                color: context.colors.surface,
                borderRadius: Corners.circle,
                padding: Pads.xl(),
                child: Assets.icon.duoTone.userDuo.svg(),
              ),
              Text('Set up your profile', style: context.text.titleLarge),
              Text(
                'Customize your profile to personalize your experience and streamline your business',
                textAlign: TextAlign.center,
                style: context.text.bodyMedium!.op(.6),
              ),
              const Gap(0),
              KTextField(
                name: 'name',
                hintText: 'Enter Name',
                prefixIcon: Assets.icon.user.svg(width: 18, colorFilter: context.colors.outline.toFilter()),
              ),
              KTextField(name: 'email', hintText: 'Enter email', prefixIcon: Assets.icon.mail.svg(width: 20)),
              KTextField(
                name: 'password',
                hintText: 'Enter password',
                isPassField: true,
                prefixIcon: Assets.icon.lock.svg(width: 20),
              ),
              KTextField(
                name: 'confirm_password',
                hintText: 'Confirm password',
                isPassField: true,
                prefixIcon: Assets.icon.lock.svg(width: 20),
              ),
              GestureDetector(
                onTap: () => tnc.toggle(),
                child: Row(
                  spacing: Insets.sm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      tnc.value ? Icons.check_circle_outline : Icons.circle_outlined,
                      size: 18,
                      color: tnc.value ? context.colors.primary : context.colors.outline.op7,
                    ),
                    Flexible(
                      child: Text(
                        'By tapping continue, you accept to the RestaDash Terms and Privacy Policy for secure usage.',
                        style: context.text.bodySmall?.op(.6),
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(Insets.lg),
              SubmitButton(
                onPressed: (l) async {
                  final state = formKey.currentState!;
                  if (!state.saveAndValidate()) return;
                  l.truthy();
                  final res = await authCtrl().login(state.value);
                  l.falsey();
                  if (context.mounted && res) RPaths.home.push(context);
                },
                child: const Text('Sign up'),
              ),

              const Gap(Insets.sm),
            ],
          ),
        ),
      ),
    );
  }
}

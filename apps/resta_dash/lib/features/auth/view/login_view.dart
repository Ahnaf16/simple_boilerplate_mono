import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:resta_dash/features/auth/controller/auth_ctrl.dart';
import 'package:resta_dash/main.export.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authCtrl = useCallback(() => ref.read(authCtrlProvider.notifier));
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    return Scaffold(
      body: Padding(
        padding: Pads.med().withViewPadding(context),
        child: FormBuilder(
          key: formKey,
          child: Column(
            spacing: Insets.med,
            children: [
              DecoContainer(
                color: context.colors.surface,
                borderRadius: Corners.circle,
                padding: Pads.xl(),
                child: Assets.icon.duoTone.userDuo.svg(),
              ),
              Text('Access your account', style: context.text.titleLarge),
              Text(
                'Log in to securely access your account and manage your settings easily.',
                textAlign: TextAlign.center,
                style: context.text.bodyMedium!.op(.6),
              ),
              const Gap(0),
              KTextField(name: 'email', hintText: 'Enter email', prefixIcon: Assets.icon.mail.svg(width: 20)),
              KTextField(
                name: 'password',
                hintText: 'Enter password',
                isPassField: true,
                prefixIcon: Assets.icon.lock.svg(width: 20),
              ),

              const Spacer(),
              SubmitButton(
                onPressed: (l) async {
                  final state = formKey.currentState!;
                  if (!state.saveAndValidate()) return;
                  l.truthy();
                  final res = await authCtrl().login(state.value);
                  l.falsey();
                  if (context.mounted && res) RPaths.home.push(context);
                },
                child: const Text('Login'),
              ),
              SubmitButton(
                style: FilledButton.styleFrom(
                  backgroundColor: context.colors.surface,
                  foregroundColor: context.colors.onSurface,
                ),
                onPressed: (l) async {
                  RPaths.home.push(context);
                },
                child: const Text('Guest Login'),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Don\'t have an account?  '),
                    TextSpan(
                      text: 'Sign Up',
                      style: context.text.bodyMedium?.bold.primary,
                      recognizer: TapGestureRecognizer()..onTap = () => RPaths.signUp.push(context),
                    ),
                  ],
                ),
              ),
              const Gap(Insets.sm),
            ],
          ),
        ),
      ),
    );
  }
}

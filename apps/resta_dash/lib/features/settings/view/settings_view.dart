import 'package:flutter/material.dart';
import 'package:resta_dash/features/auth/controller/auth_ctrl.dart';
import 'package:resta_dash/features/profile/controller/profile_ctrl.dart';
import 'package:resta_dash/main.export.dart';

class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authCtrlProvider);
    final authCtrl = useCallback(() => ref.read(authCtrlProvider.notifier));
    final userData = ref.watch(userCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), leading: const KBackButton()),
      body: SingleChildScrollView(
        padding: Pads.med(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLoggedIn)
              Row(
                spacing: Insets.med,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: DecoContainer(
                        color: context.colors.surface,
                        borderRadius: Corners.med,
                        padding: Pads.lg(),
                        borderColor: context.colors.outlineVariant,
                        borderWidth: 1,
                        child: Column(spacing: Insets.sm, children: [Assets.icon.receipt.svg(), const Text('Orders')]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: DecoContainer(
                        color: context.colors.surface,
                        borderRadius: Corners.med,
                        padding: Pads.lg(),
                        borderColor: context.colors.outlineVariant,
                        borderWidth: 1,
                        child: Column(spacing: Insets.sm, children: [Assets.icon.refund.svg(), const Text('Refund')]),
                      ),
                    ),
                  ),
                ],
              ),
            const Gap(Insets.med),
            if (isLoggedIn)
              userData.when(
                loading: () => const Loader.shimmer(),
                error: (e, s) => ErrorView(e, s, prov: [userCtrlProvider]),
                data: (user) {
                  return DecoContainer(
                    padding: Pads.med(),
                    color: context.colors.surface,
                    borderRadius: Corners.med,
                    child: Row(
                      children: [
                        CircleImage(user.photo),
                        const Gap(Insets.lg),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name),
                            Text(user.email, style: context.text.labelMedium?.op(.6)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            else
              GestureDetector(
                onTap: () {
                  RPaths.login.push(context);
                },
                child: DecoContainer(
                  color: context.colors.surface,
                  borderRadius: Corners.med,
                  padding: Pads.lg(),

                  child: Row(
                    spacing: Insets.med,
                    children: [
                      const Icon(Icons.login_rounded),
                      Text('Login now', style: context.text.bodyLarge),
                    ],
                  ),
                ),
              ),
            const Gap(Insets.med),
            Text('Account Settings', style: context.text.titleMedium?.regular),
            const Gap(Insets.sm),
            UiSection(
              child: SeparatedColumn(
                separatorBuilder: () => const Divider(height: 0),
                children: [
                  GestureDetector(
                    onTap: () => RPaths.language.push(context),
                    child: DecoContainer(
                      color: context.colors.surface,
                      borderRadius: Corners.med,
                      padding: Pads.lg(),
                      child: Row(
                        spacing: Insets.med,
                        children: [
                          Assets.icon.userOctagon.svg(),
                          Text(t.language, style: context.text.bodyLarge),
                        ],
                      ),
                    ),
                  ),
                  if (isLoggedIn)
                    GestureDetector(
                      onTap: () {},
                      child: DecoContainer(
                        color: context.colors.surface,
                        borderRadius: Corners.med,
                        padding: Pads.lg(),
                        child: Row(
                          spacing: Insets.med,
                          children: [
                            Assets.icon.user.svg(),
                            Text('Manage Account', style: context.text.bodyLarge),
                          ],
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: () {},
                    child: DecoContainer(
                      color: context.colors.surface,
                      borderRadius: Corners.med,
                      padding: Pads.lg(),
                      child: Row(
                        spacing: Insets.med,
                        children: [
                          Assets.icon.messageQuestion.svg(),
                          Text('Help & Support', style: context.text.bodyLarge),
                        ],
                      ),
                    ),
                  ),

                  if (isLoggedIn)
                    GestureDetector(
                      onTap: () => RPaths.language.push(context),
                      child: DecoContainer(
                        color: context.colors.surface,
                        borderRadius: Corners.med,
                        padding: Pads.lg(),
                        child: Row(
                          spacing: Insets.med,
                          children: [
                            Assets.icon.userOctagon.svg(),
                            Text('Delete Account', style: context.text.bodyLarge),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const Gap(Insets.med),
            if (isLoggedIn)
              ListTile(
                title: const Text('Logout'),
                trailing: const Icon(Icons.logout_rounded),
                onTap: () async {
                  await authCtrl().logout();
                  if (context.mounted) RPaths.home.push(context);
                },
                tileColor: context.colors.error,
                textColor: context.colors.onError,
                iconColor: context.colors.onError,
              ),
            const Gap(Insets.lg),
            Center(child: Text(kVersion, style: context.text.bodySmall?.op(.6))),
          ],
        ),
      ),
    );
  }
}

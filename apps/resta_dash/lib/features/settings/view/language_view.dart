import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:resta_dash/main.export.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t.language)),
      body: ListView.separated(
        padding: Pads.sm(),
        itemCount: AppLocale.values.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final locale = AppLocale.values[index];
          final selected = LocaleSettings.currentLocale == locale;
          final name = LocaleNamesLocalizationsDelegate.nativeLocaleNames.get(locale.languageCode) ?? locale.name;
          return ListTile(
            onTap: () {
              setState(() {
                LocaleSettings.setLocale(locale);
              });
            },
            leading: CircleAvatar(
              backgroundColor: selected ? context.colors.primary : context.colors.surfaceContainer,
              foregroundColor: selected ? context.colors.onPrimary : context.colors.onSurface,
              child: Text(locale.languageCode.up),
            ),
            title: Text(name),
            selected: selected,
          );
        },
      ),
    );
  }
}

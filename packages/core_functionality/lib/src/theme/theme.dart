import 'package:core_functionality/core_functionality.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_ui/shared_ui.dart';

class AppTheme {
  const AppTheme._();

  // Brand colors
  static const Color primary = Color(0xFFE63946); // Primary Red from Figma
  static const Color secondary = Color(0xFF2ECC71); // Secondary Green from Figma

  // Status colors (unchanged, unless you want them from another style guide)
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF2196F3);

  // Neutral / background colors from Figma
  static const Color neutral100 = Color(0xFFFFFFFF); // white
  static const Color neutral200 = Color(0xFFF5F5F5); // light gray
  static const Color neutral300 = Color(0xFFDFE1E7); // pale gray
  static const Color neutral400 = Color(0xFFD6D6D0); // warm gray
  static const Color neutral500 = Color(0xFFE6E6E5); // cool gray
  static const Color neutral600 = Color(0xFF8E8E93); // dark gray
  static const Color neutral700 = Color(0xFF71717A); // charcoal gray
  static const Color neutral900 = Color(0xFF111111); // almost black

  // Background & surface
  static const Color backgroundLight = neutral200;
  static const Color surfaceLight = neutral100;
  static const Color backgroundDark = neutral900;
  static const Color surfaceDark = Color(0xFF292929); // keep for contrast

  // Text colors
  static const Color textLight = neutral900;
  static const Color textDark = neutral100;

  static const FlexSchemeData restaDashScheme = FlexSchemeData(
    name: kName,
    description: 'Run Your Restaurant at the Speed of Service',
    light: FlexSchemeColor(
      primary: primary,
      primaryContainer: Color(0xFFFFCDD2),
      secondary: secondary,
      secondaryContainer: Color(0xFFA5D6A7),
      tertiary: info,
      tertiaryContainer: Color(0xFFBBDEFB),
      error: error,
    ),
    dark: FlexSchemeColor(
      primary: primary,
      primaryContainer: Color(0xFFB71C1C),
      secondary: secondary,
      secondaryContainer: Color(0xFF1B5E20),
      tertiary: info,
      tertiaryContainer: Color(0xFF1565C0),
      error: error,
    ),
  );

  static ThemeData lightTheme = FlexThemeData.light(
    colors: restaDashScheme.light,
    scaffoldBackground: backgroundLight,
    surface: surfaceLight,
    appBarStyle: FlexAppBarStyle.scaffoldBackground,
    appBarElevation: 3,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 7,
    surfaceTint: Colors.white,
    subThemesData: const FlexSubThemesData(
      elevatedButtonRadius: Corners.sm,
      inputDecoratorRadius: Corners.sm,
      cardRadius: Corners.med,
      chipRadius: Corners.sm,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    textTheme: textTheme,
  );

  static ThemeData darkTheme = FlexThemeData.dark(
    colors: restaDashScheme.dark,
    scaffoldBackground: backgroundDark,
    surface: surfaceDark,
    appBarStyle: FlexAppBarStyle.scaffoldBackground,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 10,
    subThemesData: const FlexSubThemesData(
      elevatedButtonRadius: Corners.sm,
      inputDecoratorRadius: Corners.sm,
      cardRadius: Corners.med,
      chipRadius: Corners.sm,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    textTheme: textTheme,
  );
  static TextTheme get textTheme => GoogleFonts.manropeTextTheme();

  static ThemeData theme(bool isDark) {
    final theme = isDark ? darkTheme : lightTheme;
    final color = theme.colorScheme;
    final text = textTheme;

    return theme.copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        titleTextStyle: text.bodyLarge,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        isDense: true,
        fillColor: color.surface,
        hintStyle: theme.textTheme.bodySmall!.op(.5),
        border: const OutlineInputBorder(borderRadius: Corners.circleBorder, borderSide: BorderSide.none),
      ),
      listTileTheme: ListTileThemeData(
        shape: const RoundedRectangleBorder(borderRadius: Corners.medBorder),
        tileColor: color.surface,
        selectedTileColor: color.surface,
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: primary,
        iconTheme: WidgetStateMapper({
          WidgetState.selected: IconThemeData(color: color.onPrimary.op9),
          WidgetState.any: const IconThemeData(color: Colors.grey),
        }),
      ),
    );
  }
}

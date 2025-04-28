import 'package:edu_bridge_app/core/export.dart';
import 'package:edu_bridge_app/core/theme/extension/app_colors_extension.dart';

extension ThemeExt on BuildContext {
  AppColorsExtension get colorExt =>
      Theme.of(this).extension<AppColorsExtension>()!;
}

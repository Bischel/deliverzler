import 'package:deliverzler/core/routing/navigation_service.dart';
import 'package:deliverzler/core/routing/route_paths.dart';
import 'package:deliverzler/core/viewmodels/app_locale_provider.dart';
import 'package:deliverzler/core/viewmodels/app_theme_provider.dart';
import 'package:deliverzler/general/model/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deliverzler/core/services/localization_service.dart';
import 'package:deliverzler/core/styles/app_colors.dart';
import 'package:deliverzler/core/styles/sizes.dart';
import 'package:deliverzler/core/widgets/custom_text.dart';
import 'package:deliverzler/general/components/settings_components/settings_section_component.dart';
import 'package:deliverzler/general/components/settings_components/settings_tile_component.dart';

class AppSettingsSectionComponent extends ConsumerWidget {
  const AppSettingsSectionComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final _selectedLanguage = ref.watch(appLocaleProvider);
    final _isDarkThemeMode = ref.watch(appThemeProvider) == ThemeMode.dark;

    return SettingsSectionComponent(
      headerIcon: Icons.settings,
      headerTitle: tr(context).appSettings,
      tileList: [
        SettingsTileComponent(
          customTitle: Row(
            children: <Widget>[
              Icon(
                !_isDarkThemeMode ? Icons.wb_sunny : Icons.nights_stay,
                size: Sizes.iconsSizes(context)['s6'],
                color: Theme.of(context).textTheme.headline4!.color,
              ),
              SizedBox(
                width: Sizes.hMarginSmallest(context),
              ),
              CustomText.h5(
                context,
                tr(context).theme,
                color: Theme.of(context).textTheme.headline4!.color,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          customTrailing: SizedBox(
            width: Sizes.switchThemeButtonWidth(context),
            child: Switch.adaptive(
              value: !_isDarkThemeMode,
              onChanged: (value) {
                ref
                    .watch(appThemeProvider.notifier)
                    .changeTheme(isLight: value);
              },
              activeColor: AppColors.white,
              activeTrackColor: AppColors.lightOrange,
            ),
          ),
        ),
        SettingsTileComponent(
          customTitle: Row(
            children: <Widget>[
              Icon(
                Icons.translate,
                size: Sizes.iconsSizes(context)['s6'],
                color: Theme.of(context).textTheme.headline4!.color,
              ),
              SizedBox(
                width: Sizes.hMarginSmallest(context),
              ),
              CustomText.h5(
                context,
                tr(context).language,
                color: Theme.of(context).textTheme.headline4!.color,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: getCurrentLanguageName(
            context,
            _selectedLanguage?.languageCode,
          ),
          onTap: () {
            NavigationService.push(
              isNamed: true,
              page: RoutePaths.settingsLanguage,
            );
          },
        ),
      ],
    );
  }
}

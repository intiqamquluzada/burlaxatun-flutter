class SettingsItemModel {
  SettingsItemModel({
    required this.icon,
    required this.settingName,
    this.route,
  });

  final String icon;
  final String settingName;
  final String? route;

  static List<SettingsItemModel> items = [
    SettingsItemModel(
      icon: 'assets/icons/setting_bing_icon.svg',
      settingName: 'Bildirişlər',
    ),
    SettingsItemModel(
      icon: 'assets/icons/privacy_policy_icon.svg',
      settingName: 'Şifrəni dəyiş',
      route: '/change_password',
    ),
    SettingsItemModel(
      icon: 'assets/icons/phone_call_icon.svg',
      settingName: 'Mobil nömrəni dəyiş',
      route: '/change_number',
    ),
    // SettingsItemModel(
    //   icon: 'assets/icons/setting_global_icon.svg',
    //   settingName: 'İstifadə dilini dəyiş',
    //   route: '/change_language',
    // ),
  ];
}

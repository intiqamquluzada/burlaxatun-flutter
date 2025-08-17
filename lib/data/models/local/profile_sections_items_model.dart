class ProfileSectionsItemsModel {
  ProfileSectionsItemsModel({
    required this.icon,
    required this.sectionName,
    this.sectionRoute,
  });

  final String icon;
  final String sectionName;
  final String? sectionRoute;

  static List<ProfileSectionsItemsModel> items = [
    ProfileSectionsItemsModel(
      icon: 'assets/icons/settings_icon.svg',
      sectionName: 'Tənzimləmələr',
      sectionRoute: '/settings',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/settings_icon.svg',
      sectionName: 'Profili dəyiş',
      sectionRoute: '/change_profile',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/faq_icon.svg',
      sectionName: 'Tez-tez verilən suallar',
      sectionRoute: '/faq',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/share_arrow_icon.svg',
      sectionName: 'Dostunla paylaş',
      // sectionRoute: '/share',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/info_icon.svg',
      sectionName: 'Haqqımızda',
      sectionRoute: '/about_us',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/phone_call_icon.svg',
      sectionName: 'Bizimlə əlaqə',
      sectionRoute: '/contact_us',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/document_icon.svg',
      sectionName: 'İstifadə qaydaları',
      sectionRoute: '/terms_of_use',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/privacy_policy_icon.svg',
      sectionName: 'Məxfilik siyasəti',
      sectionRoute: '/privacy_policy',
    ),
    // ProfileSectionsItemsModel(
    //   icon: 'assets/icons/special_thanks_icon.svg',
    //   sectionName: 'Xüsusi minətdarılıq',
    //   sectionRoute: '/special_thanks',
    // ),
  ];
}

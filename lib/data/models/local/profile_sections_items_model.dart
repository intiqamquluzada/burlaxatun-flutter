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
      icon: 'assets/icons/Setting.svg',
      sectionName: 'Tənzimləmələr',
      sectionRoute: '/settings',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/profile_add_1.svg',
      sectionName: 'Profili dəyiş',
      sectionRoute: '/change_profile',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/tabler_question_mark.svg',
      sectionName: 'Tez-tez verilən suallar',
      sectionRoute: '/faq',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/fluent_share-32-regular.svg',
      sectionName: 'Dostunla paylaş',
      // sectionRoute: '/share',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/information_circle.svg',
      sectionName: 'Haqqımızda',
      sectionRoute: '/about_us',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/Call.svg',
      sectionName: 'Bizimlə əlaqə',
      sectionRoute: '/contact_us',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/document_justify_center_2.svg',
      sectionName: 'İstifadə qaydaları',
      sectionRoute: '/terms_of_use',
    ),
    ProfileSectionsItemsModel(
      icon: 'assets/icons/security_safe.svg',
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

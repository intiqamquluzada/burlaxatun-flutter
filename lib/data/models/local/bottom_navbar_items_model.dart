class BottomNavbarItemsModel {
  const BottomNavbarItemsModel({
    required this.icon,
    required this.iconTitle,
  });

  final String icon;
  final String iconTitle;

  static const items = [
    BottomNavbarItemsModel(
      icon: 'assets/svgs/home_icon.svg',
      iconTitle: 'Ana Səhifə',
    ),
    BottomNavbarItemsModel(
      icon: 'assets/svgs/dairy_advise_icon.svg',
      iconTitle: 'Gündəlik \n Tövsiyyə',
    ),
    BottomNavbarItemsModel(
      icon: 'assets/svgs/forum_icon.svg',
      iconTitle: 'Forum',
    ),
    BottomNavbarItemsModel(
      icon: 'assets/svgs/profile_icon.svg',
      iconTitle: 'Profil',
    ),
  ];
}

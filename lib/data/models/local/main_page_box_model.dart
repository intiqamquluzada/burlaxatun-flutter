class MainPageBoxModel {
  const MainPageBoxModel({
    required this.boxName,
    required this.boxIcon,
    this.route,
  });

  final String boxName;
  final String boxIcon;
  final String? route;

  static const List items = [
    MainPageBoxModel(
      boxName: 'Gündəlik Tövsiyyələr',
      boxIcon: 'assets/icons/blood_pressure_icon.svg',
    ),
    MainPageBoxModel(
      boxName: 'Ultrasəs',
      boxIcon: 'assets/icons/ultrasound_icon.svg',
      route: '/ultrasound',
    ),
    MainPageBoxModel(
      boxName: 'Dərmanlar',
      boxIcon: 'assets/icons/medicine_icon.svg',
      route: '/my_medicines_page',
    ),
    MainPageBoxModel(
      boxName: 'Şəfa kartım',
      boxIcon: 'assets/svgs/my_healing_page_icon.svg',
      route: '/my_healing_card',
    ),
    MainPageBoxModel(
      boxName: 'Həkimlər',
      boxIcon: 'assets/icons/doctor_icon.svg',
      route: '/initial_doctors',
    ),
    MainPageBoxModel(
      boxName: 'Blog',
      boxIcon: 'assets/icons/list_icon.svg',
      route: '/initial_blog',
    ),
    MainPageBoxModel(
      boxName: 'Videolar',
      boxIcon: 'assets/icons/videoo_icon.svg',
      route: '/videos',
    ),
    MainPageBoxModel(
      boxName: 'Uşaq adları',
      boxIcon: 'assets/icons/baby_namess_icon.svg',
      route: '/initial_names',
    ),
  ];
}

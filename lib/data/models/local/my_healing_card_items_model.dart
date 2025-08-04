class MyHealingCardItemsModel {
  const MyHealingCardItemsModel({
    required this.icon,
    required this.tileName,
    this.indciatorName,
  });

  final String icon;
  final String tileName;
  final String? indciatorName;

  static const List items = [
    // MyHealingCardItemsModel(
    //   icon: 'assets/icons/indicator_medicine_icon.svg',
    //   tileName: 'Dərmanlarım',
    //   indciatorName: 'medicines',
    // ),
    MyHealingCardItemsModel(
      icon: 'assets/icons/indicator_weight_icon.svg',
      tileName: 'Bədən çəkisi',
      indciatorName: 'weight',
    ),
    MyHealingCardItemsModel(
      icon: 'assets/icons/indicator_height_icon.svg',
      tileName: 'Boy',
      indciatorName: 'height',
    ),
    MyHealingCardItemsModel(
      icon: 'assets/icons/indicator_blood_pressure_icon.svg',
      tileName: 'Arterial təzyiq',
      indciatorName: 'height',
    ),
    MyHealingCardItemsModel(
      icon: 'assets/icons/indicator_coronary_icon.svg',
      tileName: 'Nəbz',
      indciatorName: 'height',
    ),
    MyHealingCardItemsModel(
      icon: 'assets/icons/indicator_sugar_icon.svg',
      tileName: 'Acqarına şəkər',
      indciatorName: 'height',
    ),
  ];
}

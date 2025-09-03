import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/baby_names_cubit/baby_names_cubit.dart';
import '../../../../../../../../data/models/remote/response/names_model.dart';
import 'girl_name_tile.dart';

class GirlNames extends StatefulWidget {
  const GirlNames({
    super.key,
    required this.countryId,
  });

  final String countryId;

  @override
  State<GirlNames> createState() => _GirlNamesState();
}

class _GirlNamesState extends State<GirlNames>
    with AutomaticKeepAliveClientMixin {
  late BabyNamesCubit babyNamesCubit;
  late ScrollController scrollController;
  @override
  void initState() {
    babyNamesCubit = context.read<BabyNamesCubit>();
    scrollController = ScrollController();
    babyNamesCubit.getNames(countryId: widget.countryId, gender: 'female');
    // babyNamesCubit.state.femaleNamesList == null
    // ? babyNamesCubit.getNames(countryId: widget.countryId, gender: 'female')
    // : null;
    _loadMore();
    super.initState();
  }

  void _loadMore() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await babyNamesCubit.getNames(
            countryId: widget.countryId, gender: 'female');
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BabyNamesCubit, BabyNamesState>(
      buildWhen: (previous, current) {
        return previous.femaleNamesList != current.femaleNamesList;
      },
      builder: (context, state) {
        if (state.nameStateStatus == NameStateStatus.loading) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state.nameStateStatus == NameStateStatus.error) {
          return Center(child: Text('Məlumat tapılmadı'));
        } else if (state.nameStateStatus == NameStateStatus.networkError) {
          return Center(child: Text('Şəbəkə xətası'));
        }
        if (state.nameStateStatus == NameStateStatus.success) {
          // final girlNames = state.femaleNamesList;
          return BlocSelector<BabyNamesCubit, BabyNamesState, List<GenderName>>(
            selector: (state) {
              return state.femaleNamesList ?? [];
            },
            builder: (BuildContext context, List<GenderName> girlNames) {
              return Column(
                children: [
                  Visibility(
                    visible: girlNames.isNotEmpty,
                    replacement: GlobalText(text: 'Siyahı boşdur'),
                    child: Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount: girlNames.length,
                        itemBuilder: (_, i) {
                          final name = girlNames[i].name ?? 'ad tapılmadı';
                          final babyNameId = girlNames[i].id ?? -1;
                          final isSelected = ValueNotifier<bool>(false);
                          return GirlNameTile(
                            name: name,
                            babyNameId: babyNameId,
                            isSelectedName: isSelected,
                          );
                        },
                        separatorBuilder: (_, index) {
                          return Divider(
                            color: Color(0xffDADADA),
                          );
                        },
                      ),
                    ),
                  ),
                  BlocBuilder<BabyNamesCubit, BabyNamesState>(
                    buildWhen: (previous, current) {
                      return previous.nameStateStatus !=
                          current.nameStateStatus;
                    },
                    builder: (context, state) {
                      if (state.nameStateStatus == NameStateStatus.loading) {
                        return CircularProgressIndicator.adaptive();
                      }
                      return SizedBox.shrink();
                    },
                  )
                ],
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

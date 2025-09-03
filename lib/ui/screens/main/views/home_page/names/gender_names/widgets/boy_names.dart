import 'dart:developer';

import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/baby_names_cubit/baby_names_cubit.dart';
import '../../../../../../../../data/models/remote/response/names_model.dart';
import 'boy_name_tile.dart';

class BoyNames extends StatefulWidget {
  const BoyNames({
    super.key,
    required this.countryId,
  });

  final String countryId;

  @override
  State<BoyNames> createState() => _BoyNamesState();
}

class _BoyNamesState extends State<BoyNames>
    with AutomaticKeepAliveClientMixin {
  late BabyNamesCubit babyNamesCubit;
  late ScrollController scrollController;
  @override
  void initState() {
    log('init boy names');
    babyNamesCubit = context.read<BabyNamesCubit>();
    scrollController = ScrollController();
    babyNamesCubit.getNames(countryId: widget.countryId, gender: 'male');
    // babyNamesCubit.state.maleNamesList == null
    //     ? babyNamesCubit.getNames(countryId: widget.countryId, gender: 'male')
    //     : null;
    _loadMore();
    super.initState();
  }

  void _loadMore() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        await babyNamesCubit.getNames(
          countryId: widget.countryId,
          gender: 'male',
        );
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
        return previous.maleNamesList != current.maleNamesList;
        // return previous.maleNamesList == null;
        // return previous.maleNamesList == null ||
        // previous.maleNamesList!.isEmpty;
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
          // final boyNames = state.maleNamesList;
          return BlocSelector<BabyNamesCubit, BabyNamesState, List<GenderName>>(
            selector: (BabyNamesState state) {
              return state.maleNamesList ?? [];
            },
            builder: (BuildContext context, List<GenderName> boyNames) {
              return Column(
                children: [
                  Visibility(
                    visible: boyNames.isNotEmpty,
                    replacement: GlobalText(text: 'Siyahı boşdur'),
                    child: Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount: boyNames.length,
                        itemBuilder: (_, i) {
                          final name = boyNames[i].name ?? 'ad tapılmadı';
                          final babyNameId = boyNames[i].id ?? -1;
                          final isSelected = ValueNotifier<bool>(false);
                          return BoyNameTile(
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
                      return
                          // previous.maleNamesList != null &&
                          previous.nameStateStatus != current.nameStateStatus;
                    },
                    builder: (context, state) {
                      if (state.nameStateStatus == NameStateStatus.loading) {
                        return CircularProgressIndicator.adaptive();
                      }
                      return SizedBox.shrink();
                    },
                  ),
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

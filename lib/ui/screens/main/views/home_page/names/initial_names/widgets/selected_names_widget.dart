import 'dart:developer';

import 'package:burla_xatun/cubits/baby_names_cubit/baby_names_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'selected_name_tile.dart';

class SelectedNamesWidget extends StatefulWidget {
  const SelectedNamesWidget({super.key});

  @override
  State<SelectedNamesWidget> createState() => _SelectedNamesWidgetState();
}

class _SelectedNamesWidgetState extends State<SelectedNamesWidget>
    with AutomaticKeepAliveClientMixin {
  late BabyNamesCubit babyNamesCubit;
  @override
  void initState() {
    babyNamesCubit = context.read<BabyNamesCubit>()..getSelectedNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BabyNamesCubit, BabyNamesState>(
      buildWhen: (previous, current) {
        return previous.selectedNamesList != current.selectedNamesList;
      },
      builder: (context, state) {
        if (state.nameStateStatus == NameStateStatus.loading) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state.nameStateStatus == NameStateStatus.networkError) {
          return Center(child: Text('Şəbəkə xətası'));
        } else if (state.nameStateStatus == NameStateStatus.error) {
          return Center(child: Text('Məlumat tapılmadı'));
        }
        if (state.nameStateStatus == NameStateStatus.success) {
          final selectedNames = state.selectedNamesList;
          log('in list: $selectedNames');
          return RefreshIndicator(
            onRefresh: () async {
              babyNamesCubit.getSelectedNames();
            },
            child: selectedNames!.isEmpty
                ? ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Center(
                          child: Text('Hər hansı seçilmiş ad yoxdur'),
                        ),
                      )
                    ],
                  )
                : ListView.separated(
                    itemCount: selectedNames.length,
                    itemBuilder: (_, i) {
                      final selectedName = selectedNames[i];
                      return SelectedNameTile(
                        name: selectedName.babyName ?? '',
                        nameId: selectedName.id ?? -1,
                      );
                    },
                    separatorBuilder: (_, index) {
                      return Divider(
                        color: Color(0xffDADADA),
                      );
                    },
                  ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

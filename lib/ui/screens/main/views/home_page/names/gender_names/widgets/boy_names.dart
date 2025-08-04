import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/baby_names_cubit/baby_names_cubit.dart';
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
  @override
  void initState() {
    babyNamesCubit = context.read<BabyNamesCubit>();
    babyNamesCubit.getNames(countryId: widget.countryId, gender: 'male');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BabyNamesCubit, BabyNamesState>(
      buildWhen: (previous, current) {
        return previous.maleNamesList != current.maleNamesList;
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
          final boyNames = state.maleNamesList;
          return ListView.separated(
            itemCount: boyNames?.length ?? 0,
            itemBuilder: (_, i) {
              final name = boyNames?[i].name ?? 'ad tapılmadı';
              final babyNameId = boyNames?[i].id ?? -1;
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
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

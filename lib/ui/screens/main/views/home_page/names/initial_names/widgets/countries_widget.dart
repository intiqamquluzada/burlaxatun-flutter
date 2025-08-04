import 'dart:developer';

import 'package:burla_xatun/cubits/baby_names_cubit/baby_names_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CountriesWidget extends StatefulWidget {
  const CountriesWidget({super.key});

  @override
  State<CountriesWidget> createState() => _CountriesWidgetState();
}

class _CountriesWidgetState extends State<CountriesWidget>
    with AutomaticKeepAliveClientMixin {
      
  late BabyNamesCubit _babyNamesCubit;
  @override
  void initState() {
    super.initState();
    log('init countries');
    _babyNamesCubit = context.read<BabyNamesCubit>()..getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BabyNamesCubit, BabyNamesState>(
      buildWhen: (previous, current) {
        return previous.countries != current.countries;
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
          final countryResponse = state.countries;
          final countrieList = countryResponse?.results;
          return ListView.separated(
            itemCount: countrieList?.length ?? 0,
            itemBuilder: (_, i) {
              final country = countrieList?[i];
              return ListTile(
                leading: ClipOval(
                  child: CachedNetworkImage(
                    width: 46,
                    height: 46,
                    fit: BoxFit.cover,
                    imageUrl: country?.flag ?? '',
                    errorWidget: (context, url, error) {
                      return Icon(Icons.error);
                    },
                  ),
                ),
                title: Text(country?.name ?? 'country name not found'),
                trailing: SvgPicture.asset('assets/icons/arrow_right.svg'),
                onTap: () {
                  context.push('/gender_names', extra: {
                    'id': country?.id ?? -1,
                    'cubit': _babyNamesCubit,
                  });
                },
              );
            },
            separatorBuilder: (_, __) =>
                const Divider(color: Color(0xffDADADA)),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

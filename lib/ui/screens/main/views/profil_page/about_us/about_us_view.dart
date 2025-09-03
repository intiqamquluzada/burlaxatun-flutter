import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../cubits/about/about_cubit.dart';
import '../../../../../../utils/constants/color_constants.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../widgets/custom_circular_progress_indicator.dart';
import '../../../../../widgets/global_appbar.dart';
import '../widgets/text_board_widget.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldColor,
      appBar: GlobalAppbar(
        title: 'Haqqımızda',
        onLeadingTap: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AboutCubit, AboutState>(
          builder: (_, state) {
            if (state.status == AboutStatus.loading) {
              return Center(
                child: CustomCircularProgressIndicator(
                  isWhite: false,
                ),
              );
            }

            if (state.status == AboutStatus.failure) {
              return Center(
                child: Text('Xəta'),
              );
            }

            if (state.status == AboutStatus.networkError) {
              return Center(
                child: Text('Şəbəkə xətası'),
              );
            }

            if (state.status == AboutStatus.success) {
              final data = state.response?.results ?? [];
              final result = data.isNotEmpty ? data[0] : null;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    24.h,
                    TextBoardWidget(
                      text: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 19, horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 20,
                          children: [
                            Html(data: result?.text ?? ''),
                            // DescriptionWidget(description: result?.text ?? ''),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

import 'package:burla_xatun/cubits/privacy_policy/privacy_policy_cubit.dart';
import 'package:burla_xatun/ui/screens/main/views/profil_page/widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../utils/constants/color_constants.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../widgets/custom_circular_progress_indicator.dart';
import '../../../../../widgets/global_appbar.dart';
import '../widgets/last_edit_text.dart';
import '../widgets/text_board_widget.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    String cleanHtml(String html) {
      return html.replaceAll(RegExp('font-feature-settings:[^;"]*;?'), '');
    }

    Widget? htmlContent(String? text) {
      if (text == null || text.isEmpty) {
        return const SizedBox.shrink();
      }
      try {
        final widget = Html(data: cleanHtml(text));

        return widget;
      } catch (e) {
        return const SizedBox.shrink();
      }
    }

    return Scaffold(
      backgroundColor: ColorConstants.scaffoldColor,
      appBar: GlobalAppbar(
        title: 'Məxfilik siyasəti',
        onLeadingTap: () {
          context.pop();
        },
      ),
      body: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<PrivacyPolicyCubit, PrivacyPolicyState>(
            builder: (_, state) {
              if (state.status == PrivacyPolicyStatus.loading) {
                return Center(
                  child: Center(
                    child: CustomCircularProgressIndicator(
                      isWhite: false,
                    ),
                  ),
                );
              }

              if (state.status == PrivacyPolicyStatus.failure) {
                return Center(
                  child: Text('Xəta'),
                );
              }

              if (state.status == PrivacyPolicyStatus.networkError) {
                return Center(
                  child: Text('Şəbəkə xətası'),
                );
              }

              if (state.status == PrivacyPolicyStatus.success) {
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
                              HeaderText(
                                  title:
                                      '“Anayam” internet portalı və mobil tətbiq üzrə Məxfilik Siyasəti'),
                              // LastEditText(
                              //   lastEditText:
                              //       result?.updatedAt?.toLocal().toString() ??
                              //           '',
                              // ),
                              htmlContent(result?.text ?? '') ??
                                  const SizedBox.shrink(),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../../data/models/local/profile_sections_items_model.dart';
import 'section_box.dart';

class ProfilePageSections extends StatelessWidget {
  const ProfilePageSections({super.key});

  @override
  Widget build(BuildContext context) {
    final profileSectionItems = ProfileSectionsItemsModel.items;
    return Column(
      spacing: 12,
      children: [
        for (int i = 0; i < profileSectionItems.length; i++)
          SectionBox(
            sectionicon: profileSectionItems[i].icon,
            sectionName: profileSectionItems[i].sectionName,
            onTap: () {
              if (i == 3) {
                String iosLink =
                    'https://apps.apple.com/az/app/anayam/id6740815265';
                String androidLink =
                    'https://play.google.com/store/apps/details?id=com.aastudio.anayam.app';
                SharePlus.instance.share(
                  ShareParams(
                    text:
                        'Anayam mobil tətbiqini cihazınıza quraşdırın. \n İos üçün keçid: $iosLink \n Android üçün keçid: $androidLink',
                  ),
                );
              } else {
                context.push(profileSectionItems[i].sectionRoute!);
              }
            },
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              profileSectionItems[i].sectionRoute != null
                  ? context.push(profileSectionItems[i].sectionRoute!)
                  : null;
            },
          ),
      ],
    );
  }
}

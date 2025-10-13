import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../../widgets/global_button.dart';

class DoctorRegisterButton extends StatelessWidget {
  const DoctorRegisterButton({
    super.key,
    required this.doctorId,
  });

  final int doctorId;

  @override
  Widget build(BuildContext context) {
    return GlobalButton(
      buttonName: 'Qeydiyyat',
      buttonColor: const Color(0xffFDECF2),
      textColor: ColorConstants.primaryRedColor,
      onPressed: () {
        // Navigator.of(rootNavigator: true, context).push(
        //   MaterialPageRoute(
        //     builder: (_) => BlocProvider(
        //       create: (context) =>
        //           locator<DoctorDetailCubit>()..getDoctorDetail(slug),
        //       child: RegistrationDoctorPage(),
        //     ),
        //   ),
        // );
        context.push('/doctor_register', extra: doctorId);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../utils/constants/color_constants.dart';
import '../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../widgets/global_text.dart';

class ScrollableDaysAppbar extends StatefulWidget {
  const ScrollableDaysAppbar({
    super.key,
    required this.appbarName,
    this.week,
    this.weekValue,
    this.isShowBackButton = true,
    this.count = 47,
  });

  final String appbarName;
  final int? week;
  final ValueNotifier<int?>? weekValue;
  final bool isShowBackButton;
  final int count;

  @override
  State<ScrollableDaysAppbar> createState() => _ScrollableDaysAppbarState();
}

class _ScrollableDaysAppbarState extends State<ScrollableDaysAppbar> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  void _scrollToCurrentWeek(int week) {
    final scrollPixel = 33 * week;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        scrollPixel.toDouble(),
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorConstants.primaryRedColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.statusBarTopHeight + 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  widget.isShowBackButton
                      ? GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: SizedBox(
                            width: 44,
                            height: 44,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_back_ios_new_rounded),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox(height: 44, width: 30),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: GlobalText(
                      text: widget.appbarName,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            38.h,
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 66,
                child: ValueListenableBuilder(
                  valueListenable: widget.weekValue ?? ValueNotifier<int>(0),
                  builder: (_, value, __) {
                    _scrollToCurrentWeek(value!);

                    return ListView.separated(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.count,
                      itemBuilder: (_, i) {
                        return i == value
                            ? SizedBox(
                                height: 65,
                                width: 42,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color(0xffBE3362),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: SizedBox(
                                          height: 28,
                                          width: 30,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GlobalText(
                                                  text: '$i',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      5.h,
                                      SizedBox(
                                        width: 4,
                                        height: 4,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: SizedBox(
                                  width: 28, // 25
                                  child: GlobalText(
                                    text: '$i',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 5);
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

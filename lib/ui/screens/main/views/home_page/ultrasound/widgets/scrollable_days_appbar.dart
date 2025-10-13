import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';

class ScrollableWeeksAppBar extends StatefulWidget {
  const ScrollableWeeksAppBar({
    super.key,
    required this.appbarName,
    // this.week,
    this.weekOrDayValue,
    this.isShowBackButton = true,
    this.count = 40,
    required this.scrollController,
    required this.onTap,
    this.isDailyAdvice = false,
  });

  final String appbarName;
  // final int? week;
  final ValueNotifier<int?>? weekOrDayValue;
  final bool isShowBackButton;
  final int count;
  final ScrollController? scrollController;
  final void Function(int weekOrDay) onTap;
  final bool isDailyAdvice;

  @override
  State<ScrollableWeeksAppBar> createState() => _ScrollableWeeksAppBarState();
}

class _ScrollableWeeksAppBarState extends State<ScrollableWeeksAppBar> {
  // late ScrollController _scrollController;
  @override
  void initState() {
    // widget.scrollController = ScrollController();
    super.initState();
  }

  void _scrollToCurrentWeek(int week) {
    final scrollPixel = widget.isDailyAdvice ? 37 * week : 33 * week;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.scrollController!.animateTo(
        scrollPixel.toDouble(),
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _scrollToCurrentWeek(widget.weekOrDayValue?.value ?? 0);

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
                child: ListView.separated(
                  controller: widget.scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.count,
                  itemBuilder: (_, i) {
                    return ValueListenableBuilder(
                      key: ValueKey(i),
                      valueListenable:
                          widget.weekOrDayValue ?? ValueNotifier<int>(0),
                      builder: (context, value, child) {
                        return Visibility(
                          visible: i != value,
                          replacement: SizedBox(
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
                                              fontSize: 14,
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
                          ),
                          child: GestureDetector(
                            key: ValueKey(value),
                            onTap: () {
                              // widget.weekValue.value = i;
                              widget.onTap(i);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: SizedBox(
                                width: widget.isDailyAdvice ? 32 : 28, // 25
                                child: GlobalText(
                                  text: '$i',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    // i == value
                    //     ? SizedBox(
                    //         height: 65,
                    //         width: 42,
                    //         child: DecoratedBox(
                    //           decoration: BoxDecoration(
                    //             color: Color(0xffBE3362),
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(25)),
                    //           ),
                    //           child: Column(
                    //             children: [
                    //               Padding(
                    //                 padding: const EdgeInsets.only(top: 12),
                    //                 child: SizedBox(
                    //                   height: 28,
                    //                   width: 30,
                    //                   child: DecoratedBox(
                    //                     decoration: BoxDecoration(
                    //                       color: Colors.white,
                    //                       shape: BoxShape.circle,
                    //                     ),
                    //                     child: Column(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.center,
                    //                       children: [
                    //                         GlobalText(
                    //                           text: '$i',
                    //                           fontSize: 16,
                    //                           fontWeight: FontWeight.w600,
                    //                           color: Colors.black,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               5.h,
                    //               SizedBox(
                    //                 width: 4,
                    //                 height: 4,
                    //                 child: DecoratedBox(
                    //                   decoration: BoxDecoration(
                    //                     color: Colors.orange,
                    //                     shape: BoxShape.circle,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       )
                    //     : GestureDetector(
                    //         key: ValueKey(value),
                    //         onTap: () {
                    //           log('tapped item: $i');
                    //           widget.weekValue?.value = i;
                    //         },
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(top: 12),
                    //           child: SizedBox(
                    //             width: 28, // 25
                    //             child: GlobalText(
                    //               text: '$i',
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w600,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 5);
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

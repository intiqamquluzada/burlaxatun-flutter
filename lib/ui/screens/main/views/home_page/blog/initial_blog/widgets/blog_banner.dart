import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../../../cubits/blog_sliders/blog_sliders_cubit.dart';
import '../../../../../../../../cubits/main_cubit/main_state.dart';
import '../../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../../../utils/extensions/context_extensions.dart';

class BlogBanner extends StatelessWidget {
  const BlogBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();

    return BlocBuilder<BlogSlidersCubit, BlogSlidersState>(
      builder: (context, state) {
        if (state.status == BlogSlidersStatus.loading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state.status == BlogSlidersStatus.failure) {
          return const Center(child: Text('Xəta'));
        } else if (state.status == BlogSlidersStatus.networkError) {
          return const Center(child: Text('Şəbəkə xətası'));
        } else if (state.status == BlogSlidersStatus.success) {
          final results = state.response?.results ?? [];

          return Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.bottomCenter,
            children: [
              BlocBuilder<MainCubit, MainInitial>(
                builder: (context, mainState) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      initialPage: mainState.carouselIndex,
                      viewportFraction: 1,
                      height: context.deviceHeight * 0.215,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        mainCubit.updateCarouselIndex(index);
                      },
                    ),
                    items: results.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                item.backgroundImage ?? '',
                                width: context.deviceWidth,
                                height: 173,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.error),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 30,
                                  horizontal: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 240,
                                      child: Text(
                                        item.topSentence ?? '',
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: ColorConstants.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(height: 3),
                                    Flexible(
                                      child: SizedBox(
                                        width: 200,
                                        child: Text(
                                          overflow: TextOverflow.fade,
                                          item.text ?? '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: ColorConstants.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              BlocBuilder<MainCubit, MainInitial>(
                buildWhen: (previous, current) =>
                    previous.carouselIndex != current.carouselIndex,
                builder: (context, state) {
                  return Positioned(
                    bottom: 20,
                    child: AnimatedSmoothIndicator(
                      activeIndex: state.carouselIndex,
                      count: results.length,
                      effect: CustomizableEffect(
                        spacing: 6,
                        dotDecoration: DotDecoration(
                          width: 8,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(19),
                        ),
                        activeDotDecoration: DotDecoration(
                          width: 16,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(19),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

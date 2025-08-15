import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:resta_dash/main.export.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannersSlider extends HookWidget {
  const BannersSlider({super.key, required this.banners});
  final List<PromoBanner> banners;
  @override
  Widget build(BuildContext context) {
    final index = useState(0);
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: banners.length,
          options: CarouselOptions(
            height: 140,
            viewportFraction: 1,
            autoPlay: true,
            onPageChanged: (i, _) => index.value = i,
          ),
          itemBuilder: (context, index, realIndex) {
            final banner = banners[index];
            return BannersCard(banner: banner);
          },
        ),
        const Gap(Insets.med),
        AnimatedSmoothIndicator(
          activeIndex: index.value,
          count: banners.length,
          effect: ExpandingDotsEffect(
            dotWidth: 8,
            dotHeight: 5,
            dotColor: context.colors.outline,
            activeDotColor: context.colors.primary,
          ),
        ),
      ],
    );
  }
}

class BannersCard extends StatelessWidget {
  const BannersCard({super.key, required this.banner});

  final PromoBanner banner;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Pads.sm('lr'),
      child: ClipRRect(
        borderRadius: Corners.smBorder,
        child: HostedImage(banner.imageUrl, width: context.width),
      ),
    );
  }
}

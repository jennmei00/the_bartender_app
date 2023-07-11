import 'package:card_swiper/card_swiper.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/enum.dart';
import 'package:the_bartender_app/utils/string_util.dart';

class AnimatedCarousel extends StatefulWidget {
  final Function onCarouselIndexChanged;
  const AnimatedCarousel({super.key, required this.onCarouselIndexChanged});
  

  @override
  State<AnimatedCarousel> createState() => _AnimatedCarouselState();
}

class _AnimatedCarouselState extends State<AnimatedCarousel> {
  int _carouselIndex = 0;
  final SwiperController _swiperController = SwiperController();

  @override
  void initState() {
    super.initState();
    _carouselIndex = (DrinkTypeEnum.values.length / 2).floor();
    _swiperController.index = (DrinkTypeEnum.values.length / 2).floor();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: 200,
            width: 400,
            child: Swiper(
              itemCount: DrinkTypeEnum.values.length,
              itemBuilder: (context, index) {
                final val = carouselList[index];
                return AnimatedOpacity(
                  opacity: index == _carouselIndex ? 1 : 0.4,
                  duration: const Duration(milliseconds: 200),
                  child: val,
                );
              },
              viewportFraction: 0.3,
              scale: 0.5,
              onIndexChanged: (value) {
                 widget.onCarouselIndexChanged(value);
                setState(() => _carouselIndex = value);
              },
              loop: false,
              controller: _swiperController,
            ),
          ),
        ),
        Center(
          child: SizedBox(
            height: 200,
            width: 250,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    CommunityMaterialIcons.chevron_left,
                    color: AppTheme.themeData.colorScheme.primary,
                  ),
                  iconSize: 80,
                  onPressed: () {
                    _swiperController.previous();
                  },
                ),
                IconButton(
                  icon: Icon(
                    CommunityMaterialIcons.chevron_right,
                    color: AppTheme.themeData.colorScheme.primary,
                  ),
                  iconSize: 80,
                  onPressed: () {
                    _swiperController.next();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> carouselList = DrinkTypeEnum.values
      .map(
        (val) => Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: 150,
              width: 100,
              child: SvgPicture.asset(
                'assets/svg/cocktail.svg',
                height: 200,
              ),
            ),
            Container(
              height: 160,
              width: 100,
              alignment: Alignment.bottomRight,
              child: Transform.rotate(
                angle: -0.60,
                child: Text(
                  capitalizeFirstLetter(val.name),
                  style: AppTheme.themeData.textTheme.titleMedium!
                      .copyWith(fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      )
      .toList();
}

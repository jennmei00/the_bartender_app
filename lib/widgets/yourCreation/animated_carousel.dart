import 'package:card_swiper/card_swiper.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_bartender_app/models/drink_type.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/id_util.dart';
import 'package:the_bartender_app/utils/string_util.dart';
import 'package:the_bartender_app/viewmodels/drink_type_view_model.dart';

class AnimatedCarousel extends StatefulWidget {
  final Function onCarouselIndexChanged;
  const AnimatedCarousel({super.key, required this.onCarouselIndexChanged});

  @override
  State<AnimatedCarousel> createState() => _AnimatedCarouselState();
}

class _AnimatedCarouselState extends State<AnimatedCarousel> {
  int _carouselIndex = 0;
  final SwiperController _swiperController = SwiperController();
  List<Widget> carouselList = [];
  List<DrinkType> drinkTypeList = [];

  @override
  void initState() {
    super.initState();
    drinkTypeList =
        Provider.of<DrinkTypeViewModel>(context, listen: false).drinkTypeList!;
    _carouselIndex = (drinkTypeList.length / 2).floor();
    _swiperController.index = (drinkTypeList.length / 2).floor();

    carouselList = drinkTypeList
        .map(
          (val) => Stack(
            children: [
              Container(
                alignment: Alignment.center,
                height: 150,
                width: 100,
                child: Image.asset(
                  drinkTypeToImagePath(val.id),
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            height: 200,
            width: 400,
            child: Swiper(
              itemCount: drinkTypeList.length,
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
}

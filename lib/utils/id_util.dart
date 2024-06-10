import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

String drinkTypeToImagePath(String id) {
  switch (id) {
    case '167292d1-d306-4281-a0e6-1444816c8d6d': //*Cocktail ID
      return 'assets/images/cocktail.png';
    case '6bf4c37a-337e-4626-a7c7-bfeb181b685b': //*Shot ID
      return 'assets/images/shot.png';
    default: //*Others
      return 'assets/images/other.png';
  }
}

Icon seasonToIcon(String id) {
  switch (id) {
    case '374b0c73-fec3-43ca-a579-ef46c04d8e4e': //*Summer ID
      return const Icon(CommunityMaterialIcons.weather_sunny);
    case 'ab9c1f59-0664-4277-9949-4cb3ac2d44ad': //*Winter ID
      return const Icon(CommunityMaterialIcons.snowflake);
    default: //*Others (All Season)
      return const Icon(CommunityMaterialIcons.weather_partly_snowy);
  }
}

Icon alcoholicToIcon(bool alcoholic) {
  return alcoholic
      ? const Icon(CommunityMaterialIcons.glass_cocktail)
      : const Icon(CommunityMaterialIcons.glass_cocktail_off);
}

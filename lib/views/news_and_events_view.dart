import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:the_bartender_app/res/style/app_theme.dart';
import 'package:the_bartender_app/utils/route_util.dart';
import 'package:the_bartender_app/widgets/custom_scaffold.dart';

class NewsAndEventsView extends StatelessWidget {
  const NewsAndEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      image: AppTheme.backgroundImage,
      appBar: true,
      title: Text('news_and_events'.i18n().toUpperCase()),
      drawerView: DrawerView.newsAndEvents,
      body: OrientationBuilder(builder: (context, orientation) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                Text(
                  'news'.i18n(),
                  style: AppTheme.themeData.textTheme.titleLarge!
                      .copyWith(decoration: TextDecoration.none),
                ),
                const Divider(),
                const SizedBox(height: 20.0),
                orientation == Orientation.portrait
                    ? const Column(
                        children: [
                          NewsOne(),
                          SizedBox(height: 30.0),
                          NewsTwo(),
                        ],
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(child: NewsOne()),
                            SizedBox(width: 30.0),
                            Expanded(child: NewsTwo()),
                          ],
                        ),
                      )
              ],
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                    'events'.i18n(),
                    style: AppTheme.themeData.textTheme.titleLarge!
                        .copyWith(decoration: TextDecoration.none),
                  ),
                  const Divider(),
                  const SizedBox(height: 20.0),
                  Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: AppTheme.recipeCardBoxDecoration,
                      child: Text(
                        "Unforgettable Events Await!\n\nJoin us for an array of captivating events that promise excitement, entertainment, and community. From art showcases to live music, culinary adventures to interactive workshops, there's something for everyone. Make memories, forge connections, and immerse yourself in a world of shared experiences. Stay tuned for updates – your next unforgettable moment is just around the corner!",
                        style: AppTheme.themeData.textTheme.displayMedium,
                      )),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class NewsOne extends StatelessWidget {
  const NewsOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        decoration: AppTheme.recipeCardBoxDecoration,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            children: [
              Text(
                'Why Cocktails are Important!',
                style: AppTheme.themeData.textTheme.titleMedium,
              ),
              Container(
                height: 220,
                padding: const EdgeInsets.all(20.0),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.grey, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text(
                    "Cocktails have transcended their status as mere beverages to become icons of celebration, relaxation, and creativity. Beyond the carefully measured mix of spirits, liqueurs, juices, and garnishes lies a concoction that represents more than just flavors; cocktails are a cultural phenomenon, a reflection of individual tastes, and a gateway to exploration.\n\nAt the heart of it, cocktails are important because they elevate our experiences. They transform ordinary moments into extraordinary memories. Think about the clinking of glasses during a toast, the colors and aromas that awaken our senses, and the shared laughter among friends. Cocktails have the remarkable ability to set the mood, whether it's a vibrant beachside party, an intimate date night, or a classy evening at a high-end lounge.\n\nCocktails are also an art form. Bartenders are akin to skilled artisans, crafting each drink with precision and creativity. The balance of flavors, the arrangement of garnishes, and even the choice of glassware contribute to a visual and gustatory masterpiece. This artistry has given birth to a wide array of classic and contemporary cocktails, each with its own story and cultural relevance.\n\nMoreover, cocktails invite exploration. They offer a world of possibilities, inviting us to discover new flavors, spirits, and combinations we might not have considered before. From the classics like the Martini and Old Fashioned to modern innovations that push the boundaries of mixology, cocktails provide a canvas for innovation and experimentation.\n\nCocktails are more than drinks; they're vessels of joy, conversation, and creativity. They remind us to savor the moment, celebrate life's victories, and bond with others over shared experiences. So, the next time you raise a glass and indulge in a beautifully crafted cocktail, remember that you're not just drinking; you're participating in a tradition that has woven itself into the tapestry of human culture, bringing people together and adding a touch of elegance and excitement to our lives.",
                    style:
                        AppTheme.themeData.textTheme.displayMedium!.copyWith(),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(CommunityMaterialIcons.account_edit_outline),
                      Text(
                        'the_bartender',
                        style: AppTheme.themeData.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Text(
                    'Read More ...',
                    style: AppTheme.themeData.textTheme.bodySmall,
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class NewsTwo extends StatelessWidget {
  const NewsTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        decoration: AppTheme.recipeCardBoxDecoration,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      'New Cocktail Variants!',
                      softWrap: true,
                      style: AppTheme.themeData.textTheme.titleMedium,
                    ),
                  ),
                  Image.asset(
                    'assets/images/cocktail.png',
                    height: 150,
                  ),
                ],
              ),
              Container(
                height: 220,
                padding: const EdgeInsets.all(20.0),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.grey, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text(
                    "Introducing New Cocktail Variants: Unleash Your Taste Buds!\n\nIn the ever-evolving world of mixology, where creativity knows no bounds, a tantalizing wave of innovation has arrived. Get ready to embark on a delightful journey through uncharted flavor territories with the introduction of our New Cocktail Variants. These avant-garde concoctions are meticulously crafted to awaken your senses, challenge your palate, and redefine your perception of what a cocktail can be.\n\nImmerse yourself in a symphony of ingredients that dance together in perfect harmony. Our mixologists have harnessed their passion and expertise to curate an array of cocktail variants that cater to both the daring and the discerning. From bold twists on timeless classics to entirely novel creations, these drinks are an ode to the art of experimentation.\n\nPicture sipping on a Lavender Lemonade Martini that combines the zing of citrus with the soothing aroma of lavender. Or, indulge in the Electric Blueberry Fizz, where blueberry-infused gin meets the effervescence of sparkling water, creating a visually striking and refreshingly tangy libation.\n\nFor those seeking a touch of nostalgia, our Raspberry Ripple Old Fashioned evokes memories of summer desserts with its fusion of raspberry liqueur and whiskey, garnished with a delicate swirl of raspberry syrup. And, of course, our Bold Espresso Negroni pays homage to coffee lovers by infusing the iconic cocktail with rich espresso notes, resulting in an invigorating twist on a beloved classic.\n\nThese New Cocktail Variants are not just drinks; they are conversations, experiences, and opportunities to redefine your taste preferences. Join us in raising a glass to innovation, to exploration, and to the endless possibilities that mixology offers. Whether you're a cocktail connoisseur or an adventurous newcomer, our variants invite you to embark on a sensory adventure that promises to captivate your senses and leave an indelible mark on your palate.\n\nDiscover the future of mixology – one sip at a time. Are you ready to experience the extraordinary? Welcome to the world of New Cocktail Variants.",
                    style:
                        AppTheme.themeData.textTheme.displayMedium!.copyWith(),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(CommunityMaterialIcons.account_edit_outline),
                      Text(
                        'the_bartender',
                        style: AppTheme.themeData.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Text(
                    'Read More ...',
                    style: AppTheme.themeData.textTheme.bodySmall,
                  )
                ],
              )
            ],
          ),
        ));
  }
}

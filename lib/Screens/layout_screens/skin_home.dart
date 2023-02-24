import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingapp/cubit/skin_cubit/skin_cubit.dart';
import 'package:shoppingapp/cubit/skin_cubit/skin_states.dart';
import 'package:shoppingapp/models/FeatureModel.dart';
import 'package:shoppingapp/shared/component.dart';
import 'package:shoppingapp/shared/constants.dart';
import 'package:shoppingapp/shared/styles/colors.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class SkinHome extends StatelessWidget {
  SkinHome({Key? key}) : super(key: key);

  //'Be Shine ! with Your ٍSuitable Skin Care Routine ' ,
//   'Treat Your Skin Now,Just Take A Photo For it' ,
//   'Try Your MakeUp' ,
  final urlBannerImages = [
    'assets/images/advice1.jpg',
    'assets/images/advice2.jpg',
    'assets/images/advice3.jpg',
    'assets/images/advice4.jpg',
  ];

  // final List<Widget> features = [
  //   buildVerticalPageItem(
  //     'https://img.freepik.com/free-vector/organic-cosmetics-abstract-concept-illustration_335657-5031.jpg?w=740&t=st=1676926459~exp=1676927059~hmac=70ce6846e5361f35bef14d9ece4513649e7d8af16154b980c7d6c4c1b36e96a4',
  //     'Let\'s Get\nYour Suitable\nSkin Care\nRoutine\n Honey ?',
  //   ),
  //   buildVerticalPageItem(
  //       'https://img.freepik.com/premium-vector/pretty-woman-taking-selfie-with-smartphone-smiling-illustration_619097-36.jpg?w=740',
  //       'Let\'s Discover\nYour Skin\nProblem\nTogether Now\nLet Me Be\nYour Doctor\nPretty ?'),
  //   buildVerticalPageItem(
  //     'https://img.freepik.com/free-vector/online-doctor-recommending-sunscreen-phone-screen-bottle-sunblock-tube-lotion-flat-illustration_74855-10970.jpg?w=996&t=st=1676933555~exp=1676934155~hmac=82a5f543495c372d1bd50459553348a7e3b2036d360f12e83655c24438b77825',
  //     'I haven\'t\nDecided Yet\nWhat is the\nFeature\nWill be There',
  //   ),
  // ];

  Widget buildImage(String urlImage, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        color: Colors.grey,
        child: Image.asset(
          urlImage,
          fit: BoxFit.cover,
          height: 100,
          width: double.infinity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (
        context,
      ) =>
          SkinCubit(),
      child: BlocConsumer<SkinCubit, SkinStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SkinCubit.get(context);

          return SafeArea(
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    itemCount: urlBannerImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final urlbannerImage = urlBannerImages[index];
                      return buildImage(urlbannerImage, index);
                    },
                    options: CarouselOptions(
                      height: 170.0,
                      initialPage: 0,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(
                        seconds: 3,
                      ),
                      autoPlayAnimationDuration: const Duration(
                        seconds: 1,
                      ),
                      autoPlayCurve: Curves.easeIn,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'HELLO Sweety..',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                              ),
                            ),
                            Icon(
                              Icons.waving_hand,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        Text(
                          '      Choose Service You Wanna Use ..',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                
                  Expanded(child: FeatureCarousel(),),

                  // Expanded(
                  //   child: VerticalCardPager(
                  //     titles: titles,
                  //     images: features,
                  //     initialPage: 1,
                  //     align: ALIGN.CENTER,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FeatureCarousel extends StatefulWidget {
  const FeatureCarousel({Key? key}) : super(key: key);

  @override
  State<FeatureCarousel> createState() => _FeatureCarouselState();
}

class _FeatureCarouselState extends State<FeatureCarousel> {
  PageController? _pageController;

  int initialPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: initialPage,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: KDefauktPadding,
      ),
      child: AspectRatio(
        aspectRatio: 0.98,
        child: PageView.builder(
          controller: _pageController,
          itemCount: features!.length,
          itemBuilder: (context, index) =>
              FeatureCard(feature: features![index]),
        ),
      ),
    );
  }
// When Using Animation
// Widget buildFeatureSliderAnimated(int index) {
//   return AnimatedBuilder(
//     animation:_pageController  as Listenable,
//     builder: (context, child) {
//       double value=0;
//       // if(_pageController!.position.haveDimensions){
//       //   value =index - _pageController.page;
//       //   value=(value * 0.038 ).clamp(-1,1) ;
//       // }
//       return FeatureCard(
//           feature: features![index]
//       );
//     },
//
//   );
// }
}

class FeatureCard extends StatelessWidget {
  FeatureCard({Key? key, required this.feature}) : super(key: key);
  final Feature feature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KDefauktPadding,
      ),
      child: Column(
        children: <Widget>
        [
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                boxShadow: [KDefaultShadow],
                image: DecorationImage(
                  image: AssetImage(
                    feature.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Text(
                feature.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w300,fontSize: 23 ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Container(
                  alignment: Alignment.center,
                 height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.circular(25,),
                  ),
                  child: Text('Getting Started',
                  style: TextStyle(
                    color: Colors.white ,
                    fontWeight: FontWeight.bold ,
                    fontSize: 20,
                  ),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

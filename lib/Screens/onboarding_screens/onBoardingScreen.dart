 import 'package:flutter/material.dart';
import 'package:shoppingapp/Screens/authentication_screens/skin_login_screen.dart';
import 'package:shoppingapp/network/local/cash_helper.dart';
import 'package:shoppingapp/shared/component.dart';
import 'package:shoppingapp/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel {
  final String? image;
  final String? title;
  final String? body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> Boarding = [
    BoardingModel(
      image: "assets/images/onboardSkin1.jpg",
      title: 'First',
      body: 'With US You Can Take Care About Your Skin By a Right Daily Routine',
    ),
    BoardingModel(
      image: "assets/images/onboardSkin2.jpg",
      title: 'Second',
      body: 'Just By Taking a Photo For Your Face .. We can Diagnose Your problems',
    ),
    BoardingModel(
      image: "assets/images/onboardSkin2.jpg",
      title: 'Third',
      body: 'Your Beauty Matters To Us',
    ),
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
          myDefaultTextButton(
              function: () {
               submit() ;
              },
              text: "skip" ,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == Boarding.length - 1) {
                    setState(() {
                      isLast = true;
                      // print("lastOne");
                    });
                  } else {
                    setState(() {
                      isLast = false;
                      //(print("Not Last"));
                    });
                  }
                },
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(Boarding[index]),
                itemCount: Boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: Boarding.length,
                  effect:  const ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                     submit() ;

                    } else {
                    boardController.nextPage(
                    duration: const Duration(
                    milliseconds: 750,
                    ),
                    curve: Curves.fastLinearToSlowEaseIn,
                    );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }


  void submit() {
    CashHelper.saveData(
      key:"onBoarding",
      value: true,
    ).then((value) {
      if (value==true) {
        navigateAndFinish(
          context: context,
          widget: SkinLoginScreen(),
        );
      }
    });
  }

  Widget buildBoardingItem(BoardingModel model) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage("${model.image}"),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text("${model.title}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 20.0,
          ),
          Text("${model.body}",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
        ],
      );
}

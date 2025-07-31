import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboarding1.png',
        title: 'Welcome to Salla!',
        body: 'Discover a wide range of products, tailored just for you. Your ultimate shopping experience starts here!'),
    BoardingModel(
        image: 'assets/images/onboarding2.png',
        title: 'Browse and Explore',
        body: 'Easily search through categories and find what you need in seconds. From daily essentials to special items, Salla has it all.'),
    BoardingModel(
        image: 'assets/images/onboarding3.png',
        title: 'Favorites and More',
        body: 'Save your favorite products for quick access anytime. Shop smart, shop effortlessly with Salla!'),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  setState(() {
                    isLast = index == boarding.length - 1;
                  });
                },
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 8,
                      expansionFactor: 4,
                      dotWidth: 8,
                      spacing: 3,
                      activeDotColor: defaultColor,
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {

                          CacheHelper.saveData(key: 'onboarding', value: true)
                              .then((value){
                            if(value!){
                              navigateAndFinish(context, LoginScreen());
                            }
                          });

                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: 180,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          onPressed: () {
                            if (isLast) {
                              CacheHelper.saveData(key: 'onboarding', value: true)
                                  .then((value){
                                if(value!){
                                  navigateAndFinish(context, LoginScreen());
                                }
                              });
                            } else {
                              boardController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn,
                              );
                            }
                          },
                          child: Text(
                            isLast ? 'Finish' : 'Next',
                            style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            child: Image(
              image: AssetImage(model.image),
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 40.0),
        Text(
          model.title,
          style: const TextStyle(
              fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            model.body,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
        const SizedBox(height: 30.0),
      ],
    ),
  );
}

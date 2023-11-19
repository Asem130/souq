import 'package:flutter/material.dart';
import 'package:revation/shared/componantes/componantes.dart';
import 'package:revation/shared/network/remote/shared_preference/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/login_screen.dart';

class BoardingModel {
  late final String title;
  late final String image;
  late final String body;
  BoardingModel({required this.title, required this.image, required this.body});
}

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool isLast=false;

  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'On Board 1 Title',
        image: 'assets/images/board1.png',
        body: 'Screen 1 body'),
    BoardingModel(
        title: 'On Board 2 Title',
        image: 'assets/images/board3.png',
        body: 'Screen 2 body'),
    BoardingModel(
        title: 'Login Now !',
        image: 'assets/images/board4.jpeg',
        body: 'Discounts up to 70%'),
  ];
  void submit()
  {

    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if (value)
        {
          navigateAndFinish(context, ShopLogin()) ;
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(onPressed: (){
            submit();
          }, child: Text('SKIP',)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if (index == boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });
                    }
                  else
                    {
                      setState(() {
                        isLast=false;
                      });
                    }
                },
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBordingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 3,
                      activeDotColor: Colors.deepOrange),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast)
                      {
                        submit();
                      }
                    else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }


                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBordingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              '${model.image}',
            ),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(

          '${model.body}',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );

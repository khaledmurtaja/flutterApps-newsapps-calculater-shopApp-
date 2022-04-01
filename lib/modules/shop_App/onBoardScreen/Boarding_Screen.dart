import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/modles/boardData.dart';
import 'package:untitled/modules/shop_App/shop_login_screen/shop_login.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/network/local/cash_helper.dart';
import 'package:untitled/shared/style/colors.dart';
class BoardingScreen extends StatelessWidget {

  var boardController = PageController();

  bool isLast=false;

  List<BoardData> data = [
    BoardData(
        imagePath: 'assets/images/onboard1.png',
        screenTitle: 'title 1',
        screenBody: 'body1'
    ),
    BoardData(
        imagePath: 'assets/images/onboard2.png',
        screenTitle: 'title 2',
        screenBody: 'body 2'
    ), BoardData(
        imagePath: 'assets/images/onboard3.png',
        screenTitle: 'title 3',
        screenBody: 'body 3'
    )
  ];
  void onSubmit(context){
    navigateAndReplace(context,ShopLogin());
    CashHelper.saveData(key: 'IsSkipped', value:true).
    then((value){
    }).catchError((error){
      print(error.toString());

    });

  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: AppBar(
            actions: [
              defTextButton(
                  function:(){
                    onSubmit(context);
                  }
                  , text: Text('SKIP')
              )
            ],
          ),
          body: PageView.builder(
            physics: BouncingScrollPhysics(),
            onPageChanged: (pageNum){
              if(pageNum==data.length-1){
                isLast=true;
              }else{
                isLast=false;
              }
            },
            controller: boardController,
            itemBuilder: (context, index) {
              return Build_BoardScreen(data[index], index,context);
            },
            itemCount: data.length,
          )
      );
  }

  Widget Build_BoardScreen(BoardData item, int index,context) =>
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: AssetImage(
                    '${item.imagePath}'

                ),
              ),
            ),
            Text(
              '${item.screenTitle}',
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${item.screenBody}',
              style: TextStyle(
                  fontSize: 15
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: data.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      radius: 20,
                      activeDotColor: defaultColor,
                      expansionFactor: 4,
                      dotHeight: 10,
                      dotWidth: 10
                    ),

                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast==true){
                      onSubmit(context);
                    }else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),

          ],
        ),
      );
}

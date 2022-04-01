import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/modles/shopApp/categoryData.dart';
import 'package:untitled/modles/shopApp/homeData.dart';
import 'package:untitled/modules/news_app/web_view/webViewScreen.dart';
import 'package:untitled/modules/shop_App/shopCubit/shop_cubit.dart';
import 'package:untitled/modules/shop_App/shop_login_screen/loginCubit/states.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/style/colors.dart';
//import 'package:connectivity_plus/connectivity_plus.dart';

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType inputType,
        required void Function(String) onsubmit,
        required void Function() ontap,
        required void Function(String) onchanged,
        required Color? color,
        required Icon prefix,
        IconButton? suffix,
        bool isPassword = false,
        String label = '',
        bool readOnly = false}) =>
    TextFormField(
      style: TextStyle(color: color),
      readOnly: readOnly,
      controller: controller,
      keyboardType: inputType,
      onFieldSubmitted: onsubmit,
      onTap: ontap,
      onChanged: onchanged,
      validator: (val) {
        if (val!.isEmpty) {
          return "$label is required";
        }
        return null;
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffix,
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
// bulild text button
Widget defTextButton({required Text text, required Function function}) =>
    TextButton(
        onPressed: () {
          function();
        },
        child: text);

// build_task_design
Widget buildTask(Map task, BuildContext context) => Dismissible(
      key: Key(task['id'].toString()),
      onDismissed: (direction) {
        myCubit.get(context).deleteRecordFromDatabase(task['id'], task);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                task['time'],
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              radius: 40,
              backgroundColor: Colors.blue,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    task['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    task['date'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              icon: Icon(Icons.check_box),
              color: Colors.green,
              onPressed: () {
                myCubit
                    .get(context)
                    .updateDatabase(id: task['id'], status: 'done');
              },
            ),
            IconButton(
              icon: Icon(Icons.archive),
              onPressed: () {
                myCubit
                    .get(context)
                    .updateDatabase(id: task['id'], status: 'archived');
              },
            ),
          ],
        ),
      ),
    );
Widget buildScreen(
    {required List<Map> tasks,
    required BuildContext context,
    required myCubit cubit}) {
  if (tasks.length == 0) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.menu,
            color: Colors.grey,
            size: 50,
          ),
          Text(
            'no tasks yet,please add some tasks',
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  } else {
    Map map = tasks[0];
    List list;
    if (map['status'] == 'new') {
      list = cubit.newTasks;
    } else if (map['status'] == 'archived') {
      list = cubit.archivedTasks;
    } else {
      list = cubit.doneTasks;
    }
    return ListView.separated(
        itemBuilder: (context, index) => buildTask(list[index], context),
        separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey,
            ),
        itemCount: list.length);
  }
}

Widget buildArticleItem(
    List<dynamic> articles, int itemIndex, BuildContext context) {
  return InkWell(
    onTap: () {
      navigateTo(context, webView(articles[itemIndex]['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage('${articles[itemIndex]['urlToImage']}'),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${articles[itemIndex]['title']}',
                      style: Theme.of(context).textTheme.headline1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${articles[itemIndex]['publishedAt']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildArticleScreen(context, List data, {isSearch = false}) {
  if (data.length == 0) {
    if (isSearch == true) {
      return Container();
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  } else {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(data, index, context),
        separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey,
            ),
        itemCount: data.length);
  }
}

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return widget;
  }));
}

void navigateAndReplace(context, widget) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
    return widget;
  }), (route) => false);
}

Widget CircleProgressIndicator() {
  return Center(child: CircularProgressIndicator());
}

Widget isLoading({required state, required widget}) {
  if (state is LoadingLogin) {
    return CircleProgressIndicator();
  } else {
    return widget;
  }
}

Widget isHomeLoading({required data,required MyCategories? categories,required ShopCubit cubit}) {
  if (data == null||categories==null) {
    return CircleProgressIndicator();
  } else {
    return ProductScreenBuilder(data,categories,cubit);
  }
}

Widget ProductScreenBuilder(HomeModel? model,MyCategories? categories,ShopCubit cubit) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data!.banners!
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                enableInfiniteScroll: false,
                autoPlay: true,
              )),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23

                  ),
                ),
                SizedBox(height: 15,),
                categoryListBuilder(categories!.generalData!.data),
                SizedBox(height: 15,),
                Text(
                  'New products',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23

                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1 / 1.59,
                mainAxisSpacing: 0.5,
                crossAxisSpacing: 0.5,
                crossAxisCount: 2,
                children: model.data!.products!
                    .map((e) => buildProductItem(e,cubit))
                    .toList()),
          )
        ],
      ),
    ),
  );
}

Widget buildProductItem(ProductModel model,ShopCubit cubit) {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: double.infinity,
              height: 175,
            ),
            if(model.discount!=0)
              Container(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            )

          ],
        ),
        //Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(),
              ),
             // Spacer(),
              Row(children: [
                Text(
                  '${model.price}',
                  style: TextStyle(color: defaultColor),
                ),
                SizedBox(
                  width: 5,
                ),
                if(model.discount!=0) Text(
                  '${model.oldPrice}',
                  style: TextStyle(
                      color: Colors.grey, decoration: TextDecoration.lineThrough),
                ),
                Spacer(),
                IconButton(
                  onPressed:(){
                    cubit.setFavourite(model);

                       //print("pressed");
                       //snippet of code
                  }
                  , icon: CircleAvatar(
                  backgroundColor:cubit.map[model.id]!?defaultColor:Colors.grey ,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                ),
                  ),
                  iconSize: 16,
                )
              ])
            ],
          ),
        )
      ],
    ),
  );
}

void ToastMaker({required String message, required Color color}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
Widget categoryItemBuilder(CategoriesSpecificData item){
  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        image: NetworkImage(
           '${item.image}'
        ),

      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(.7),
        child: Text(
          '${item.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis
          ,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold

          ),
        ),
      )
    ],

  );
}
Widget categoryListBuilder(List<CategoriesSpecificData> list){
  return Container(
    height: 110,
    child: ListView.separated(
      physics: BouncingScrollPhysics(),
        itemBuilder:(context,index){
          return categoryItemBuilder(list[index]);
        },
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      separatorBuilder: (context,index){
          return SizedBox(width: 9,);
      },
    ),
  );
}
Future<bool> checkInternetConnection({ShopCubit? cubit})async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else{
    return true;
  }

}

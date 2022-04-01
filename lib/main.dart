import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/bloc_observer.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/local/cash_helper.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';
import 'package:untitled/shared/style/themes.dart';
import 'layout/news_app/news_cubit/cubit.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/states.dart';
import 'modules/shop_App/ShopHomeScreen.dart';
import 'modules/shop_App/onBoardScreen/Boarding_Screen.dart';
import 'modules/shop_App/shopCubit/shop_cubit.dart';
import 'modules/shop_App/shop_login_screen/shop_login.dart';
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=c611d75366e04eb4a8874ddfcceb23f1
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget firstScreen;
  Bloc.observer=MyBlocObserver();
  dioHelper.inti();
  await CashHelper.init();
  if(CashHelper.Getdata('token')!=null){
    token=CashHelper.Getdata('token');
    firstScreen=ShopeHomeScreen();
  }else{
    if(CashHelper.Getdata('IsSkipped')==null) firstScreen=BoardingScreen();
    else firstScreen=ShopLogin();

  }
  runApp(MyApp(firstScreen));
}
class MyApp extends StatelessWidget {
  Widget? firstScreen;
  MyApp(this.firstScreen);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=>newsCubit()..getBusinessData()),
        BlocProvider(create: (context)=>myCubit()..handleSharedData(
            isdark: CashHelper.GetData('theme')
        )),
       BlocProvider(create: (context)=>ShopCubit()..GetHomeData()..getCategories()..getUserProfile())
      ],
      child: BlocConsumer<myCubit,MenuState>(
      listener: (context,newsCubit){},
      builder:(context,newsCubit){
        myCubit cubit=myCubit.get(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home:firstScreen,
          theme: themes.lightTheme,
          darkTheme: themes.DarkTheme,
          themeMode: cubit.isDark? ThemeMode.dark:ThemeMode.light,
        );
      } ,
      ),
    );
  }
}




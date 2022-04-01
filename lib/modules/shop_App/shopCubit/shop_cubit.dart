import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modles/shopApp/FavChange.dart';
import 'package:untitled/modles/shopApp/categoryData.dart';
import 'package:untitled/modles/shopApp/homeData.dart';
import 'package:untitled/modles/shopApp/logInData.dart';
import 'package:untitled/modules/shop_App/categoriesScreen/category_screen.dart';
import 'package:untitled/modules/shop_App/favoriteScreen/favorite_screen.dart';
import 'package:untitled/modules/shop_App/productScreen/product_screen.dart';
import 'package:untitled/modules/shop_App/settingsScreen/settings_screen.dart';
import 'package:untitled/modules/shop_App/shopCubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/EndPoints.dart';
import 'package:untitled/shared/network/local/cash_helper.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(InitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  HomeModel? homeModelData;
  MyCategories? categories;
  LoginData? userProfileData;
  List<BottomNavigationBarItem> navBarItems=[
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'home'

    ),
    BottomNavigationBarItem(
          icon: Icon(Icons.apps),
          label: 'Categories'
    ),
    BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'favorite'


    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings'
    ),
  ];
  List<Widget> navScreens=[
    ProductScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen()
  ];
  int navItemIndex=0;
  void changeNavItemIndex(int index){
    navItemIndex=index;
    emit(NavBarState());
  }
  Map<int?,bool?> map={};
  void GetHomeData(){
    emit(HomeModelLoading ());
    dioHelper.getData(
        url: Home,
      authorization:token
    ).then((value){
      homeModelData=HomeModel.fromJson(value.data);
      homeModelData!.data!.products!.forEach((element) {
        map.addAll({element.id:element.inFavorite

        });
      });
      CashHelper.firstRun=true;
      emit(HomeModelSuccess());
    }).catchError((error){
      CashHelper.firstRun=true;
      emit(HomeModelError());

    });
  }
  void getCategories(){
    emit( GetCategoriesLoading());
    dioHelper.getData(
        url: Categories,
      authorization: ""
    ).then((value){
     categories= MyCategories.fromJson(value.data);
      emit( GetCategoriesSuccess());
     print(categories!.status);

    }).catchError((error){
      emit( GetCategoriesError());
      print(error.toString());

    });
  }
  FavChange? favourite;
  void setFavourite(ProductModel model){
    map[model.id]=!map[model.id]!;
    emit(SetFavSuccess());
    dioHelper.postData(
        url: Fav,
        map:{
          'product_id':model.id
        },
      authorization: token
    ).then((value) {
      favourite=FavChange.fromJson(value.data);
      emit(SetFavSuccess());
      GetHomeData();
      if(favourite!.status==false){
        map[model.id]=!map[model.id]!;
        ToastMaker(
            color: Colors.red,
            message: "Something went wrong"
        );
      }

    }).catchError((onERROR){
     map[model.id]=!map[model.id]!;
      ToastMaker(
          color: Colors.red,
          message: "something went wrong"
      );
     emit(SetFavSError());
      print(onERROR.toString());
    });
  }
  void getUserProfile(){
    emit(GetProfileLoading());
    dioHelper.getData(
        url: PROFILE,
        authorization: token
    ).then((value){
      userProfileData= LoginData.fromJson(value.data);
      print(userProfileData!.data!.phone);
      emit( GetProfileSuccess());
    }).catchError((error){
      emit(GetProfileError());
      print(error.toString());
    });
  }
  void updateUserProfile({required String name,required String email,required String phone})async{
    emit(UpdateProfileLoading());
    dioHelper.putData(
        url: UPDATE_PROFILE,
        authorization: token,
        map: {
          'name':name,
          'email':email,
          'phone':phone
      }

    ).then((value){
      userProfileData= LoginData.fromJson(value.data);
      emit( UpdateProfileSuccess());
    }).catchError((error){
      emit(UpdateProfileError());
      print(error.toString());

    });
  }

  }




import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/news_cubit/states.dart';
import 'package:untitled/modules/news_app/business_screen/businessScreen.dart';
import 'package:untitled/modules/news_app/science_screen/scienceScreen.dart';
import 'package:untitled/modules/news_app/sports_screen/sportsScreen.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

class newsCubit extends Cubit<newsStates>{
  newsCubit() : super(initialState());
 static newsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<dynamic> business=[];
  List<dynamic> sports=[];
  List<dynamic> science=[];
  List<dynamic> searchedData=[];
  List<BottomNavigationBarItem> items=[
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'business'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'science'
    ),

  ];
  List<Widget> screens=[
    businessScreen(),
    sportScreen(),
    scienceScreen(),
  ];
  void changeIndex(int index){
    currentIndex=index;
    emit(bottomNavChange());
    if(index==1){
      getsportData();
    }else if(index==2){
      getScienceData();
    }
    getBusinessData();
  }
  void getBusinessData(){
    emit(getBusinessNewsloadingState());
    dioHelper.getData(
        url:'v2/top-headlines',
        map:{
          'country':'eg',
          'category':'business',
          'apiKey':'c611d75366e04eb4a8874ddfcceb23f1'
        }
    ).then((value){
     business=value.data['articles'];
      emit(getBusinessNewsSucess ());
    }).catchError((onError){
      print(onError.toString());
      print("erororoero");
      emit(getBusinessNewsError());
    });
  }
  void getsportData(){
    emit(getSportNewsloadingState());
    dioHelper.getData(
        url:'v2/top-headlines',
        map:{
          'country':'eg',
          'category':'sport',
          'apiKey':'c611d75366e04eb4a8874ddfcceb23f1'
        }
    ).then((value){
     sports=value.data['articles'];
      emit(getSportNewsSucess ());
    }).catchError((onError){
      print(onError.toString());
      print("erororoero");
      emit(getSportNewsError());
    });
  }
  void getScienceData(){
    emit(getscienceNewsloadingState());
    dioHelper.getData(
        url:'v2/top-headlines',
        map:{
          'country':'eg',
          'category':'science',
          'apiKey':'c611d75366e04eb4a8874ddfcceb23f1'
        }
    ).then((value){
      science=value.data['articles'];
      emit(getscienceNewsSucess ());
    }).catchError((onError){
      print(onError.toString());
      print("erororoero");
      emit(getscienceError());
    });
  }
  void getSearchedData(String ToSearch){
    dioHelper.getData(
        url: 'v2/everything',
        map: {
          'q':ToSearch,
          'apiKey':'c611d75366e04eb4a8874ddfcceb23f1'

        }
    ).then((value){
      searchedData=value.data['articles'];
      emit(getSearchedDataSucess());
    }
    ).catchError((onError){
      print(onError.toString());
      emit(getSearchedDataError());
    });

  }


}

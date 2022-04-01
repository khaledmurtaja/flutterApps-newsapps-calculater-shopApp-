import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modles/shopApp/searchModel.dart';
import 'package:untitled/modules/shop_App/searchScreen/SearchCubit/states.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/EndPoints.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';
class SearchCubit extends Cubit<SearchState>{
  SearchCubit() : super(InitialState());
  SearchModel? searchResult;
  static SearchCubit get(BuildContext context) => BlocProvider.of(context);
  void search(String searchFor){
    emit(LoadingSearch());
    dioHelper.postData(
        url: Search,
        map:{
          'text':searchFor
        },
        authorization: token
    ).then((value) {
      searchResult=SearchModel.fromJson(value.data);
      print(searchResult!.generalData!.list[1].price);
      emit(SuccessSearch());
    }).catchError((onERROR){
      emit(ErrorSearch());
      print(onERROR.toString());
    });
  }
}
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modles/shopApp/logInData.dart';
import 'package:untitled/modules/shop_App/shop_login_screen/loginCubit/states.dart';
import 'package:untitled/shared/network/EndPoints.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';
class LoginCubit extends Cubit<LoginState>{
  var isPasswordVisible=false;
  LoginData? data;
  LoginCubit() : super(InitialState());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  void logInToShop({
    required String email,
    required String password

 })
{
  emit(LoadingLogin());
    dioHelper.postData(
        url: Login,
        map:{
          'email':email,
          'password':password,
        },
      authorization: ""
    ).then((value) {
      data=LoginData.fromJson(value.data);
      emit(SuccessLogin(data));
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorLogin());

    });

  }
  void onClickRedEye(){
    isPasswordVisible=!isPasswordVisible;
    emit(PasswordIconClicked());
  }

}
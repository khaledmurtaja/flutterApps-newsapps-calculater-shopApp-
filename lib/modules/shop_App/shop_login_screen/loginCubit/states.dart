import 'package:untitled/modles/shopApp/logInData.dart';

abstract class LoginState{}
class InitialState extends LoginState{}
class LoadingLogin extends LoginState{}
class SuccessLogin extends LoginState{
  final LoginData? data;
  SuccessLogin(this.data);
}
class ErrorLogin extends LoginState{}
class PasswordIconClicked extends LoginState{}


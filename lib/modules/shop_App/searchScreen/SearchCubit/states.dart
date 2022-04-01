import 'package:untitled/modles/shopApp/logInData.dart';

abstract class SearchState{}
class InitialState extends SearchState{}
class LoadingSearch extends SearchState{}
class SuccessSearch extends SearchState{
 // final LoginData? data;
  //SuccessLogin(this.data);
}
class ErrorSearch extends SearchState{}



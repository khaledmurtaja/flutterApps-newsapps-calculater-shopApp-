import 'package:dio/dio.dart';

class dioHelper{
  static Dio? dio;
  static void inti(){
    dio= Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }
  static Future<Response>getData({required String url, dynamic map,String lang='en',String? authorization}) async {
    dio!.options.headers={
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization':authorization
    };
   return await dio!.get(url, queryParameters: map);

  }
  static Future<Response> postData({required String url,required dynamic map,String lang='en',String? authorization}) async {
    dio!.options.headers={
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization':authorization
    };

    return await dio!.post(url,data: map);


  }
  static Future<Response> putData({required String? authorization,String lang='en',required String url,required dynamic map})async{
    dio!.options.headers={
      'lang':lang,
      'Authorization':authorization,
      'Content-Type':'application/json'
    };
    return await dio!.put(
      url,
      data: map
    );




}
}

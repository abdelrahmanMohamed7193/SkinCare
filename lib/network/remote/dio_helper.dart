// import 'package:dio/dio.dart';
//
// class DioHelper{
//   static late Dio dio;
//   static init() {
//     dio = Dio(
//         BaseOptions(
//           baseUrl: 'https://student.valuxapps.com/api/'  ,
//           receiveDataWhenStatusError:true  ,
//
//         )
//     ) ;
//   }
//
//
//   static Future<Response> getData({
//     required String methodUrl ,
//     required Map<String,dynamic>? query,
//     String lang = "ar" ,
//     String? token  ,
//   }) async {
//     dio.options.headers= {
//       'Content-Type':'application/json' ,
//       "lang":lang,
//       "Authorization":token,
//     };
//     return await dio.get(
//       methodUrl ,
//       queryParameters: query ,
//     ) ;
//   }
//
//   static Future<Response> postData({
//     required String methodUrl ,
//      Map<String,dynamic>? query,
//     required Map<String,dynamic> data,
//     String lang ="ar",
//     String? token,
//   })async{
//     dio.options.headers=
//        {
//          'Content-Type':'application/json' ,
//          "lang":lang,
//         "Authorization":token?? "" ,
//       };
//    return await  dio.post(
//     methodUrl,
//       queryParameters: query ,
//       data: data ,
//     ) ;
//
//
// }
  
//}
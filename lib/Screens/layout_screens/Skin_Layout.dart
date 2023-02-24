//  import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shoppingapp/Screens/authentication_screens/skin_login_screen.dart';
// import 'package:shoppingapp/cubit/skin_cubit/skin_cubit.dart';
// import 'package:shoppingapp/cubit/skin_cubit/skin_states.dart';
// import 'package:shoppingapp/network/local/cash_helper.dart';
// import 'package:shoppingapp/shared/component.dart';
// import 'package:shoppingapp/shared/constants.dart';
// import 'package:shoppingapp/shared/styles/colors.dart';
//
// class SkinLayout extends StatelessWidget {
//   const SkinLayout({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SkinCubit,SkinStates>(
//       listener:(context ,state){
//
//       } ,
//       builder:(context ,state) {
//         return  Scaffold(
//
//           body: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Center(
//               child: Column(
//                 children: [
//                   Text(
//                     'Plaese Choose the Service You need From here :',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   myButton(
//                       text: "logout",
//                       onTap: () {
//                         CashHelper.removeData(key: 'uId').then((value) {
//                           if (value != null) {
//                             navigateAndFinish(
//                               context: context,
//                               widget: SkinLoginScreen(),
//                             );
//                             showToast(
//                                 text: 'تم تسجيل الخروج بنجاح ي معلم',
//                                 state: ToastStates.SUCCESS);
//                           }
//                         });
//                       })
//                 ],
//               ),
//             ),
//           ),
//         ) ;
//       }
//
//
//     );
//   }
// }

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shoppingapp/cubit/phone_auth_cubit/phone_auth_cubit.dart';
// import 'package:shoppingapp/cubit/phone_auth_cubit/phone_auth_states.dart';
// import 'package:shoppingapp/shared/component.dart';
// import 'package:shoppingapp/shared/styles/colors.dart';
//
// class SkinLayoutTest extends StatefulWidget {
//   SkinLayoutTest({Key? key}) : super(key: key);
//
//   @override
//   State<SkinLayoutTest> createState() => _SkinLayoutTestState();
// }
//
// class _SkinLayoutTestState extends State<SkinLayoutTest> {
//   int currentVisibleItemIndex = 0;
//
//   ScrollController? scrollController;
//
//   @override
//   void initState() {
//     scrollController = ScrollController();
//     scrollController!.addListener(scrollListenerWithCount);
//     super.initState;
//   }
//
//   final urlBannerImages = [
//     'https://img.freepik.com/premium-vector/health-care-isometric-concept_183044-79.jpg?w=996',
//     'https://img.freepik.com/free-vector/tiny-doctors-examining-huge-patients-face-before-surgery-plastic-surgeon-drawing-incision-lines-womans-face-preparing-esthetic-surgery-flat-vector-illustration-cosmetic-operation-concept_74855-22566.jpg?w=996&t=st=1676837865~exp=1676838465~hmac=013be6827f872c22dbc19eb3dd898ef87e79f26ea00be9cfbe513e10d8f806e4',
//     'https://img.freepik.com/free-vector/dermatologist-concept-dermatology-specialist-face-skin-acne-treatment-idea-beauty-health-skin-epidermis-scheme-vector-illustration-cartoon-style_613284-2649.jpg?w=996&t=st=1676837945~exp=1676838545~hmac=96fa4fa868841f93f67d15af270427b3b58de0f478139c2438ddee8ab09d4fb5',
//     'https://img.freepik.com/free-vector/skin-care-one-flat-page-web-design-with-contact-information-professional-make-up_1284-9001.jpg?w=740&t=st=1676839148~exp=1676839748~hmac=fe672cc51d3f41bb277515e2a57c7ed7528f8b4552f6b008e5eac334af9e56d7',
//     'https://img.freepik.com/premium-vector/beauty-stickers-collection-set-cartoon-style-flat-design-premium-vector_620595-37.jpg?w=996',
//   ];
//
//   Widget buildImage(String urlImage, int index) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 7),
//       child: Container(
//         color: Colors.grey,
//         child: Image.network(
//           urlImage,
//           fit: BoxFit.cover,
//           height: 100,
//           width: double.infinity,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color.fromARGB(195, 246, 248, 248),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CarouselSlider.builder(
//               itemCount: urlBannerImages.length,
//               itemBuilder: (context, index, realIndex) {
//                 final urlbannerImage = urlBannerImages[index];
//                 return buildImage(urlbannerImage, index);
//               },
//               options: CarouselOptions(
//                 height: 170.0,
//                 initialPage: 0,
//                 viewportFraction: 1.0,
//                 enableInfiniteScroll: true,
//                 reverse: false,
//                 autoPlay: true,
//                 autoPlayInterval: const Duration(
//                   seconds: 3,
//                 ),
//                 autoPlayAnimationDuration: const Duration(
//                   seconds: 1,
//                 ),
//                 autoPlayCurve: Curves.easeIn,
//                 scrollDirection: Axis.horizontal,
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return PrespectiveWidget(
//                     index,
//                     currentVisibleItemIndex,
//                   );
//                 },
//                 controller: scrollController,
//                 shrinkWrap: true,
//
//                 // Padding(
//                 //   padding: const EdgeInsets.all(6.0),
//                 //   child:
//                 //   Card(
//                 //     elevation: 20,
//                 //     clipBehavior: Clip.antiAliasWithSaveLayer,
//                 //     child: Stack(
//                 //       alignment: Alignment.bottomCenter,
//                 //       children: [
//                 //         const Image(
//                 //           image: NetworkImage(
//                 //               'https://img.freepik.com/free-vector/diverse-people-use-mobile-phone-vector-flat-illustration-multiracial-group-with-smartphones-girl-hijab-senior-adult-woman-young-characters-with-gadgets_107791-11590.jpg?w=996&t=st=1674931659~exp=1674932259~hmac=a76c6cc99f8c2b7565c7eb414c92a8c838777627dad497e8b18bbefa83d30e04'),
//                 //           fit: BoxFit.fill,
//                 //           height: 170.0,
//                 //           width: double.infinity,
//                 //         ),
//                 //         Text(
//                 //           'Communicate With Friends . . ',
//                 //           style: TextStyle(
//                 //             color: buildMaterialColor(defaultColor),
//                 //             fontWeight: FontWeight.bold,
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   //now we detect visible Item and change the scale of the item
//   void scrollListenerWithCount() {
//     int itemCount = 8 ;
//     double scrollOffset =scrollController!.position.pixels ;
//     double viewPortHeight =scrollController!.position.viewportDimension;
//   double scrollRange = scrollController!.position.maxScrollExtent-scrollController!.position.minScrollExtent;
//   int firstVisibleItemIndex=(scrollOffset/(scrollRange*viewPortHeight)*itemCount) ;
//   currentVisibleItemIndex= firstVisibleItemIndex;
//   setState(() {});
//
//
//   }
// }
//
// class PrespectiveWidget extends StatelessWidget {
//
//   PrespectiveWidget(
//     this.index,
//     this.currentVisibleItemIndex, {
//     Key? key,
//   }) : super(key: key);
//
//   int ?index ;
//   int ?currentVisibleItemIndex ;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 10.0),
//       child: AnimatedScale(
//         duration:Duration(microseconds:200,  ) ,
//         scale:index==currentVisibleItemIndex ?1:0.94  ,
//         child: Transform(
//           transform: Matrix4.identity()
//             ..setEntry(3, 2, -0.004)
//             ..rotateX(0.24),
//           alignment: Alignment.center,
//           child: Align(
//             heightFactor: 0.78,
//             alignment: Alignment.topCenter,
//             child: prespectiveItem(),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class prespectiveItem extends StatelessWidget {
//   const prespectiveItem({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         //shadow Widget
//         Container(
//           width: 300,
//           height: 250,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(40.0),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0xFF1059c6).withOpacity(
//                     0.15,
//                   ),
//                   blurRadius: 40.0,
//                   spreadRadius: 10.0,
//                   offset: Offset(0, 10),
//                 )
//               ]),
//         ),
//         //real Card Widget
//         Container(
//           width: 300,
//           height: 280,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(
//               Radius.circular(40.0),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

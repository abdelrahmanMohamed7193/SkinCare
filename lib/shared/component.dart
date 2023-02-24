import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingapp/shared/styles/colors.dart';

navigateAndFinish({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

navigateTo({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget myDefaultTextButton({
  required void Function()? function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

Widget myTextField({
  required IconData prefixIcon,
  required Function onTap,
  // required Function validator ,
  required String validateText,
  required Function onChanged,
  required TextEditingController controller,
  required String label,
  IconData? suffixIcon,
  Function? SuffixPressed,
  TextInputType? type,
  bool readonly = false,
  bool isPassword = false,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onTap: () {
          onTap();
        },
        decoration: InputDecoration(
          label: Text(label),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: IconButton(
            onPressed: () {
              SuffixPressed!();
            },
            icon: Icon(suffixIcon),
          ),
          border: const OutlineInputBorder(),
        ),
        readOnly: readonly,
        validator: (value) {
          if (value!.isEmpty) {
            return (validateText);
          }
        },
        obscureText: isPassword,
        onChanged: onChanged(),
        controller: controller,
        keyboardType: type,
      ),
    );

Widget myButton({
  required String text,
  required Function onTap,
  double? width = 90.0,
  double? height = 60.0,
}) =>
    GestureDetector(
      onTap: () {
        onTap();
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          width: width,
          height: height,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );

void showToast({
  required dynamic text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color ChooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

Widget buildVerticalPageItem(String image, String text) {
  return Column(
    children: [
      Card(
        elevation: 13.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                text,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Image(
                image: NetworkImage(image),
                fit: BoxFit.cover,
                height: 160,
                width: 110,
              ),
            ),
          ],
        ),

        // Stack(
        //   alignment: Alignment.bottomCenter,
        //   children: [
        //     Padding(
        //       padding:  EdgeInsets.only(bottom: 8.0),
        //       child: Align(
        //         alignment: Alignment.centerRight,
        //         child: Image(
        //           image: NetworkImage(image),
        //           fit: BoxFit.cover,
        //           height: 200.0,
        //           width: 160,),
        //       ),
        //     ),
        //     Align(
        //       alignment: Alignment.centerLeft,
        //       child: Padding(
        //         padding:  EdgeInsets.only(left: 8.0),
        //         child: Text(
        //           text,
        //           textAlign: TextAlign.start,
        //           style: TextStyle(
        //               color: Colors.black,
        //               fontSize: 15,
        //               fontWeight: FontWeight.bold,
        //               fontStyle: FontStyle.italic),
        //         ),
        //       ),
        //     ),
        //     InkWell(
        //       onTap: () {},
        //       child: Padding(
        //         padding: const EdgeInsets.only(bottom: 4.0),
        //         child: Container(
        //           margin: EdgeInsets.all(5.0),
        //           width: 70,
        //           height: 40,
        //           decoration: BoxDecoration(
        //             color: defaultColor,
        //             borderRadius: BorderRadius.circular(30),
        //           ),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Text(
        //                 'Let\'s GO',
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 11,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //               Icon(
        //                 Icons.arrow_right_alt,
        //                 color: Colors.white,
        //                 size: 25.0,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    ],
  );
}

// Widget buildCardFeature(String image, String text){
//   return Card(
//     elevation: 13.0,
//     clipBehavior: Clip.antiAliasWithSaveLayer,
//     child: Image(
//       image: NetworkImage(
//       image ,
//       fit: BoxFit,
//       height: 200.0,
//       width: double.infinity,
//     ),
//
//   ) ;
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void navigateAndFinish(context,Widget)=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Widget), (route) => false);
void navigateTo(context,Widget)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Widget));
Widget defualtTextForm(
{
  required TextEditingController  controller,
  required  Function  ? validation,
  required  TextInputType keboardType,
  required  String  lable,
  required  IconData prefix,

}
    )=>TextFormField(
  controller: controller,
  validator: (s){
     validation!(s);
  },
  keyboardType: keboardType,
  decoration: InputDecoration(
    labelText: lable,
    prefixIcon: Icon(prefix),
  ),

);

Future<bool?> ToastShow(String text,ToastStates  state) => Fluttertoast.showToast(
msg:text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.TOP,
timeInSecForIosWeb: 5,
backgroundColor:chooseColor(state),
textColor: Colors.white,
fontSize: 16);
enum  ToastStates {SUCCESS,ERROR,WARING}

Color ? chooseColor(ToastStates state)
{
  Color? color;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color=  Colors.green;
      break;
    case ToastStates.ERROR:
      color=   Colors.red;
      break;
    case ToastStates.WARING:
      color=   Colors.amber;
      break;
  }
  return color;

}




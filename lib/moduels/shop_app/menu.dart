import 'package:flutter/material.dart';

import '../../shared/constants/constants.dart';

class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: TextButton(onPressed: (){
        SingOut(context);

      } ,child: Text('SIGN OUT'),),
    );
  }
}

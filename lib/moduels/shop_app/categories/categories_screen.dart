
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revation/layout/shop_layout/cubit/cubit.dart';
import 'package:revation/layout/shop_layout/cubit/states.dart';
import 'package:revation/models/catedories_model.dart';
import 'package:revation/moduels/shop_app/login/cubit/cubit.dart';


class  CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
    listener: (context,state){

    },
      builder: (context,state)
      {
        return ListView.separated(
            itemBuilder: (context,index)=>buildCatItem(HomeCubit.get(context).categoryModel!.data!.data[index]),
            separatorBuilder: (context,index)=>Container(
              width: double.infinity,
              height: 1,
            ),
            itemCount:HomeCubit.get(context).categoryModel!.data!.data.length,
        );
      },
    );
  }

}
Widget buildCatItem(DataModel model )=>Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Row(

    children: [

      Image(

        image: NetworkImage(model.image!),

        fit:BoxFit.cover,

        width: 100,

        height: 100,

      ),

      SizedBox(

        width: 20,

      ),

      Text(model.name!,

        style: TextStyle(

          fontWeight: FontWeight.bold,

          fontSize: 18,

        ),

      ),

      Spacer(),

      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),



    ],

  ),
);
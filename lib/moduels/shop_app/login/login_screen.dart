import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:revation/layout/shop_layout/shop_layout.dart';
import 'package:revation/moduels/shop_app/register/register.dart';
import 'package:revation/shared/componantes/componantes.dart';
import 'package:revation/shared/network/remote/shared_preference/cache_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLogin extends StatelessWidget {
  var emailController = TextEditingController();
  var passwardController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if (state is SuccsessState)
            {
              if(state.loginModel.status==true)
                {
            CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value)
            {
              navigateAndFinish(context, ShopLayout());
            });

                }
              else
                {
                         ToastShow(state.loginModel.message!, ToastStates.ERROR);

                }

            }
        },
        builder: (context, state) {
          return Scaffold(

            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics:BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/login.jpg')),
                          ),
                        ),
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Login now to browse our hot offers !',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email must be not empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18)),
                            labelText: 'Email Adress',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passwardController,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Passward must be not empty';
                            } else {
                              print(passwardController.text);
                            }
                            ;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate())
                              ShopCubit.get(context).userLogin(
                                  email: emailController.text,
                                  passward: passwardController.text);
                          },
                          obscureText: ShopCubit.get(context).isPassward,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18)),
                            labelText: 'Passward',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  ShopCubit.get(context).changeSuffix();
                                },
                                icon: Icon(
                                  ShopCubit.get(context).suffix,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! LodingState,
                            builder: (context) => Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.deepOrange,
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate())
                                    ShopCubit.get(context).userLogin(
                                      email: emailController.text,
                                      passward: passwardController.text,
                                    );
                                },
                                child: Text(
                                  'LOGIN'.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            fallback: (context) => CircularProgressIndicator(),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  navigateTo(context, Register());
                                },
                                child: Text('Register now'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

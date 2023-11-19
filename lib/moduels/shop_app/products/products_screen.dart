import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revation/layout/shop_layout/cubit/cubit.dart';
import 'package:revation/layout/shop_layout/cubit/states.dart';
import 'package:revation/models/catedories_model.dart';
import 'package:revation/models/home_model.dart';
import 'package:revation/moduels/shop_app/login/cubit/cubit.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: HomeCubit.get(context).homeModel != null &&
                HomeCubit.get(context).categoryModel != null,
            builder: (Context) => productsBuilder(
                HomeCubit.get(context).homeModel!,
              HomeCubit.get(context).categoryModel!,context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel,context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CarouselSlider(
          items: model.data.banners
              .map(
                (e) => Image(
                  image: NetworkImage('${e.image}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
              .toList(),
          options: CarouselOptions(
              height: 250,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoriesModel.data!.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                    itemCount: categoriesModel.data!.data.length),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'New Products',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.grey[200],
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1.0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 1 / 1.56,
            children: List.generate(model.data.products.length,
                (index) => buildGridProduct(model.data.products[index],context)),
          ),
        )
      ]),
    );

Widget buildCategoryItem(DataModel model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image!),
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
        Container(
          width: 100,
          color: Colors.black87.withOpacity(0.8),
          child: Text(
            model.name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );

Widget buildGridProduct(ProductsModel model,context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  style: TextStyle(height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor: HomeCubit.get(context).favorites[model.id]!? Colors.deepOrange:Colors.grey,
                      child: IconButton(
                          onPressed: () {
                            HomeCubit.get(context).getFavotites(model.id!);
                          },
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

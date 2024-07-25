import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_app_api/models/categories_news_model.dart';

import '../view_model/news_view_model.dart';


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String categoryName = "General";
  final newVievmodel = NewsViewModel();
  final format = DateFormat("MMMM dd, yyyy");

  List<String> categoriesList =[
    "General",
    "Entertainment",
    "Health",
    "Sports",
    "Business",
    "Technology"

  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width* 1;
    final height = MediaQuery.sizeOf(context).height* 1;
    return Scaffold(
   appBar: AppBar(),

      body: Column(

        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(

            scrollDirection: Axis.horizontal,
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return Padding(
                   padding: EdgeInsets.all(3),
                  child: InkWell(
                    onTap: (){
                      categoryName = categoriesList[index];
                      setState(() {

                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: categoryName== categoriesList[index] ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(child: Text(categoriesList[index].toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)),
                    ),
                  ),
                );
              },),
          ),
          SizedBox(height: 20,),
          Expanded(

            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: FutureBuilder<CategoriesNewModel>(
                  future: newVievmodel.fetchCategoriesNewspi(categoryName),
                  builder: (BuildContext context, snapshot) {
                    if(snapshot.connectionState== ConnectionState.waiting){

                      return Center(
                        child: SpinKitCircle(
                          color: Colors.amberAccent,
                        ),
                      );
                    }else {

                      return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          DateTime datTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    height: height * .18,
                                    width: width*.3,
                                    errorWidget:(context, url, error) => Icon(Icons.error, color: Colors.red,),
                                    placeholder: (context , ur ) => Center(
                                      child: SpinKitCircle(
                                        color: Colors.amberAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(child: Container(
                                  height: height*.18,
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data!.articles![index].title.toString(), style: TextStyle(fontWeight: FontWeight.w500),),

                                    ],
                                  ),
                                ))
                              ],
                            ),
                          );

                        },);
                    }

                  }

              ),
            ),
          ),
        ],
      ),
    );
  }
}

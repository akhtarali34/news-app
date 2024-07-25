import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_api/models/news_channels_headlines_model.dart';
import 'package:news_app_api/ui/categories_screen.dart';
import 'package:news_app_api/view_model/news_view_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum NewsFilterList  { aryNewa , bbcNews, aljazeera, independent }


class _HomeScreenState extends State<HomeScreen> {
  NewsFilterList? selectedMenue ;
  String name = "bbc-news";
  final newVievmodel = NewsViewModel();
  final format = DateFormat("MMMM dd, yyyy");

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.sizeOf(context).width* 1;
    final height = MediaQuery.sizeOf(context).height* 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News", style: GoogleFonts.poppins(),),
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const CategoriesScreen()));
          },
          icon: Image.asset("images/category_icon.png", height: 30, width: 30,),
        ),
        actions: [
          PopupMenuButton<NewsFilterList>(
            initialValue: selectedMenue,
            onSelected: (NewsFilterList item){
              if(NewsFilterList.bbcNews.name == item.name){
                name = "bbc-news";
              }
              if(NewsFilterList.aryNewa.name == item.name){
                name = "ary-news";
              }
              if(NewsFilterList.aljazeera.name == item.name){
                name = "al-jazeera-english";
              }

              setState(() {

              });
            },
            itemBuilder: (context) => <PopupMenuEntry<NewsFilterList>>[
              PopupMenuItem(
                value: NewsFilterList.bbcNews,
                  child: Text("BBC News")),

              PopupMenuItem(
                  value: NewsFilterList.aljazeera,
                  child: Text("Aljazeera")),


              PopupMenuItem(
                  value: NewsFilterList.aryNewa,
                  child: Text("ARY")),

              PopupMenuItem(
                  value: NewsFilterList.aryNewa,
                  child: Text("ARY"))
            ] ,
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height*.55,
            child:FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newVievmodel.fatchNewChannelsHeadlinesapi(name),
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
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    DateTime datTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                    return SizedBox(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                           height: height * .6 ,
                            width: width * .9,
                            padding: EdgeInsets.symmetric(horizontal: height* .02),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                
                                imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                fit: BoxFit.cover,
                                 errorWidget:(context, url, error) => Icon(Icons.error, color: Colors.red,),
                                placeholder: (context , ur ) => Center(
                                  child: SpinKitCircle(
                                    color: Colors.amberAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,

                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                alignment: Alignment.bottomCenter,
                                height: height*0.22,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width*0.7,


                                      child: Text(snapshot.data!.articles![index].title.toString() ,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                                        //style: //GoogleFonts.poppins(),

                                      ),),
                                    Spacer(),
                                     Container(
                                       width: width*0.7,
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text(snapshot.data!.articles![index].source!.name.toString(),maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                                           Text(format.format(datTime),maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),

                                         ],
                                       ),
                                     )

                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );

                  },);
               }

              }

            ),
          ),
        ],
      )
    );
  }
}


import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_api/models/categories_news_model.dart';
import 'package:news_app_api/models/news_channels_headlines_model.dart';
class NewsRepository{
  //categories
  Future<CategoriesNewModel> fetchCategoriesNewspi(String category) async{
    String url = "https://newsapi.org/v2/everything?q=${category}&apiKey=56b1955496964f09a437b952c60f317a";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewModel.fromJson(body);
    }else{
      throw Exception("Error");
    }
  }





//headlines
  Future<NewsChannelsHeadlinesModel> fatchNewChannelsHeadlinesapi(String channelName) async{
    String url = "https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=56b1955496964f09a437b952c60f317a";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }else{
      throw Exception("Error");
    }
  }
}
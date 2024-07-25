import 'package:news_app_api/models/categories_news_model.dart';
import 'package:news_app_api/models/news_channels_headlines_model.dart';
import 'package:news_app_api/repos/newa_repository.dart';

class NewsViewModel{

  final _repo = NewsRepository();


      Future<NewsChannelsHeadlinesModel> fatchNewChannelsHeadlinesapi (String channelName) async{
       final response = _repo.fatchNewChannelsHeadlinesapi(channelName);

       return response;
      }


  Future<CategoriesNewModel> fetchCategoriesNewspi(String channelName) async{
    final response = _repo.fetchCategoriesNewspi(channelName);

    return response;
  }

}
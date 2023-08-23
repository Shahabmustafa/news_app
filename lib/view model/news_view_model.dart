import 'package:flutter/cupertino.dart';
import 'package:news_app/Model/catoegori_news_model.dart';
import 'package:news_app/repository/new_repository.dart';
import '../Model/new_channel_headlines_model.dart';

class NewsViewModel{
  final _rep = NewsRepository();

  Future<NewChannelHeadLinesModel> fetchNewChannelHeadLinesApi(BuildContext context,String channelName)async{
    final response = await _rep.fetchNewChannelHeadLinesApi(context,channelName);
    return response;
  }

  Future<CategoriNewsModel> fetchCategoriNewsApi(BuildContext context,String channelName)async{
    final response = await _rep.fetchCategoriNewsApi(context,channelName);
    return response;
  }

}
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/catoegori_news_model.dart';
import '../Model/new_channel_headlines_model.dart';

class NewsRepository{

  Future<NewChannelHeadLinesModel> fetchNewChannelHeadLinesApi(BuildContext context,String channelName)async{
    String url = "https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=dd0a1364d718435c8c6744f85b2ee45f";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewChannelHeadLinesModel.fromJson(body);
    }
    throw Exception("Error");
  }

  Future<CategoriNewsModel> fetchCategoriNewsApi(BuildContext context,String category)async{
    String url = "https://newsapi.org/v2/everything?q=${category}&apiKey=dd0a1364d718435c8c6744f85b2ee45f";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriNewsModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
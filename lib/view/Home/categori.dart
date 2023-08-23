import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Model/catoegori_news_model.dart';
import 'package:news_app/view/Home/home.dart';

import '../../view model/news_view_model.dart';
import 'detail.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final newsViewModelApi = NewsViewModel();
  final format = DateFormat("MMMM dd,yyyy");
  String Category = "general";
  List<String> typeOfCategory = [
    "General",
    "Entertainment",
    "Health",
    "Sports",
    "Business",
    "Technology",
  ];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: typeOfCategory.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      Category = typeOfCategory[index];
                      setState(() {

                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Category == typeOfCategory[index].toString() ? Colors.black : Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(
                              child: Text(
                                  typeOfCategory[index].toString(),
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.white
                                ),
                              ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
          Expanded(
            child: FutureBuilder<CategoriNewsModel>(
                future: newsViewModelApi.fetchCategoriNewsApi(context,Category),
                builder: (BuildContext context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return SpinKitCircle(
                      color: Colors.black,
                    );
                  }else{
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
                                id: snapshot.data!.articles![index].source!.id,
                                newsName: snapshot.data!.articles![index].source!.name,
                                title: snapshot.data!.articles![index].title,
                                publishedAt: format.format(dateTime),
                                urlToImage: snapshot.data!.articles![index].urlToImage,
                                author: snapshot.data!.articles![index].author,
                                content: snapshot.data!.articles![index].content,
                                description: snapshot.data!.articles![index].description,
                              )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      height: height * 0.25,
                                      width: width * 0.35,
                                      placeholder: (context,url) => Container(child: spinKit2,),
                                      errorWidget: (context,url,error) => Icon(Icons.error_outline,color: Colors.red,),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Container(
                                        height: height * 0.23,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(snapshot.data!.articles![index].title.toString(),style: GoogleFonts.aBeeZee(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(snapshot.data!.articles![index].source!.name.toString()),
                                                Flexible(child: Text(format.format(dateTime))),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitCircle(
  color: Colors.black,
  size: 40,
);
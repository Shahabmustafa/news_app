import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  DetailPage({
    Key? key,
     this.urlToImage,
    this.title,
    this.description,
    this.publishedAt,
    this.content,
    this.newsName,
    this.author,
    this.id,
  }) : super(key: key);

  String? urlToImage;
  String? title;
  String? description;
  String? publishedAt;
  String? content;
  String? newsName;
  String? author;
  String? id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.newsName.toString()),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: widget.urlToImage.toString(),
            fit: BoxFit.cover,
            height: height * 0.4,
            width: width,
            placeholder: (context,url) => Container(child: spinKit2,),
            errorWidget: (context,url,error) => Icon(Icons.error_outline,color: Colors.red,),
          ),
         Column(
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Flexible(
                   child: ListTile(
                     title: Text("Author"),
                     subtitle: Text(widget.author.toString(),style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 20),),
                   ),
                 ),
                 Flexible(
                   child: ListTile(
                     title: Text("Publish"),
                     subtitle: Text(widget.publishedAt.toString(),
                       style: GoogleFonts.aBeeZee(
                         fontWeight: FontWeight.w900,
                         fontSize: 20,
                       ),
                     ),
                   ),
                 ),
               ],
             ),
             SizedBox(
               height: height * 0.02,
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child: Text(widget.title.toString(),
                 style: GoogleFonts.aBeeZee(
                     fontWeight: FontWeight.w900,
                     fontSize: 25
                 ),),
             ),
             SizedBox(
               height: height * 0.01,
             ),
             ListTile(
               title: Text("Description",style: GoogleFonts.aBeeZee(
                 fontWeight: FontWeight.bold,
               ),),
               subtitle: Text(widget.description.toString(),
                 style: GoogleFonts.aBeeZee(
                   color: Colors.black
                 ),
               ),
             ),
           ],
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

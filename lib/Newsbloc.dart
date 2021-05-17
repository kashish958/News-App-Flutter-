
import 'dart:async';
import 'package:flutter/material.dart';

import 'newsmodel.dart';
import 'package:http/http.dart' as http ;

import 'dart:convert';
enum newsaction {
  fetch
}

class NewsBloc{

 final statestream = StreamController<List<Article>>();
// this is for list of articles
  StreamSink<List<Article>> get newsinput => statestream.sink;
  Stream<List<Article>>get newsoutput => statestream.stream;


  //this is for checking the fetch operation
  final eventstream =  StreamController<newsaction>();

  StreamSink <newsaction> get eventinput => eventstream.sink;
  Stream <newsaction>get eventoutput => eventstream.stream;

 var newsModel;

NewsBloc() {
eventoutput.listen((event) async{
// yhe event listen krne k liye kiya//

    if(event == newsaction.fetch) {
  try{
    if(newsModel!= null)

    newsinput.add(newsModel.articles);
    else
      newsinput.addError("Something is twrong");

    }
   on Exception catch (e) {
     newsinput.addError("Something is wrong");
   }
  }
}
);
 }

 //getting response in this function
getNews(String category) async {


     // var response = await get
      var response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=aeff9545dbe241c19d28b1002d70b0e3'));
    //print(response.body);

      if (response.statusCode == 200) {

        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
   print("hii");

       // print(newsModel);

    }



    return newsModel;
  }





void dispose(){
  statestream.close();
      eventstream.close();


}

}


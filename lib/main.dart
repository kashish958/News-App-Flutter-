import 'Newsbloc.dart';
import 'newsmodel.dart';
import 'package:flutter/material.dart';
import 'package:demo1/Webview.dart';
//import 'Newsbloc.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget titleapp = Text("News App");
  //Categorynews cn = Categorynews();

  Icon actionicon = Icon(Icons.search);
  NewsBloc nb = NewsBloc();
  bool issearch = false;
  var filternews;
  var article;
  var a;

  @override
  void dispose() {
    nb.dispose();
    super.dispose();
  }

  @override
  void initState() {
//Jese hi page itialize ho tab fecth ho jae

    // nb.eventinput.add(newsaction.fetch);
    nb.getNews("entertainment");

    super.initState();
  }

  //var y = find(value);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: titleapp,
          actions: <Widget>[

            IconButton(
                icon: actionicon,
                onPressed: () {
                  setState(() {
                    this.issearch = true;
                    this.titleapp = TextField(
                      // TextField (
                      onChanged: (value) {
                        setState(() {
                          a = value;
                        });
                      },

                      //)

                      decoration: InputDecoration(
                          hintText: "find any news",
                          hintStyle: TextStyle(color: Colors.white)),
                    );
                  });
                }
                )
          ],


        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text("Categories"),
                decoration: BoxDecoration(color: Colors.black26),
              ),
              ListTile(
                title: Text("Entertainment"),
                leading: Image.network(
                    'https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80'),
                onTap: () {
                  nb.getNews("entertainment");
                  nb.eventinput.add(newsaction.fetch);
                },
              ),
              SizedBox(height: 30),
              ListTile(
                title: Text("Technology"),
                leading: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_rbqRlg_dukeGDrtkk3R5Lfb_wsjjxd7how&usqp=CAU"),
                onTap: () {
                  nb.getNews("science");
                  nb.eventinput.add(newsaction.fetch);
                },
              ),
              SizedBox(height: 30),
              ListTile(
                title: Text("Sports"),
                leading: Image.network(
                    "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80"),
                onTap: () {
                  nb.getNews("sports");
                  nb.eventinput.add(newsaction.fetch);
                },
              ),
              SizedBox(height: 30),
              ListTile(
                title: Text("Business"),
                leading: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHxTjm-GuQ-mmukBwfTlD7a_Lvy8nvQtKG9g&usqp=CAU"),
                onTap: () {
                  nb.getNews("business");
                  nb.eventinput.add(newsaction.fetch);
                },
              ),
              SizedBox(height: 30),
              ListTile(
                title: Text("Political"),
                leading: Image.asset("assets/pol.jpg"),
                onTap: () {
                  nb.getNews("politics");
                  nb.eventinput.add(newsaction.fetch);
                },
              ),
              SizedBox(height: 30),
              ListTile(
                title: Text("Health"),
                leading: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXmC4RxEvjJD-ynTIKXfDT5EJTF_tyLfd-WQ&usqp=CAU"),
                onTap: () {
                  nb.getNews("health");
                  nb.eventinput.add(newsaction.fetch);
                },
              ),
            ],
          ),
        ),
        body: StreamBuilder<List<Article>>(
          stream: nb.newsoutput,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              print("jhfo");
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    article = snapshot.data[index];

                    if (issearch && a != null) {
                      print(a);
                      //find(value);

                      //  if(article.title.contains("rahul"))

                      filternews = snapshot.data;
                      if (filternews[index]
                          .title
                          .toLowerCase()
                          .contains(a.toLowerCase()))
                        //   filternews = article;

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      View(Url: filternews[index].url)),
                            );
                          },
                          child: Container(
                            height: 100,
                            //padding: EdgeInsets.symmetric(horizontal: 12),

                            margin: const EdgeInsets.all(8),
                            child: Row(children: <Widget>[
                              Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: AspectRatio(
                                  child: Image.network(
                                    filternews[index].urlToImage,
                                    fit: BoxFit.cover,
                                  ),
                                  aspectRatio: 1,
                                ),
                              ),
                              //  SizedBox(width: 16),
                              Flexible(
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      filternews[index].title,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      filternews[index].description,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        );
                    } else {
//if(issearch)
                      //filternews= article;

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => View(Url: article.url)),
                          );
                        },
                        child: Container(
                          height: 100,
                          //padding: EdgeInsets.symmetric(horizontal: 12),

                          margin: const EdgeInsets.all(8),
                          child: Row(children: <Widget>[
                            Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    article.urlToImage,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            SizedBox(width: 16),
                            Flexible(
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    article.title,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    article.description,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ]
                          ),
                        ),
                      );
                    }
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

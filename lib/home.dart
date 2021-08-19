import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'show.dart';

class Home extends StatefulWidget {

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  String showName = 'Forgot?';
  TextEditingController _controller = TextEditingController();
  List<Show> showFavList = [];
  Future<void> loadData() async {
    var url = 'https://api.tvmaze.com/search/shows?q=$showName';
    String genre;
    String rating;
    String imgUrl;
    try {
      var resp = await get(Uri.parse(url));
      var jsonResponse = convert.jsonDecode(resp.body);
      var data = jsonResponse[0]['show'];
      print(data.toString());
      imgUrl = data['image']['original'].toString();
      rating = data['rating']['average'].toString();
      genre = data['genres'].toString();
      showFavList.add(
          Show(name : showName, genre: genre, imageUrl: imgUrl, rating: rating));
      setState(() {});

    } catch (e) {
      print('$e');
    }
  }




  Widget showWidget(show) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(show.imageUrl),
        subtitle: Text(
          show.genre
        ),
        title: Text(show.name),
        trailing: Text(show.rating),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.favorite,
            size: 20,
            color: Colors.red[900],
            ),
          onPressed: () {
            loadData();
            _controller.clear();
          },
        ),
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.yellow[900],
          title: Text('Favorite shows'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (name) {
                showName = name;
              },
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(),
                labelText: 'Search',
                labelStyle: TextStyle(
                  color: Colors.grey[600]
                )
              ),
            ),
            Column(
              children: showFavList.map((show) => showWidget(show)).toList(),
            )
          ],
        ));
  }
}
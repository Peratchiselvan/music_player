
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:music_player/playing.dart';
import 'package:music_player/model/SongsModel.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<SongsModel>(
      model: SongsModel(),
      child:MaterialApp(
        title: 'Boom Box Pro',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ListPage(),
      )
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>  {

  @override
  void initState() {
    super.initState();
    SongsModel model = ScopedModel.of(context);
    model.fetchSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boom Box Pro"),
      ),
      body: ScopedModelDescendant<SongsModel>(
        builder: (context, child, model){
          return ListView.separated(
          separatorBuilder: (context, i){return Divider(color: Colors.black,);},
          itemCount: model.songs.length,
          itemBuilder: (context,i){
            return ListTile(
              title: Text(model.songs[i].title),
              onTap: (){
                model.playing = i;
                Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return PlayingPage();
                  }
                ));
              },
            );
          },
        );
        }
      )
    );
  }
}

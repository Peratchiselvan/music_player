import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'dart:io';
import 'package:scoped_model/scoped_model.dart';
import 'package:music_player/model/SongsModel.dart';
enum PlayerState { playing, pausing}
class PlayingPage extends StatefulWidget {
  @override
  _PlayingPageState createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage> {

  MusicFinder player = new MusicFinder();

  var currentValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No AppBar
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: ScopedModelDescendant<SongsModel>(
          builder: (context, child, model){
            return Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 10,
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: model.songs[model.playing].albumArt != null ? Image.file(File.fromUri(Uri.parse(model.songs[model.playing].albumArt))): Text(model.songs[model.playing].title),
                  )
                ),
                SizedBox(height: 30,),
                Center(child: Text(model.songs[model.playing].title,style: TextStyle(fontSize: 20, color: Colors.red),),),
                SizedBox(height: 10,),
                Center(child: Text(model.songs[model.playing].artist,style: TextStyle(fontSize: 12, color: Colors.red),),),
                SizedBox(height: 30,),
                Slider(
                  value: currentValue,
                  onChanged: (newValue){
                    setState(() {
                      currentValue = newValue;
                    });
                  },
                ),
                SizedBox(height: 30,),
                getButtons(),
              ]
            );
          }
        )
      )
    );
  }

  Widget getButtons(){
    return Row(
      children: <Widget>[
        Expanded(child: Container(),),
        IconButton(
          icon: Icon(Icons.skip_previous),
          onPressed: (){
            // TODO: play previous
          },
        ),
        Expanded(child: Container(),),
        RawMaterialButton(
          shape: CircleBorder(),
          fillColor: Colors.white,
          splashColor: Colors.pink,
          highlightColor: Colors.pink.withOpacity(0.5),
          elevation: 10.0,
          highlightElevation: 5.0,
          onPressed: (){},
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Icon(
              Icons.play_arrow,
              color: Colors.deepOrangeAccent[400],
              size: 35.0,
            ),
          ),
        ),
        Expanded(child: Container(),),
        IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: (){
            // TODO: play next song
          },
        ),
        Expanded(child: Container(),),
      ],
    );
  }
}
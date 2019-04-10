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

  MusicFinder player;

  var currentValue = 0;
  var duration = 0;

  @override
  void initState() {
    super.initState();
    player = new MusicFinder();
    player.setCompletionHandler(onComplete);
    player.setDurationHandler((d){
      duration = d.inSeconds;
    });
    player.setPositionHandler(handler);
  }

  void handler(d){
    currentValue = d.inSeconds;
    setState(() {
      
    });
  }

  void onComplete(){
    player.stop();
    SongsModel model = ScopedModel.of(context);
    model.next();
    play(model);
    setState((){});
  }

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
                Center(child: Text(model.songs[model.playing].title + model.playing.toString(),style: TextStyle(fontSize: 20, color: Colors.red),),),
                SizedBox(height: 10,),
                Center(child: Text(model.songs[model.playing].artist,style: TextStyle(fontSize: 12, color: Colors.red),),),
                SizedBox(height: 30,),
                Slider(
                  value: currentValue.toDouble(),
                  max: duration.toDouble(),
                  onChanged: (newValue){
                    setState(() {
                      player.seek(newValue);
                    });
                  },
                ),
                SizedBox(height: 30,),
                getButtons(model),
              ]
            );
          }
        )
      )
    );
  }

  play(model){
    var song = model.songs[model.playing];
    player.play(song.uri, isLocal: true);
    model.currentState = PlayingState.playing;
  }
  pause(model){
    player.pause();
    model.currentState = PlayingState.paused;
  }
  Widget getButtons(SongsModel model){
    return Row(
      children: <Widget>[
        Expanded(child: Container(),),
        IconButton(
          icon: Icon(Icons.skip_previous),
          onPressed: (){
            player.stop();
            model.previous();
            play(model);
            setState(() {
              
            });
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
          onPressed: (){
            model.currentState != PlayingState.playing || model.currentState == PlayingState.stopped ? play(model) : pause(model);
            setState(() {
              
            });
          },
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Icon(
              model.currentState == PlayingState.playing ? Icons.pause : Icons.play_arrow,
              color: Colors.deepOrangeAccent[400],
              size: 35.0,
            ),
          ),
        ),
        Expanded(child: Container(),),
        IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: (){
            player.stop();
            model.next();
            play(model);
            setState(() {
              
            });
          },
        ),
        Expanded(child: Container(),),
      ],
    );
  }
}
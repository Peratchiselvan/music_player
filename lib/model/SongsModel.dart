import 'package:scoped_model/scoped_model.dart';
import 'package:flute_music_player/flute_music_player.dart';
enum PlayingState {playing, paused,stopped}
class SongsModel extends Model{
  var songs = [];
  var playing;
  var currentState;
  void fetchSongs() async{
    songs = await MusicFinder.allSongs();
    notifyListeners();
  }
  void next(){
    if(playing==songs.length-1){
      playing = 0;
    }else{
    playing++;
    }
    notifyListeners();
  }
  void previous(){
    if(playing == 0){
      playing = songs.length-1;
    }else{
      playing--;
    }
    notifyListeners();
  }
}
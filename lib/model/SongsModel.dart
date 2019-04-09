import 'package:scoped_model/scoped_model.dart';
import 'package:flute_music_player/flute_music_player.dart';
class SongsModel extends Model{
  var songs = [];
  var playing;
  void fetchSongs() async{
    songs = await MusicFinder.allSongs();
    notifyListeners();
  }
  void next(){
    playing++;
    notifyListeners();
  }
  void previous(){
    playing--;
    notifyListeners();
  }
}
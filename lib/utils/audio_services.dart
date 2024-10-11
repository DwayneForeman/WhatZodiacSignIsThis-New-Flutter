import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:whatsignisthis/screens/home_screen.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playSound({required String audioPath, bool? loop}) async {
   if(!disableSound){
       try {
      await _player.setAsset(audioPath);
      _player.setLoopMode(loop == true ? LoopMode.one : LoopMode.off);
      await _player.play();
      debugPrint('Audio Played');
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }}
  }

  Future<void> stopSound() async {
    try {
      _player.stop();
      debugPrint('Audio Stopped');
    } catch (e) {
      debugPrint('Error stopping sound: $e');
    }
  }

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  void dispose() {
    _player.dispose();
  }
}

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('List shoud have element on index 1', () {
    List<Audio> audios = new List<Audio>(2);

    audios[1] = new Audio.file("path");



    expect(audios[1].path, "path");
  });
}
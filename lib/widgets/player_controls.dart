import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:radio/constants.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';

class PlayerControls extends StatefulWidget {
  @override
  _PlayerControlsState createState() => _PlayerControlsState();
}

abstract class Controls {
  void initAudio(VoidCallback pauseFn, VoidCallback playFn);
  void pause();
  void play();
}

mixin AudioControls implements Controls {
  void initAudio(VoidCallback pauseFn, VoidCallback playFn) {
    AudioManager.instance
        .start(
          radio_url,
          'Radio Chapingo',
          desc: 'Radio en vivo',
          auto: false,
        )
        .then((_) => print('$_'));
    MediaNotification.setListener('pause', () {
      pause();
    });
  }

  void pause() {
    AudioManager.instance.toPause().then((status) => print('status: $status'));
  }

  void play() {
    AudioManager.instance
        .play(
          index: 0,
          auto: true,
        )
        .then((status) => print('status: $status'));
  }
}

mixin RadioControls implements Controls {
  void initAudio(VoidCallback pauseFn, VoidCallback playFn) {
    FlutterRadio.audioStart().then(
      (_) => print('audio started'),
    );
    MediaNotification.setListener('pause', pauseFn);
    MediaNotification.setListener('play', playFn);
    MediaNotification.setListener('next', () {});
    MediaNotification.setListener('prev', () {});
    MediaNotification.setListener('select', () {});
  }

  void _showNotification({bool isPlaying}) {
    MediaNotification.showNotification(
      title: 'Radio Chapingo',
      author: 'En vivo',
      isPlaying: isPlaying,
    );
  }

  void pause() {
    FlutterRadio.pause(url: radio_url).then((_) {
      print('finished pausing');
    });
    _showNotification(isPlaying: false);
  }

  void play() {
    FlutterRadio.play(url: radio_url).then((_) {
      print('finished playing');
    });
    _showNotification(isPlaying: true);
  }
}

class _PlayerControlsState extends State<PlayerControls> with RadioControls {
  bool isPlaying = false;

  VoidCallback get pauseFn => () {
        setState(() => isPlaying = false);
        pause();
      };

  VoidCallback get playFn => () {
        setState(() => isPlaying = true);
        play();
      };

  @override
  void initState() {
    super.initState();
    initAudio(pauseFn, playFn);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Theme.of(context).accentColorBrightness,
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Entrevista sobre nuevos proyectos'),
              subtitle: Text('Club de Ciencias Netzahualpilli'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  onPressed: () => null,
                ),
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: isPlaying ? pauseFn : playFn,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  onPressed: () => null,
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}

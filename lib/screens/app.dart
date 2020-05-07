import 'package:flutter/material.dart';
import 'package:radio/widgets/menu_btn.dart';
import 'package:radio/widgets/player_controls.dart';
import 'package:radio/screens/radio.dart';
import 'package:radio/screens/podcasts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Theme.of(context).primaryColorBrightness == Brightness.dark
            ? Image.asset('images/logo_light.png')
            : Image.asset('images/logo_dark.png'),
        title: Text('Radio Chapingo'),
        actions: [
          MenuBtn(),
        ],
      ),
      body: Column(
        children: <Widget>[
          PlayerControls(),
          Expanded(
            child: page == 0 ? RadioScreen() : PodcastScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.indigoAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            title: Text('Radio'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            title: Text('Podcasts'),
          ),
        ],
        currentIndex: page,
        onTap: (index) => setState(() {
          page = index;
        }),
      ),
    );
  }
}

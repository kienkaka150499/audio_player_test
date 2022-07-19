import 'dart:convert';

import 'package:audio_player_test/models/playlist.dart';
import 'package:audio_player_test/services/playlist_service.dart';
import 'package:audio_player_test/views/play_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/home_screen.dart';

void main() async{
  //Playlist playlist=PlaylistService().playlist;
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  late Playlist playlist;

  Future<Playlist>_readData() async {
    final jsonString=await rootBundle.loadString('json/playlist.json');
    final response=jsonDecode(jsonString);
    return Playlist.fromJson(response);
  }
  
  //MyApp(this.playlist);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<Playlist>(
      future: _readData(),
        builder: (context,snapshot){
        if(snapshot.hasData){
          playlist=snapshot.data!;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: PlayScreen(playlist: playlist,index: 0,),
          );
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        }
    );
  }
}
import 'dart:convert';

import 'package:audio_player_test/assets/app_colors.dart';
import 'package:audio_player_test/audio_player_file.dart';
import 'package:audio_player_test/services/playlist_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/playlist.dart';

class PlayScreen extends StatefulWidget {
  Playlist playlist;
  final index;

  PlayScreen({required this.playlist,required this.index});
  @override
  State createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>{
  late bool isShowMenu;
  late AudioPlayer player;
  // Playlist playlist= PlaylistService().playlist;

  @override
  void initState() {
    isShowMenu = false;
    player = AudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              isShowMenu = !isShowMenu;
            });
          },
          icon: Icon(isShowMenu ? Icons.chevron_left : Icons.menu),
        ),
        title: const Text('Play Screen'),
        centerTitle: true,
        backgroundColor: AppColors().appBarColor,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // FutureBuilder<Playlist>(
            //     future: _readData(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         playlist = snapshot.data!;
            //         return _buildMainScreen();
            //       } else {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //     }),
            _buildMainScreen(),
            _buildSideBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSideBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: AppColors().sideBarColor,
      width: isShowMenu ? 90 : 0,
      child: Column(
        children: [],
      ),
    );
  }

  Widget _buildMainScreen() {
    return Container(
      width: 360,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      // margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      color: AppColors().mainColor,
      child: Column(
        children: [
          Container(
            width: 260,
            height: 260,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                widget.playlist.songs[widget.index].imageUrl,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              widget.playlist.songs[widget.index].name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            // padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              widget.playlist.songs[widget.index].artist,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 320,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      print(widget.playlist.songs[widget.index].favorite);
                      widget.playlist.songs[widget.index].favorite=!widget.playlist.songs[widget.index].favorite;
                      print(widget.playlist.songs[widget.index].favorite);
                    });
                  },
                  icon: Icon(
                    widget.playlist.songs[widget.index].favorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.download,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.cloud_upload_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          AudioPlayerFile(player: player, playlist: widget.playlist),
        ],
      ),
    );
  }
}

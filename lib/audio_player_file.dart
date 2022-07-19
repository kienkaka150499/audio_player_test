import 'dart:convert';

import 'package:audio_player_test/assets/top_function.dart';
import 'package:audio_player_test/models/playlist.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AudioPlayerFile extends StatefulWidget {
  AudioPlayer player;
  Playlist playlist;

  AudioPlayerFile({Key? key, required this.player, required this.playlist})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AudioPlayerFileState();
}

class _AudioPlayerFileState extends State<AudioPlayerFile> {
  Duration _duration = Duration();
  Duration _position = Duration();
  late String path=widget.playlist.songs[index].source;
  bool isPlaying = false;
  bool isLoop = false;
  bool isShuffle = false;
  int index = 0;
  List<IconData> repeat = const [
    MdiIcons.repeatOff,
    MdiIcons.repeat,
    MdiIcons.repeatOnce,
  ];

  @override
  initState() {
    widget.player.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    widget.player.onPositionChanged.listen((p) {
      setState(() => _position = p);
    });
    path = widget.playlist.songs[index].source;
    widget.player.setSourceAsset(path);
    _playerCompletion();
    super.initState();
  }

  void _playerCompletion() {
    widget.player.onPlayerComplete.listen((event) {
      setState(() {
        iconRepeatTapCount!=2?_playerNext():_position=const Duration(seconds: 0);
      });
    });
  }

  void _playerNext() {
    int maxIndex = widget.playlist.songs.length - 1;
    _position=const Duration(seconds: 0);
    if (index == maxIndex && iconRepeatTapCount == 0) {
      isPlaying = false;
      return;
    }
      if (isShuffle) {
        index = (index + Random().nextInt(maxIndex)) % (maxIndex + 1);
      } else {
        index++;
      }
    path=widget.playlist.songs[index].source;
    widget.player.play(AssetSource(path));
  }

  void _playerPrevious(){
    int maxIndex = widget.playlist.songs.length - 1;
    _position = const Duration(seconds: 0);
    if (index == 0) {
      path=widget.playlist.songs[index].source;
      widget.player.play(AssetSource(path));
      return;
    }
    if (isShuffle) {
      index = (index + Random().nextInt(maxIndex)) % (maxIndex + 1);
    } else {
      index++;
    }
    path=widget.playlist.songs[index].source;
    widget.player.play(AssetSource(path));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          Container(
            height: 50,
            width: 320,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 35,
                  child: Text(
                    timeFormat(_position),
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
                Container(
                  width: 240,
                  child: Slider(
                    activeColor: Colors.purpleAccent,
                    inactiveColor: Colors.purple,
                    mouseCursor: MaterialStateMouseCursor.clickable,
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (double value) {
                      setState(() {
                        widget.player.seek(
                          Duration(
                            seconds: value.toInt(),
                          ),
                        );
                        value = value;
                      });
                    },
                  ),
                ),
                Container(
                  width: 35,
                  child: Text(
                    timeFormat(_duration),
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
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
                      isShuffle=!isShuffle;
                    });
                  },
                  icon: Icon(isShuffle?
                    MdiIcons.shuffleVariant:MdiIcons.shuffleDisabled,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _playerPrevious();
                    });
                  },
                  icon: const Icon(
                    MdiIcons.skipPrevious,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isPlaying = !isPlaying;
                      isPlaying
                          ? this.widget.player.play(AssetSource(path))
                          : this.widget.player.pause();
                    });
                  },
                  icon: Icon(
                    isPlaying ? MdiIcons.pause : MdiIcons.play,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _playerNext();
                    });
                  },
                  icon: const Icon(
                    MdiIcons.skipNext,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      iconRepeatTapCount =
                          (iconRepeatTapCount + 1) % repeat.length;
                      widget.player.setReleaseMode(iconRepeatTapCount == 2
                          ? ReleaseMode.loop
                          : ReleaseMode.release);
                      //_position = const Duration(seconds: 0);
                    });
                  },
                  icon: Icon(
                    repeat[iconRepeatTapCount],
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

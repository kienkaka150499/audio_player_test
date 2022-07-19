class Song {
  String name;
  String id;
  String imageUrl;
  String source;
  String artist;
  bool favorite;

  Song({
    required this.id,
    required this.name,
    required this.artist,
    required this.imageUrl,
    required this.source,
    required this.favorite,
  });

  factory Song.fromJson(Map<String,dynamic> json){
    return Song(
      id: json["id"],
      name: json['name'],
      artist: json['artist'],
      imageUrl: json['imageURL'],
      source: json['source'],
      favorite: json['favorite'],
    );
  }
}

class Playlist {
  List<Song> songs;

  Playlist({required this.songs});

  factory Playlist.fromJson(List<dynamic> parseJson){
    List<Song> songs=<Song>[];
    songs=parseJson.map((index) => Song.fromJson(index)).toList();
    return Playlist(songs: songs);
  }
}

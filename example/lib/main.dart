import 'package:flutter/material.dart';
import 'package:on_audio_room/on_audio_room.dart';

void main() async {
  //Init Room.
  await OnAudioRoom().initRoom(RoomType.PLAYLIST);
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Call audio room.
  OnAudioRoom audioRoom = OnAudioRoom();

  @override
  void dispose() {
    //Remember to close room to avoid memory leaks.
    //Choose the better location(page) to add this method.
    audioRoom.closeRoom();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OnAudioRoomExample"),
        actions: [
          IconButton(
            onPressed: () async {
              var result = await audioRoom.createPlaylist("entity");
              setState(() {
                print(result);
              });
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () async {
              var result = await audioRoom.clearPlaylists();
              setState(() {
                print(result);
              });
            },
            icon: Icon(Icons.delete_forever_outlined),
          ),
        ],
      ),
      body: FutureBuilder<List<PlaylistEntity>>(
        future: OnAudioRoom().queryPlaylists(),
        builder: (context, item) {
          if (item.data != null) {
            List<PlaylistEntity> songs = item.data!;
            return ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(songs[index].playlistName),
                  subtitle: Text(DateTime.fromMillisecondsSinceEpoch(
                          songs[index].playlistDataAdded!)
                      .toString()),
                  onTap: () async {
                    var result = await audioRoom.renamePlaylist(
                        songs[index].key, "newName");
                    setState(() {
                      print(result);
                    });
                  },
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

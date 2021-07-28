/*
=============
Author: Lucas Josino
Github: https://github.com/LucasPJS
Website: https://lucasjosino.com/
=============
Plugin/Id: on_audio_room#4
Homepage: https://github.com/LucasPJS/on_audio_room
Pub: https://pub.dev/packages/on_audio_room
License: https://github.com/LucasPJS/on_audio_room/blob/main/LICENSE
Copyright: © 2021, Lucas Josino. All rights reserved.
=============
*/

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

void main() async {
  //Init Room.
  await OnAudioRoom().initRoom(RoomType.FAVORITES);
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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Information()),
                );
              },
              icon: Icon(Icons.favorite_outline_rounded))
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
        //In this example we will use [on_audio_query] to query songs from device.
        future: OnAudioQuery().queryAudios(null, null, null, true),
        builder: (context, item) {
          if (item.data != null) {
            List<SongModel> songs = item.data!;
            //Display only 10 because it's only a example.
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(songs[index].title),
                  subtitle: Text(songs[index].artist),
                  //First method from [on_audio_room], here we'll add the selected song
                  //inside the favorites room.
                  onTap: () async {
                    //If songs has addded to favorites the result will be the song [key], if not, will be [null].
                    //
                    //There's two ways to convert song information to a [Entity].
                    //
                    //First method(Manually):
                    //  Create a Map<dynamic, dynamic> with all this keys and a value.
                    //
                    // * _data
                    // * _display_name
                    // * _id
                    // * album
                    // * album_id
                    // * artist
                    // * artist_id
                    // * date_added
                    // * duration
                    // * title
                    // * artwork
                    //
                    //  After this you can call a method to convert to [Entity]:
                    //    yourMapName.to*Type*Entity();
                    //
                    //Second method(using on_audio_query):
                    //  From your [SongModel] just call [toMap] and then [to*Type*Entity()].

                    //This example we use the [on_audio_query] plugin:
                    var result = audioRoom.addTo(
                      RoomType.FAVORITES, //Specify the room type
                      songs[index].getMap.toFavoritesEntity(),
                    );
                    print(result);
                  },
                  //Other method, this will clear all the room.
                  onLongPress: () async {
                    audioRoom.clearRoom(RoomType.FAVORITES);
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

class Information extends StatefulWidget {
  const Information({Key? key}) : super(key: key);

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  //Call audio room.
  OnAudioRoom audioRoom = OnAudioRoom();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OnAudioRoomExample"),
      ),
      body: Center(
        //Add to the future builder the specific type.
        child: FutureBuilder<List<FavoritesEntity>>(
          //Default limit: 50
          //Default reverse: false
          //Default sortType: key
          future: OnAudioRoom().queryFavorites(
            limit: 50,
            reverse: false,
            sortType: null, //Null will use the [key] has sort.
          ),
          builder: (context, item) {
            if (item.data == null) return CircularProgressIndicator();

            if (item.data!.isEmpty) return Text("No data found");

            List<FavoritesEntity> favorites = item.data!;
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favorites[index].title),
                  subtitle: Text(favorites[index].dateAdded.toString()),
                  onTap: () async {
                    //Most the method will return a bool to indicate if method works.
                    var result = await audioRoom.deleteFrom(
                        RoomType.FAVORITES, favorites[index].key);
                    //Call setState to see the result,
                    setState(() {
                      print(result);
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

//This method is temporary, soon will be added to [on_audio_query].
//TODO: Add this extension to [on_audio_query] and [toString()].
extension OnAudioFormatter on SongModel {
  Map get getMap {
    Map tempMap = {};
    tempMap["_data"] = this.data;
    tempMap["_display_name"] = this.displayName;
    tempMap["_id"] = this.id;
    tempMap["album"] = this.album;
    tempMap["album_id"] = this.albumId;
    tempMap["artist"] = this.artist;
    tempMap["artist_id"] = this.artistId;
    tempMap["date_added"] = this.dateAdded;
    tempMap["duration"] = this.duration;
    tempMap["title"] = this.title;
    tempMap["artwork"] = this.artwork;
    return tempMap;
  }
}

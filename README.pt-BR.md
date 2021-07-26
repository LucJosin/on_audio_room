# on_audio_room
[![Pub.dev](https://img.shields.io/pub/v/on_audio_room?color=9cf&label=Pub.dev&style=flat-square)](https://pub.dev/packages/on_audio_room)
[![Platform](https://img.shields.io/badge/Platform-Android-9cf?logo=android&style=flat-square)](https://www.android.com/)
[![Flutter](https://img.shields.io/badge/Language-Flutter%20%7C%20Null--Safety-9cf?logo=flutter&style=flat-square)](https://www.flutter.dev/)
[![Kotlin](https://img.shields.io/badge/Language-Kotlin-9cf?logo=kotlin&style=flat-square)](https://kotlinlang.org/)

`on_audio_room` é um [Flutter](https://flutter.dev/) Plugin usado para criar um banco de dados para guardar informações dos audios [Favoritos, Playlist Interna, Mais Tocadas, etc...]. <br>

Esse Plugin funciona como uma "extenção" para [on_audio_query](https://github.com/LucasPJS/on_audio_query) e alguns métodos irão depender dele.

## Ajuda:

**Algum problema? [Issues](https://github.com/LucasPJS/on_audio_room/issues)** <br>
**Alguma sugestão? [Pull request](https://github.com/LucasPJS/on_audio_room/pulls)**

### Traduções:

NOTE: Fique à vontade para ajudar nas traduções

* [Inglês](README.md)
* [Português](README.pt-BR.md)

## Tópicos:

* [Como instalar](#como-instalar)
* [Como usar](#como-usar)
* [Exemplos](#exemplos)
* [Licença](#licença)

## Como instalar:
Adicione o seguinte codigo para seu `pubspec.yaml`:
```yaml
dependencies:
  on_audio_room: ^1.0.1+1
  # Ou você pode testar a versão beta
  # on_audio_room: 2.0.0-beta.0
```

<!-- #### Request Permission:
If you want to use the built-in request permission, will need add the following code to your `AndroidManifest.xml`
```xml
<manifest> ...

  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

</manifest>
``` -->

## Algumas qualidades:

* Área para favoritos
* Área para últimas tocadas
* Área para mais tocadas
* Área para playlists internas

## TODO:

* Adicionar uma melhor performace para todo o plugin.
* Criar métodos para IOS.
* Arrumar erros.

## Como usar:

```dart
OnAudioRoom() // O comando principal para usar o plugin.
```
Todos os tipos de métodos nesse plugin:

### Métodos para o banco de dados

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`setDatabaseName`]() | `(String)` | `bool` | <br>
| [`setDatabaseLimit`]() | `(int)` | `bool` | <br>
| [`getDatabaseName`]() |  | `String` | <br>
| [`getDatabaseLimit`]() |  | `int` | <br>
| [`getDatabaseStatus`]() |  | `bool` | <br>
| [`resetDatabaseName`]() |  | `bool` | <br>
| [`resetDatabaseLimit`]() |  | `bool` | <br>
| [`resetAllDatabase`]() |  | `bool` | <br>
| [`closeDatabase`]() |  | `bool` | <br>

### Global métodos

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`addTo`]() | `(RoomType, Entity, PlaylistId?)` | `int` | <br>
| [`addAllTo`]() | `(RoomType, Entity, PlaylistId?)` | `List<int>` | <br>
| [`deleteFrom`]() | `(RoomType, SongId, PlaylistId?)` | `bool` | <br>
| [`deleteAllFrom`]() | `(RoomType)` | `bool` | <br>
| [`checkIn`]() | `(RoomType, SongId, PlaylistId?)` | `bool` | <br>
| [`queryAllIdsFrom`]() | `(RoomType, PlaylistId?)` | `List<int>` | <br>

### Query métodos

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`queryFromFavorites`]() | `(SongId)` | `FavoritesEntity` | <br>
| [`queryAllFromFavorites`]() | `(QueryLimit?)` | `List<FavoritesEntity>` | <br>
| [`queryFromLastPlayed`]() | `(SongId)` | `LastPlayedEntity` | <br>
| [`queryAllFromLastPlayed`]() | `(QueryLimit?)` | `List<LastPlayedEntity>` | <br>
| [`queryFromMostPlayed`]() | `(SongId)` | `MostPlayedEntity` | <br>
| [`queryAllFromMostPlayed`]() | `(QueryLimit?)` | `List<MostPlayedEntity>` | <br>
| [`queryFromPlaylist`]() | `(SongId)` | `PlaylistSongsEntity` | <br>
| [`queryAllFromPlaylist`]() | `(QueryLimit?)` | `List<PlaylistSongsEntity>` | <br>

### Playlist métodos

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`createPlaylist`]() | `(Entity)` | `int` | <br>
| [`deletePlaylist`]() | `(Entity)` | `bool` | <br>
| [`renamePlaylist`]() | `(PlaylistId, NewPlaylistName)` | `bool` | <br>
| [`queryPlaylist`]() | `(PlaylistId)` | `PlaylistEntity` | <br>
| [`queryAllPlaylists`]() | `(QueryLimit?)` | `List<PlaylistEntity>` | <br>

## Exemplos:

**Todos os exemplos irão usar [on_audio_query] plugin para adquirir informações sobre os audios/músicas**

#### addTo
```dart
  //Se você usa [on_audio_query] apenas precisa extender SongModel para criar qualquer entidade.
  someName() async {
    //O retorno irá sé o id da música dentro do banco de dados.
    int addToResult = await OnAudioRoom().addTo(
      RoomType.FAVORITES, 
      entity[index].toFavoritesEntity,
    );
  }

  //Se não você usa [on_audio_query] apenas crie um map com todas as informações.
  someOtherName() async {
    Map<dynamic, dynamic> favoritesEntity = {
      "last_data": song.data,
      "display_name": song.displayName,
      "id": song.id,
      "album": song.album,
      "album_id": song.albumId,
      "artist": song.artist,
      "artist_id": song.artistId,
      "date_added": song.dateAdded,
      "duration": song.duration,
      "title": song.title,
      "artwork": song.artwork,
    };

    //Agora, adicione para o banco de dados.
    //O retorno irá sé o id da música dentro do banco de dados.
    int addToResult = await OnAudioRoom().addTo(
      RoomType.FAVORITES, 
      favoritesEntity,
    ); 
  }
```

#### addAllTo
```dart
  //Se você usa [on_audio_query] apenas precisa extender SongModel para criar qualquer entidade.
  someName() async {
    //Crie uma lista com todos os SongModel.
    List<SongModel> listOfSongs;
    List<Map<dynamic, dynamic>> listOfEntities;
    
    //Adicione todas as músicas do model para a entidade.
    listOfSongs.forEach(element) {
      listOfEntities.add(element.toFavoritesEntity());
    }

    //Agora, adicione para o banco de dados.
    //O retorno irá sé o id da música dentro do banco de dados.
    List<int> addAllToResult = await OnAudioRoom().addAllTo(
      RoomType.FAVORITES, 
      listOfEntities,
    );
  }

  //Se não você usa [on_audio_query] apenas crie uma lista de map com todas as informações.
  someOtherName() async {
    List<Map<dynamic, dynamic>> listOfEntities;
    listOfSongs.forEach(element) {
      Map<dynamic, dynamic> favoritesEntity = {
      "last_data": song.data,
      "display_name": song.displayName,
      "id": song.id,
      "album": song.album,
      "album_id": song.albumId,
      "artist": song.artist,
      "artist_id": song.artistId,
      "date_added": song.dateAdded,
      "duration": song.duration,
      "title": song.title,
      "artwork": song.artwork,
      };

      listOfEntities.add(favoritesEntity);
    }

    //Agora, adicione para o banco de dados.
    //O retorno irá sé o id da música dentro do banco de dados.
    List<int> addAllToResult = await OnAudioRoom().addAllTo(
      RoomType.FAVORITES, 
      favoritesEntity,
    ); 
  }
```

#### deleteFrom
```dart
  someName() async {
    //O retorno será [true] se a música foi deletada ou [false] se não.
    bool deleteFromResult = await OnAudioRoom().deleteFrom(
      RoomType.FAVORITES,
      SongId,
    );
  }

  //Quando [Adicionando/Deletando/Checando] músicas da playlist, lembre-se de definir um
  //[PlaylistId] ou retornará um erro.
  someName() async {
    //O retorno será [true] se a música foi deletada ou [false] se não.
    bool deleteFromResult = await OnAudioRoom().deleteFrom(
      RoomType.PLAYLIST_SONGS,
      SongId,
      PlaylistId: PlaylistId,
    );
  }
```

#### deleteAllFrom
```dart
  //Esse é bem simples.
  someName() async {
    //O retorno será [true] se todas as músicas foram deletadas ou [false] se não.
    bool deleteAllFromResult = await OnAudioRoom().deleteAllFrom(
      RoomType.FAVORITES,
    );
  }
```

#### checkIn
```dart
  //Você vai usar esse para chegar se a música foi adicionada.
  //Por quê? Se você tentar adicionar duas músicas iguais, irá funcionar, para evitar isso
  //faça a checagem.
  someName() async {
    //O retorno será [true] se a música já foi adicionada ou [false] se não.
    bool checkInResult = await OnAudioRoom().checkIn(
      RoomType.FAVORITES,
      SongId,
    );
  }
```

#### queryFromFavorites
```dart
  someName() async {
    //Com esse método você irá definir um id e irá receber todas as informações sobre a música.
    FavoritesEntity queryFromResult = await OnAudioRoom().queryFromFavorites(
      SongId,
    );
  }
```

#### queryFromFavorites
```dart
  someName() async {
    //Com esse método você irá pegar todas as músicas e todas as informações baseado no Type[Entity].
    //Você pode adicionar um valor como parametro para definir quantas músicas irão voltar.
    List<FavoritesEntity> queryAllFromResult = await OnAudioRoom().queryAllFromFavorites(
      100, //Default: 50
    );
  }
```

## LICENSE:

* [LICENSE](https://github.com/LucasPJS/on_audio_room/blob/main/LICENSE)

> * [Back to top](#on_audio_room)
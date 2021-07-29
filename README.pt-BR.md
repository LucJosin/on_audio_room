# on_audio_room
[![Pub.dev](https://img.shields.io/pub/v/on_audio_room?color=9cf&label=Pub.dev&style=flat-square)](https://pub.dev/packages/on_audio_room)
[![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20IOS%20%7C%20Web%20%7C%20MacOs%20%7C%20Linux%20%7C%20Windows-9cf?&style=flat-square)](https://www.android.com/)
[![Flutter](https://img.shields.io/badge/Language-Flutter%20%7C%20Null--Safety-9cf?logo=flutter&style=flat-square)](https://www.flutter.dev/)

`on_audio_room` é um [Flutter](https://flutter.dev/) Package usado para criar um "quarto" para guardar informações dos audios [Favoritos, Playlist Interna, Mais Tocadas, etc...]. <br>

Esse Package funciona como uma "extenção" para [on_audio_query](https://github.com/LucasPJS/on_audio_query) e alguns métodos irão depender dele.

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
  on_audio_room: ^2.0.0
```

## Algumas qualidades:

* Área para favoritos
* Área para últimas tocadas
* Área para mais tocadas
* Área para playlists internas

## TODO:

* Adicionar uma melhor performace para todo o plugin.
* Adicionar `[Qualidades]`.
* Arrumar erros.

## Como usar:

```dart
OnAudioRoom() // O comando principal para usar o plugin.
```
Todos os tipos de métodos nesse plugin:

### Métodos para o "quarto"

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`initRoom`]() | `(RoomType, SubDir?)` | `bool` | <br>
| [`closeRoom`]() |  | `bool` | <br>
| [`deleteRoomFile`]() |  | `bool` | <br>
| [`getRoomInfo`]() |  | `RoomEntity` | <br>
| [`clearAll`]() |  | `bool` | <br>

### Global methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`addTo`]() | `(RoomType, Entity, PlaylistKey?)` | `int?` | <br>
| [`addAllTo`]() | `(RoomType, Entity, PlaylistKey?)` | `List<int>` | <br>
| [`updateRoom`]() | `(RoomType, Entity)` | `bool` | <br>
| [`deleteFrom`]() | `(RoomType, EntityKey, PlaylistKey?)` | `bool` | <br>
| [`deleteAllFrom`]() | `(RoomType, EntityKeys, PlaylistKey?)` | `bool` | <br>
| [`clearRoom`]() | `(RoomType)` | `bool` | <br>
| [`checkIn`]() | `(RoomType, EntityKey, PlaylistKey?)` | `bool` | <br>

### Query methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`queryFromFavorites`]() | `(EntityKey)` | `FavoritesEntity` | <br>
| [`queryFavorites`]() | `(Limit?, Reverse?, RoomSortType?)` | `List<FavoritesEntity>` | <br>
| [`queryFromLastPlayed`]() | `(EntityKey)` | `LastPlayedEntity` | <br>
| [`queryLastPlayed`]() | `(Limit?, Reverse?, RoomSortType?)` | `List<LastPlayedEntity>` | <br>
| [`queryFromMostPlayed`]() | `(EntityKey)` | `MostPlayedEntity` | <br>
| [`queryMostPlayed`]() | `(Limit?, Reverse?, RoomSortType?)` | `List<MostPlayedEntity>` | <br>
| [`queryFromPlaylist`]() | `(PlaylistKey, EntityKey)` | `SongEntity` | <br>
| [`queryAllFromPlaylist`]() | `(PlaylistKey, Limit?, Reverse?, RoomSortType?)` | `List<SongEntity>` | <br>

### Playlist methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`createPlaylist`]() | `(PlaylistName)` | `int?` | <br>
| [`deletePlaylist`]() | `(PlaylistKey)` | `bool` | <br>
| [`renamePlaylist`]() | `(PlaylistKey, NewName)` | `bool` | <br>
| [`clearPlaylists`]() |  | `bool` | <br>
| [`queryPlaylist`]() | `(PlaylistKey)` | `PlaylistEntity` | <br>
| [`queryPlaylists`]() | `(Limit?, Reverse?)` | `List<PlaylistEntity>` | <br>

## Exemplos:

**Todos os exemplos irão usar [on_audio_query] plugin para adquirir informações sobre os audios/músicas**

#### addTo
```dart
  //Se você usa [on_audio_query] apenas precisa extender SongModel para criar qualquer entidade.
  someName() async {
    //O retorno irá sé o id da música dentro do banco de dados.
    int? addToResult = await OnAudioRoom().addTo(
      RoomType.FAVORITES, 
      entity[index].getMap.toFavoritesEntity(),
    );
  }

  //Se não você usa [on_audio_query] apenas crie um map com todas as informações.
  someOtherName() async {
    Map<dynamic, dynamic> favoritesEntity = {
      "_data": song.data,
      "_display_name": song.displayName,
      "_id": song.id,
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
    int? addToResult = await OnAudioRoom().addTo(
      RoomType.FAVORITES, 
      favoritesEntity.toFavoritesEntity(),
    ); 
  }
```

#### addAllTo
```dart
  //Se você usa [on_audio_query] apenas precisa extender SongModel para criar qualquer entidade.
  someName() async {
    //Crie uma lista com todos os SongModel.
    List<SongModel> listOfSongs;
    List<dynamic> listOfEntities;
    
    //Adicione todas as músicas do model para a entidade.
    listOfSongs.forEach(element) {
      listOfEntities.add(element.getMap.toFavoritesEntity());
    }

    //Agora, adicione para o banco de dados.
    //O retorno irá sé o id da música dentro do banco de dados.
    List<int> addAllToResult = await OnAudioRoom().addAllTo(
      RoomType.FAVORITES, 
      listOfEntities,
      //playlistKey,
    );
  }

  //Se não você usa [on_audio_query] apenas crie uma lista de map com todas as informações.
  someOtherName() async {
    List<dynamic> listOfEntities;

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

      listOfEntities.add(favoritesEntity.toFavoritesEntity());
    }

    //Agora, adicione para o banco de dados.
    //O retorno irá sé o id da música dentro do banco de dados.
    List<int> addAllToResult = await OnAudioRoom().addAllTo(
      RoomType.FAVORITES, 
      favoritesEntity,
      //playlistKey,
    ); 
  }
```

#### deleteFrom
```dart
  someName() async {
    //O retorno será [true] se a música foi deletada ou [false] se não.
    bool deleteFromResult = await OnAudioRoom().deleteFrom(
      RoomType.FAVORITES,
      EntityKey,
      //playlistKey,
    );
  }

  //Quando [Adicionando/Deletando/Checando] músicas da playlist, lembre-se de definir um
  //[PlaylistId] ou retornará um erro.
  someName() async {
    //O retorno será [true] se a música foi deletada ou [false] se não.
    bool deleteFromResult = await OnAudioRoom().deleteFrom(
      RoomType.PLAYLIST,
      EntityKey,
      PlaylistKey: PlaylistKey,
    );
  }
```

#### deleteAllFrom
```dart
  someName() async {
    List<int> listOfKeysToDelete = [...];
    //O retorno será [true] se todas as músicas foram deletadas ou [false] se não.
    bool deleteAllFromResult = await OnAudioRoom().deleteAllFrom(
      RoomType.FAVORITES,
      listOfKeysToDelete,
      //playlistKey,
    );
  }
```

#### clearRoom
```dart
  //Esse é bem simples.
  someName() async {
    //O retorno será [true] se todas as músicas foram deletadas ou [false] se não.
    bool deleteAllFromResult = await OnAudioRoom().clearRoom(
      RoomType.FAVORITES,
      //playlistKey,
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
      EntityKey,
      //playlistKey,
    );
  }
```

#### queryFromFavorites
```dart
  someName() async {
    //Com esse método você irá definir um id e irá receber todas as informações sobre a música.
    FavoritesEntity? queryFromResult = await OnAudioRoom().queryFromFavorites(
      EntityKey,
    );
  }
```

#### queryFavorites
```dart
  someName() async {
    //Com esse método você irá pegar todas as músicas e todas as informações baseado no Type[Entity].
    //
    //Você pode adicionar um valor como parametro para definir quantas músicas irão voltar.
    //Você pode adicionar um [bool] como parametro para definir se a lista vai ser ao contrário ou não.
    //Você pode adicionar um [RoomSortType] como parametro para definir a ordem da lista.
    List<FavoritesEntity> queryResult = await OnAudioRoom().queryFavorites(
      100, //Default: 50
      true, //Default: false
      RoomSortType.TITLE //Default: null
    );
  }
```

## LICENSE:

* [LICENSE](https://github.com/LucasPJS/on_audio_room/blob/main/LICENSE)

> * [Back to top](#on_audio_room)
import 'package:api_youtube/Api.dart';
import 'package:api_youtube/model/Video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {
  String _texto_digitado = "";

  Inicio(this._texto_digitado);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  _listarVideos(String pesquisa) {
    Api api = Api();
    return api.pesquisar(pesquisa);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>?>(
      future: _listarVideos(widget._texto_digitado),
      builder: (contexto, resultado) {
        switch (resultado.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (resultado.hasData) {
              return ListView.separated(
                  itemBuilder: (contexto, indice) {
                    List<Video>? videos = resultado.data;
                    Video video = videos![indice];
                    return GestureDetector(
                      onTap: () {
                        FlutterYoutube.playYoutubeVideoById(
                            apiKey: CHAVE_YOUTUBE_API,
                            videoId: video.id,
                            autoPlay: true,
                            fullScreen: true);
                      },
                      child: Column(
                        children: <Widget>[
                          //O Container abaixo é utilizado apenas para posicionar as imagens:
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(video.imagem),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(video.titulo),
                            subtitle: Text(video.canal),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (contexto, indicador) => Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                  itemCount: resultado.data!.length);
            } else {
              return Center(
                child: Text("Nenhum dado a ser exibido"),
              );
            }
            break;
        }
      },
    );
  }
}

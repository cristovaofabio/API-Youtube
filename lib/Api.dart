import 'dart:convert';

import 'package:api_youtube/model/Video.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as conversor;

const CHAVE_YOUTUBE_API = "";
const ID_CANAL = "";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>?> pesquisar(String pesquisa) async {
    //Neste método eu estou recurando vídeos de um canal específico

    var url = Uri.parse(URL_BASE +
        "search"
            "?part=snippet"
            "&type=video"
            "&maxResults=10"
            "&order=date"
            "&key=$CHAVE_YOUTUBE_API"
            "&channelId=$ID_CANAL"
            "&q=$pesquisa");
    var resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      print("Parabéns! Conexão realizada com sucesso");

      //Mostrar conteúdo recebido:
      //print("Resultado: ${resposta.body}");

      Map<String, dynamic> dados_em_json = conversor.json.decode(resposta.body);

      //lista de vídeos:
      List<Video> videos = dados_em_json["items"].map<Video>((map) {
        return Video.fromJson(map);
        //return Video.converterJson(map);
      }).toList();

      return videos;

      //Consultar título do primeiro vídeo:
      //print(dados_em_json["items"][0]["snippet"]["title"].toString());

      //Exibir apenas os títulos dos vídeos:
      /*
      for(var x in dados_em_json["items"]){
        print("Título: "+x["snippet"]["title"].toString());
      }*/

      /*
      for(var x in videos){
        print("ID: "+x.id);
        print("Título: "+x.titulo);
        print("Descrição: "+x.descricao);
        print("Canal: "+x.canal);
        print("\n");
      }*/

    } else {
      print("Ops! Algo de errado aconteceu");
      print("Código do erro: ${resposta.statusCode}");
    }

    return null;
  }
}

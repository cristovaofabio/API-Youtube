import 'package:api_youtube/CustomPesquisar.dart';
import 'package:api_youtube/telas/Biblioteca.dart';
import 'package:api_youtube/telas/EmAlta.dart';
import 'package:api_youtube/telas/Inicio.dart';
import 'package:api_youtube/telas/Inscricoes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indiceAtual = 0;
  String _textoDigitado = "";

  void _atualizar_texto_digitado(String texto) {
    setState(() {
      _textoDigitado = texto;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _telas = [
      Inicio(_textoDigitado),
      EmAlta(),
      Inscricoes(),
      Biblioteca()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.indigo,
          opacity: 0.8, //varia de 0(transparente) a 1(cor completa)
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          "imagens/youtube.png",
          height: 22,
          width: 98,
        ),
        actions: <Widget>[
          //IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(
              onPressed: () async {
                String? resultado = await showSearch(
                    context: context, delegate: CustomPesquisa());
                _atualizar_texto_digitado(resultado!);
              },
              icon: Icon(Icons.search)),
          //IconButton(onPressed: () {}, icon: Icon(Icons.account_circle)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: _telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        //indice = botão de navegação selecionado
        onTap: (indice) {
          setState(() {
            _indiceAtual = indice;
          });
        },
        //Definir uma cor fixa para todos os botões:
        //type: BottomNavigationBarType.fixed,
        //fixedColor: Colors.indigo,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.red,
              label: "Início",
              icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              backgroundColor: Colors.green,
              label: "Em alta",
              icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(
              backgroundColor: Colors.orange,
              label: "Inscrições",
              icon: Icon(Icons.subscriptions)),
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              label: "Biblioteca",
              icon: Icon(Icons.folder)),
        ],
      ),
    );
  }
}

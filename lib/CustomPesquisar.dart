import 'package:flutter/material.dart';

class CustomPesquisa extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear)),
    ];
    //throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: Icon(Icons.arrow_back));

    //throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    //close(context, query);
    //return Container();

    Future.delayed(Duration.zero, () {
      close(context, query);
    });

    return Center(
      child: CircularProgressIndicator(),
    );

    //throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    //return Container();


    //Exemplo de utilização de uma lista de sugestões:
    List<String> lista = [];
    if (query.isNotEmpty) {
      //Caso queira, a seguinte lista pode ser criada por meio de uma API:
      lista = ["Pay", "Alert Dialog", "List","Calendar","Ios","Android"] //apenas alguns exemplos
          .where((texto) => texto.toLowerCase().startsWith(query.toLowerCase()))
          .toList();

      return ListView.builder(
          itemCount: lista.length,
          itemBuilder: (contexto, indice) {
            return ListTile(
              onTap: () {
                close(context, lista[indice]);
              },
              title: Text(lista[indice]),
            );
          });
    } else {
      return Center(
        child: Text("Nenhum resultado para a pesquisa"),
      );
    }

    //throw UnimplementedError();
  }
}

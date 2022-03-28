import 'package:flutter/material.dart';
import '../models/cliente_model.dart';

class SearchWidget extends SearchDelegate<ClienteModel> {
  final List<ClienteModel> names;
  ClienteModel result = ClienteModel();

  SearchWidget({required this.names});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        print('voce selecinou ${result}');
        close(context, result); // for closing the search page and going back
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = names.where((element) => element.nome!.toLowerCase().contains(query.toLowerCase()));
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(suggestions.elementAt(index).nome!),
            onTap: () {
              result = suggestions.elementAt(index);
              close(context, result);
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = names.where((element) => element.nome!.toLowerCase().contains(query.toLowerCase()));
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(suggestions.elementAt(index).nome!),
            onTap: () {
              query = suggestions.elementAt(index).nome!;
              result = suggestions.elementAt(index);
              close(context, result);
            },
          );
        });
  }
}

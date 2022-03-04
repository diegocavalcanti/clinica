import 'package:flutter/material.dart';
import '../models/customer.dart';

class SearchWidget extends SearchDelegate<Customer> {
  final List<Customer> names;
  Customer result = Customer.newInstance();

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
    final suggestions = names.where((element) => element.name.toLowerCase().contains(query.toLowerCase()));
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(suggestions.elementAt(index).name),
            onTap: () {
              result = suggestions.elementAt(index);
              close(context, result);
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = names.where((element) => element.name.toLowerCase().contains(query.toLowerCase()));
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(suggestions.elementAt(index).name),
            onTap: () {
              query = suggestions.elementAt(index).name;
              result = suggestions.elementAt(index);
              close(context, result);
            },
          );
        });
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/cliente_controller.dart';

class ClientePageView extends StatelessWidget {
  const ClientePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clientes')),
      body: Consumer<ClienteController>(
        builder: (context, controller, child) {
          return SizedBox(
            //height: 210,
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      controller.cliente.name,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(controller.cliente.responsible),
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue[500],
                    ),
                  ),
                  // const Divider(),
                  ListTile(
                    title: Text(
                      controller.cliente.cel,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(
                      Icons.contact_phone,
                      color: Colors.blue[500],
                    ),
                  ),
                  ListTile(
                    title: Text(controller.cliente.email),
                    leading: Icon(
                      Icons.contact_mail,
                      color: Colors.blue[500],
                    ),
                  ),

                  ListTile(
                    title: Text(controller.cliente.comments),
                    leading: Icon(
                      Icons.contact_page,
                      color: Colors.blue[500],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

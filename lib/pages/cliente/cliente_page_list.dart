// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:clinica/models/cliente_model.dart';
import 'package:clinica/pages/cliente/cliente_page_view.dart';
import 'package:clinica/store/app_Store.dart';
import 'package:clinica/utils/nav.dart';
import 'package:clinica/widgets/popup_menuitem_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cliente_page_form.dart';

class ClientePageList extends StatelessWidget {
  const ClientePageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Pacientes"),
        backgroundColor: Colors.blue,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () async {})],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            goTo(context, ClientePageForm());
          }),
      body: Consumer<AppStore>(builder: (context, store, child) {
        return Container(
            child: store.listaClientes.isEmpty
                ? Center(child: Text("Sem clientes cadastrados"))
                : ListView.builder(
                    itemCount: Provider.of<AppStore>(context).listaClientes.length,
                    itemBuilder: (context, index) {
                      var cliente = Provider.of<AppStore>(context).listaClientes[index];
                      return ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        title: Text(cliente.nome!),
                        subtitle: Row(
                          children: [
                            Text(cliente.celular!),
                            SizedBox(
                              width: 10,
                            ),
                            Text("(" + cliente.responsavel! + ")")
                          ],
                        ),
                        onTap: () async {
                          //await clienteController.loadCliente(cliente.id!);
                          store.cliente = cliente;
                          goTo(context, ClientePageView());
                        },
                        trailing: popupMenuActions(store, cliente),
                      );
                    },
                  ));
      }),
    ));
  }

  PopupMenuButton<PopupMenuItemAction> popupMenuActions(AppStore store, ClienteModel cliente) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: PopupMenuItemAction(action: () {
              store.cliente = cliente;
              goTo(context, ClientePageForm());
            }),
            child: const Text('Editar'),
          ),
          PopupMenuItem(
            value: PopupMenuItemAction(action: () => store.removeCliente(context, cliente)),
            child: const Text('Excluir'),
          ),
        ];
      },
      onSelected: (PopupMenuItemAction option) {
        option.action();
      },
    );
  }

  void _opcoes(BuildContext context, AppStore store, ClienteModel cliente) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFF737373),
          height: 180,
          child: Container(
            child: Column(
              children: [
                ListTile(leading: Icon(Icons.delete), title: Text("Excluir"), onTap: () => store.removeCliente(context, cliente)),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text("Editar"),
                  onTap: () async {
                    store.cliente = cliente;
                    goTo(context, ClientePageForm());
                  },
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                )),
          ),
        );
      },
    );
  }

  Widget iconEditButton(Function() onPressed) {
    return IconButton(icon: Icon(Icons.edit), color: Colors.orange, onPressed: onPressed);
  }

  Widget iconRemoveButton(BuildContext context, Function() remove) {
    return IconButton(
        icon: Icon(Icons.delete),
        color: Colors.red,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Excluir'),
                    content: Text('Confirma a Exclusão?'),
                    actions: [
                      TextButton(
                        child: const Text('Não'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Sim'),
                        onPressed: remove,
                      ),
                    ],
                  ));
        });
  }
}

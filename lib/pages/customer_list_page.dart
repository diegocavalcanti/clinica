// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../widgets/popup_menuitem_action.dart';
import 'package:provider/provider.dart';

import '../controllers/customer_controller.dart';
import '../models/customer.dart';
import '../widgets/search_widget.dart';

class CustomerListPage extends StatelessWidget {
  const CustomerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerController controller = Provider.of<CustomerController>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pacientes"),
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  Customer? result = await showSearch(
                    context: context,
                    delegate: SearchWidget(names: controller.list),
                  );
                  if (result != null) {
                    controller.goToPageEdit(context, result);
                  }
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              controller.goToFormNew(context);
            }),
        body: Container(
          child: ListView.builder(
              itemCount: controller.list.length,
              itemBuilder: (context, index) {
                var customer = controller.list[index];
                return ListTile(
                  // ignore: prefer_const_constructors
                  leading: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  title: Text(customer.name),
                  subtitle: Row(
                    children: [
                      Text(customer.cel),
                    ],
                  ),
                  onTap: () => controller.goToPageEdit(context, customer),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: PopupMenuItemAction(action: () => controller.goToPageEdit(context, customer)),
                          child: Text('Editar'),
                        ),
                        PopupMenuItem(
                          value: PopupMenuItemAction(action: () => controller.remove(context, customer)),
                          child: Text('Excluir'),
                        )
                      ];
                    },
                    onSelected: (PopupMenuItemAction option) {
                      option.action();
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }

  void _opcoes(BuildContext context, Customer customer) {
    CustomerController controller = Provider.of<CustomerController>(context, listen: false);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: const Color(0xFF737373),
          height: 180,
          child: Container(
            child: Column(
              children: [
                ListTile(leading: Icon(Icons.delete), title: Text("Excluir"), onTap: () => controller.remove(context, customer)),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text("Editar"),
                  onTap: () => controller.goToPageEdit(context, customer),
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

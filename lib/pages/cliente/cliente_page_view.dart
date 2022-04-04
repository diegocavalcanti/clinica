// ignore_for_file: prefer_const_constructors

import 'package:clinica/models/atendimento_model.dart';
import 'package:clinica/models/cliente_model.dart';
import 'package:clinica/models/pagamento_model.dart';
import 'package:clinica/pages/atendimento/atendimento_page_form.dart';
import 'package:clinica/pages/cliente/cliente_page_form.dart';
import 'package:clinica/pages/recebimento/recebimento_page_form.dart';
import 'package:clinica/store/app_Store.dart';
import 'package:clinica/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientePageView extends StatelessWidget {
  //ValueNotifier<int> _tabIndex = ValueNotifier(0);

  ClientePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context);
    //final store = context.watch<AppStore>();

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("${store.cliente.nome}"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: 'Dados Pessoais'),
                Tab(text: 'Atendimentos'),
                Tab(text: 'Recebimentos'),
              ],
              onTap: (index) {
                store.tabIndex = index;
              },
            ),
          ),
          body: TabBarView(children: [
            tabDadosPessoais(store),
            tabAtendimentos(context, store),
            tabRecebimentos(context, store)
            //   tabPagamentos(context),
          ]),
          floatingActionButton: FloatingActionButton(
              child: (store.tabIndex == 0) ? Icon(Icons.edit) : Icon(Icons.add),
              onPressed: () {
                // se estiver na tab Dados Pessoais
                if (store.tabIndex == 0) {
                  goTo(context, ClientePageForm());

                  // se estiver na tab atendimentos
                } else if (store.tabIndex == 1) {
                  AtendimentoModel newAtendimento = AtendimentoModel();
                  newAtendimento = newAtendimento.copyWith(idCliente: store.cliente.id, nomeCliente: store.cliente.nome);
                  store.atendimento = newAtendimento;
                  goTo(context, AtendimentoPageForm());

                  // se estiver na tab recebimentos
                } else if (store.tabIndex == 2) {
                  print("Teste");
                  goTo(context, RecebimentoPageForm());
                }
              }),
        ));
  }
}

tabRecebimentos(BuildContext context, AppStore store) {
  return Container();
}

tabDadosPessoais(AppStore store) {
  return Card(
    child: Column(
      children: [
        ListTile(
          title: Text(
            store.cliente.nome ?? '',
          ),
          minLeadingWidth: 100,
          leading: Text(
            'Nome:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: Text(
            store.cliente.celular ?? '',
          ),
          minLeadingWidth: 100,
          leading: Text('Celular:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ),
        ListTile(
          title: Text(store.cliente.email ?? ''),
          minLeadingWidth: 100,
          leading: Text('Email:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ),
        ListTile(
          title: Text(
            store.cliente.responsavel ?? '',
          ),
          minLeadingWidth: 100,
          leading: Text('Responsável:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ),
        ListTile(
          title: Text(store.cliente.observacoes ?? ''),
          minLeadingWidth: 100,
          leading: Text(
            'Observações:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: FutureBuilder<int>(
              future: store.quantidadeAtendimentosCliente(),
              builder: (context, snapshot) {
                return Text(snapshot.data.toString());
              }),
          minLeadingWidth: 100,
          leading: Text(
            'Qtd. Atendimentos:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

tabAtendimentos(BuildContext context, AppStore store) {
  return FutureBuilder<List<AtendimentoModel>>(
      future: store.findAtendimentosByCliente(store.cliente),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text(item.data ?? ''),
                    subtitle: Row(
                      children: [Text(item.texto ?? '')],
                    ),
                    onTap: () {
                      store.atendimento = item;
                      goTo(context, AtendimentoPageForm());
                    });
              });
        } else {
          return Text("Pesquisando...");
        }
      });
}

tabPagamentos(BuildContext context, AppStore store, ClienteModel clienteModel) {
  return FutureBuilder<List<PagamentoModel>>(
      future: store.findPagamentosByCliente(clienteModel),
      builder: (context, snapashot) {
        return ListView.builder(
            itemCount: snapashot.data?.length,
            itemBuilder: (context, index) {
              var item = snapashot.data![index];
              return ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  title: Text(item.dataPagamento ?? ''),
                  subtitle: Row(
                    children: [Text(item.quantidade.toString())],
                  ),
                  onTap: () => {} //controller.goToPageEditAtendimento(context, item.toEntity()),
                  );
            });
      });
}

import 'package:clinica/pages/atendimento_page_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floor/floor.dart';
import 'controllers/atendimento_controller.dart';
import 'controllers/cliente_controller.dart';
import 'db/app_database.dart';
import 'pages/cliente_page_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //final AppDatabase appDatabase = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  final callback = Callback(
    onCreate: (database, version) {
      print('database has been created');
    },
    onOpen: (database) {
      print('database has been opened');
      // database.execute(
      //     'CREATE TABLE IF NOT EXISTS `Customer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `cel` TEXT NOT NULL, `email` TEXT NOT NULL, `responsible` TEXT NOT NULL, `comments` TEXT NOT NULL)');
      // database.execute(
      //    'CREATE TABLE IF NOT EXISTS `Atendimento` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` TEXT NOT NULL, `customer_id` INTEGER NOT NULL, `text` TEXT NOT NULL)');
    },
    onUpgrade: (database, startVersion, endVersion) {
      print('database has been upgraded');
    },
  );

  // create migration
  // final migration1to2 = Migration(1, 2, (database) async {
  //   await database.execute(
  //       'CREATE TABLE IF NOT EXISTS `Customer` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `cel` TEXT NOT NULL, `email` TEXT NOT NULL, `responsible` TEXT NOT NULL, `comments` TEXT NOT NULL)');
  //   await database.execute(
  //       'CREATE TABLE IF NOT EXISTS `Atendimento` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` TEXT NOT NULL, `customer_id` INTEGER NOT NULL, `text` TEXT NOT NULL)');
  // });

  final AppDatabase appDatabase = await $FloorAppDatabase.databaseBuilder('app_database.db').addCallback(callback).build();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ClienteController(appDatabase)),
        ChangeNotifierProvider(create: (ctx) => AtendimentoController(appDatabase))
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clínica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Clínica'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [ClientePageList(), AtendimentoPageList()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),

      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: (int index) => setState(() {
                _currentIndex = index;
              }),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Clientes"),
            BottomNavigationBarItem(icon: Icon(Icons.schedule), label: "Atendimentos"),
            BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: "Pagamentos"),
            BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: "Configurações"),
          ]),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

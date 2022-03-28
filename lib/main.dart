import 'package:clinica/pages/dashboard_page.dart';
import 'package:clinica/store/app_Store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'db/app_database.dart';
import 'pages/atendimento_page_list.dart';
import 'pages/cliente_page_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStore>(create: (_) {
          final store = AppStore();
          store.loadLists();
          return store;
        }),
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
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [Locale("pt", "BR")],
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    AppDatabase.instance.close();

    super.dispose();
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [DashBoardPage(), ClientePageList()];

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
            BottomNavigationBarItem(icon: Icon(Icons.schedule_outlined), label: "Início"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Clientes"),
          ]),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

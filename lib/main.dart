import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:productos_app/Pages/home_page.dart';
import 'package:productos_app/Pages/login_page.dart';
import 'package:productos_app/Pages/producto_page.dart';
import 'package:productos_app/Pages/resgister_page.dart';
import 'package:productos_app/Pages/upload_File_page.dart';
import 'package:productos_app/services/auth_service.dart';
import 'package:productos_app/services/productLine_service.dart';
import 'package:productos_app/services/producto_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

//void main() => runApp(AppState());
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductoService(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductLineService(),
        ),
         ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HuaweiIntern',
      initialRoute: 'home',
      routes: {
        'login': (_) => LoginPage(),
        'home': (_) => HomePage(),
        'producto': (_) => ProductoPage(),
        'register': (_) => RegisterPage(),
        'uploadFile':(_)=> UploadFile(),
        //'demo':(_)=> FirebaseDemoScreen(),
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Color.fromARGB(255, 231, 243, 231),
          appBarTheme: AppBarTheme(color: Colors.indigo, elevation: 0),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.indigo,
            elevation: 0,
          )),
    );
  }
}

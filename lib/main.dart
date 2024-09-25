// ignore_for_file: must_be_immutable

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kaino/network/api.dart';
import 'package:kaino/pages/canvas/index.dart';
import 'package:kaino/pages/login/valification.dart';
import 'package:kaino/pages/profile/history/index.dart';
import 'package:kaino/pages/profile/preference/index.dart';
import 'package:kaino/pages/register/index.dart';
import 'package:kaino/pages/register/success.dart';
import 'package:kaino/pages/renderDetail/index.dart';
import 'package:kaino/pages/rendering/index.dart';
import 'package:kaino/pages/style/index.dart';
import 'package:kaino/pages/twoFA/authDetail.dart';
import 'package:kaino/pages/twoFA/enterCode.dart';
import 'package:kaino/pages/twoFA/index.dart';
import 'package:kaino/pages/twoFA/success.dart';

import 'common/locale/index.dart';
import 'pages/home/index.dart';
import 'pages/login/index.dart';
import 'pages/profile/index.dart';
import 'store/store.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
// can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  Get.lazyPut<ApiConnect>(() => ApiConnect());
  Get.lazyPut(() => Controller());
  // Lock orientation to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  Controller.c.deviceId(iosInfo.identifierForVendor);
  Controller.c.userAgent(iosInfo.utsname.machine);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Controller c = Get.put(Controller());
  Map routes = {
    '/': (context) => Home(),
    '/home': (context) => const Home(),
    '/profile': (context) => const Profile(),
    '/history': (context) => const RenderHistory(),
    '/preference': (context) => const Preference(),
    '/login': (context) => const Login(),
    '/register': (context) => const Register(),
    '/registerSuccess': (context) => const RegisterSuccess(),
    '/twofa': (context) => const TwoFa(),
    '/varification': (context, {arguments}) =>
        Varification(arguments: arguments),
    '/authDetail': (context) => const Authdetail(),
    '/enterCode': (context) => const Entercode(),
    '/AuthSuccess': (context) => const AuthSuccess(),
    '/canvas': (context) => ImageEraseApp(),
    '/style': (context) => const Style(),
    '/rendering': (context) => const Rendering(),
    '/renderDetail': (context, {arguments}) =>
        RenderDetail(arguments: arguments),
    '/renderPreview': (context, {arguments}) =>
        RenderDetail(arguments: arguments),
  };
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('zh', 'CN'),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 74, 146, 194)),
        useMaterial3: true,
      ),
      initialRoute: '/', //2、调用onGenerateRoute处理
      onGenerateRoute: (RouteSettings settings) {
// 统一处理
        final String? name = settings.name;
        final Function? pageContentBuilder = routes[name];
        if (pageContentBuilder != null) {
          if (settings.arguments != null) {
            final Route route = MaterialPageRoute(
                builder: (context) =>
                    pageContentBuilder(context, arguments: settings.arguments));
            return route;
          } else {
            final Route route = MaterialPageRoute(
                builder: (context) => pageContentBuilder(context));
            return route;
          }
        }
        return null;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

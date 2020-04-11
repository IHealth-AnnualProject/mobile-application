import 'dart:collection';
import 'dart:convert';
import 'package:betsbi/home.dart';
import 'package:betsbi/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromPath("assets/cfg/settings.json");
  runApp(Login());
}

class Login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BetsBi',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: 'Login Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalConfiguration cfg = new GlobalConfiguration();
  LinkedHashMap<String, dynamic> dmap = new LinkedHashMap<String, dynamic>();
  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    return await rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  void _setLanguage(String language) async {
    dmap =
        await parseJsonFromAssets('locale/' + language.toLowerCase() + '.json');
    String oldLanguage = cfg.getString("currentLanguage");
    cfg.updateValue("currentLanguage", language);
    cfg.updateValue("language", oldLanguage);
    setState(() {});
  }

  Future loadLanguage(String path) async {
    dmap = await parseJsonFromAssets(path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    loadLanguage(
        'locale/' + cfg.getString('currentLanguage').toLowerCase() + '.json');
    //Locale myLocale = Localizations.localeOf(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final username = TextField(
      obscureText: false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: dmap["UsernameText"] != null ? dmap["UsernameText"] : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final password = TextField(
      obscureText: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: dmap["PasswordText"] != null ? dmap["PasswordText"] : "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(16.0),
      color: Color.fromRGBO(104, 79, 37, 0.8),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
        child: Text(
          dmap["LoginText"] != null ? dmap["LoginText"] : "",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 100),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
    final language = InkWell(
      onTap: () {
        _setLanguage(cfg.getString("language"));
      },
      child: new Text(
        cfg.getString("language"),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
    final forgotPassword = InkWell(
        onTap: () {
          //_setLanguage(cfg.getString("language"));
        },
        child: new Text(
          dmap["ForgotPassword"] != null ? dmap["ForgotPassword"] : "",
          textAlign: TextAlign.center,
        ));
    final signUp = InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register()));
          //_setLanguage(cfg.getString("language"));
        },
        child: new Text(
          dmap["SignUp"] != null ? dmap["SignUp"] : "",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ));
    return Scaffold(
        backgroundColor: Color.fromRGBO(228, 228, 228, 1),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 150,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Container(
                      width: 350.0,
                      child: username,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 350.0,
                      child: password,
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    forgotPassword,
                    SizedBox(
                      height: 45,
                    ),
                    Container(
                      width: 350.0,
                      child: loginButton,
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[language],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          dmap["NoAccount"] != null ? dmap["NoAccount"] : "",
                          style: TextStyle(color: Colors.white),
                        ),
                        signUp,
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeMode(),
      child: const MyApp(),
    ),
  );
}

class ThemeMode with ChangeNotifier {
  bool _lightmode = false;
  changeMode() {
    _lightmode = !_lightmode;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeMode>(context);

    return MaterialApp(
			debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: themeMode._lightmode ? Colors.teal : Colors.blue,
        brightness: themeMode._lightmode ? Brightness.dark : Brightness.light,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _numbers = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
  String _chosenNumber = 'VIII';
  bool _isAnswerPhase = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<ThemeMode>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'carpe numerum'.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          Switch(
            value: themeMode._lightmode,
            onChanged: (bool val) {
              themeMode.changeMode();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Pick a number:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 5,
                padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                shrinkWrap: true,
                children: List.generate(
                  _numbers.length,
                  (index) {
                    return ElevatedButton(
                      onPressed: _isAnswerPhase ? null : () => _chooseNumber(index),
                      child: Text(
                        _numbers[index],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          AnimatedOpacity(
            opacity: _isAnswerPhase ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Your number is:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Text(
                  _chosenNumber,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 88,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Would you like to play again?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _playAgain,
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    const SizedBox(width: 35),
                    ElevatedButton(
                      onPressed: _playAgain,
                      child: const Text(
                        'No',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _chooseNumber(index) {
    setState(() {
      _chosenNumber = _numbers[index];
      _isAnswerPhase = true;
    });
  }

  void _playAgain() {
    setState(() {
      _isAnswerPhase = false;
    });
  }
}

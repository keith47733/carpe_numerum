import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final List<String> _numbers = [
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
  ];
  String _chosenNumber = 'VIII';
  bool _gameStage2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'carpe numerum'.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      //
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
                crossAxisCount: 3,
                padding: const EdgeInsets.fromLTRB(35, 20, 35, 20),
                mainAxisSpacing: 40.0,
                crossAxisSpacing: 40.0,
                shrinkWrap: true,
                children: List.generate(_numbers.length, (index) {
                  return ElevatedButton(
                    onPressed: _gameStage2 ? null : () => _chooseNumber(index),
                    child: Text(
                      _numbers[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          AnimatedOpacity(
            opacity: _gameStage2 ? 1.0 : 0.0,
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
                          fontWeight: FontWeight.bold,
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
                          fontWeight: FontWeight.bold,
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
      _gameStage2 = true;
    });
  }

  void _playAgain() {
    setState(() {
      _gameStage2 = false;
    });
  }
}

import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppState(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Namer App',
          theme: ThemeData(
              useMaterial3: true,
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent)),
          home: HomePage(),
        ));
  }
}

//class to handle changes
//notify others when things change
class AppState with ChangeNotifier {
  //generate random word
  var current = WordPair.random();
  //generate next random word
//notify others of the changes
  void getNextWord() {
    current = WordPair.random();
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //create instance of change notifier
    //watch for changes in change notifier mixin
    var appStateNow = context.watch<AppState>();
    var pair = appStateNow.current;

    return Scaffold(
      body: Column(
        children: [
          Text('A random word:'),
          BigCard(pair: pair),
          //add button
          ElevatedButton(
              onPressed: () {
                appStateNow.getNextWord();
              },
              child: Text('Next'))
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.surface, fontSize: 18);
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asPascalCase,
          style: style,
          semanticsLabel: '${pair.first} ${pair.second}',
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _randomWordPaires = <WordPair>[];
  final _savedWordPaires = Set<WordPair>();

  Widget _biuldList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        if (item.isOdd) return Divider();

        final index = item ~/ 2;

        if (index >= _randomWordPaires.length) {
          _randomWordPaires.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPaires[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alredySaved = _savedWordPaires.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(alredySaved ? Icons.favorite : Icons.favorite_border,
          color: alredySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (alredySaved) {
            _savedWordPaires.remove(pair);
          } else {
            _savedWordPaires.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPaires.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: TextStyle(fontSize: 16.0),
          ),
        );
      });
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text("Saved WordPaires"),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WordPaire Generator"),
        actions: [IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))],
      ),
      body: _biuldList(),
    );
  }
}

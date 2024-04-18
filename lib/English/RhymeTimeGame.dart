import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class RhymeTimeGame extends StatefulWidget {
  @override
  _RhymeTimeGameState createState() => _RhymeTimeGameState();
}

class _RhymeTimeGameState extends State<RhymeTimeGame> {
  final AudioPlayer player = AudioPlayer();
  List<String> words = [
    'king', 'ring', 'table', 'cable', 'blossom', 'awesome', 'broom', 'groom',
    'car',
    'jar',
    'star',
    'spar',
    'moon',
    'soon',
    'book',
    'hook',
    'tree',
    'free',
    'light',
    'might',
    'kite',
    'bite',
    'cat',
    'hat',
    'dog',
    'log',
    'fish',
    'wish',
    'heart',
    'start',
    'hand',
    'land',
    'bell',
    'well',
    'duck',
    'luck',
    'road',
    'toad',
    'dance',
    'chance',
    'glove',
    'love',
    'key',
    'bee',
    'pen',
    'hen',
    'shoe',
    'blue',
    'hair',
    'bear',
    'song',
    'long',
    'cup',
    'pup',
    'ship',
    'flip',
    'smile', 'while',
    'game', 'flame',
    'clock', 'rock',
    'flower', 'power',
    'frog', 'log',
    'chair', 'mare',
    'crown', 'frown',
    'drum', 'hum',
    'fire', 'wire',
    'gate', 'late',
    'glove', 'above',
    'glass', 'mass',
    'mouse', 'house',
    'hat', 'bat',
    'train', 'rain',
    'leaf', 'beef',
    'sock', 'block',
    'night', 'kite',
    'pond', 'bond',
    'spoon', 'moon',
    'snake', 'make',
    'beach', 'peach',
    'road', 'load',
    'king', 'wing',
    'chair', 'mare',
    'ball', 'mall',
    'light', 'fight',
    'board', 'chord',
    'chalk', 'talk',
    'floor', 'door',
    'hand', 'stand'

    // Add more words here...
  ];
  Map<String, String> rhymePairs = {
    'king': 'ring',
    'ring': 'king',
    'table': 'cable',
    'cable': 'table',
    'blossom': 'awesome',
    'awesome': 'blossom',
    'broom': 'groom',
    'groom': 'broom',
    'car': 'jar',
    'star': 'spar',
    'moon': 'soon',
    'book': 'hook',
    'tree': 'free',
    'light': 'might',
    'kite': 'bite',
    'cat': 'hat',
    'dog': 'log',
    'fish': 'wish',
    'heart': 'start',
    'hand': 'land',
    'bell': 'well',
    'duck': 'luck',
    'road': 'toad',
    'dance': 'chance',
    'glove': 'love',
    'key': 'bee',
    'pen': 'hen',
    'shoe': 'blue',
    'hair': 'bear',
    'song': 'long',
    'cup': 'pup',
    'ship': 'flip',
    'smile': 'while',
    'game': 'flame',
    'clock': 'rock',
    'flower': 'power',
    'frog': 'log',
    'chair': 'mare',
    'crown': 'frown',
    'drum': 'hum',
    'fire': 'wire',
    'gate': 'late',
    'glove': 'above',
    'glass': 'mass',
    'mouse': 'house',
    'hat': 'bat',
    'train': 'rain',
    'leaf': 'beef',
    'sock': 'block',
    'night': 'kite',
    'pond': 'bond',
    'spoon': 'moon',
    'snake': 'make',
    'beach': 'peach',
    'road': 'load',
    'king': 'wing',
    'chair': 'mare',
    'ball': 'mall',
    'light': 'fight',
    'board': 'chord',
    'chalk': 'talk',
    'floor': 'door',
    'hand': 'stand',
    'jar': 'car',
    'spar': 'star',
    'soon': 'moon',
    'hook': 'book',
    'free': 'tree',
    'might': 'light',
    'bite': 'kite',
    'hat': 'cat',
    'log': 'dog',
    'wish': 'fish',
    'start': 'heart',
    'land': 'hand',
    'well': 'bell',
    'luck': 'duck',
    'toad': 'road',
    'chance': 'dance',
    'love': 'glove',
    'bee': 'key',
    'hen': 'pen',
    'blue': 'shoe',
    'bear': 'hair',
    'long': 'song',
    'pup': 'cup',
    'flip': 'ship',
    'while': 'smile',
    'flame': 'game',
    'rock': 'clock',
    'power': 'flower',
    'log': 'frog',
    'mare': 'chair',
    'frown': 'crown',
    'hum': 'drum',
    'wire': 'fire',
    'late': 'gate',
    'above': 'glove',
    'mass': 'glass',
    'house': 'mouse',
    'bat': 'hat',
    'rain': 'train',
    'beef': 'leaf',
    'block': 'sock',
    'kite': 'night',
    'bond': 'pond',
    'moon': 'spoon',
    'make': 'snake',
    'peach': 'beach',
    'load': 'road',
    'wing': 'king',
    'mare': 'chair',
    'mall': 'ball',
    'fight': 'light',
    'chord': 'board',
    'talk': 'chalk',
    'door': 'floor',
    'stand': 'hand'
    // Add more pairs here...
  };
  String selectedWord = '';
  String correctOption = '';
  List<String> rhymeOptions = [];
  bool isCorrect = false;
  int totalQuestionsAttempted = 0;
  int totalCorrectAnswers = 0;
  int totalWrongAnswers = 0;

  @override
  void initState() {
    super.initState();
    _setNextQuestion();
  }

  Future<void> playSound(String audiopath) async {
    await player.play(AssetSource(audiopath));
  }

  void _setNextQuestion() {
    setState(() {
      selectedWord = words[Random().nextInt(words.length)];
      correctOption = rhymePairs[selectedWord] ?? '';

      // Generate incorrect options
      rhymeOptions = [];
      while (rhymeOptions.length < 3) {
        String randomWord = words[Random().nextInt(words.length)];
        if (randomWord != selectedWord &&
            randomWord != correctOption &&
            !rhymeOptions.contains(randomWord)) {
          rhymeOptions.add(randomWord);
        }
      }

      // Add correct option to the list
      rhymeOptions.add(correctOption);
      rhymeOptions.shuffle();

      isCorrect = false; // Reset correctness flag
    });
  }

  void checkMatch(String word) {
    setState(() {
      totalQuestionsAttempted++;
      isCorrect = word == correctOption;
    });
    if (isCorrect) {
      totalCorrectAnswers++;
      playSound("audio/yay.mp3");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Correct Match!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "images/Monkey2.gif",
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
      );
    } else {
      totalWrongAnswers++;
      playSound("audio/wrong.mp3");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Wrong Match!'),
          content: Image.asset(
            "images/tomwrong.gif",
            width: 100,
            height: 100,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rhyme Time'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedWord.toUpperCase(),
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'openDyslexic'),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(rhymeOptions.length, (index) {
                String word = rhymeOptions[index];
                return GestureDetector(
                  onTap: () {
                    if (!isCorrect) {
                      checkMatch(word);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        word.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'openDyslexic',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _setNextQuestion();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Progress Report'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: totalCorrectAnswers / totalQuestionsAttempted >= 0.6
                        ? Colors.green
                        : Colors.red,
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Score: ${(totalCorrectAnswers / totalQuestionsAttempted * 100).toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 200,
                    child: charts.BarChart(
                      _createSampleData(),
                      animate: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Total Questions Attempted: $totalQuestionsAttempted'),
                  Text('Total Correct Answers: $totalCorrectAnswers'),
                  Text('Total Wrong Answers: $totalWrongAnswers'),
                ],
              ),
            ),
          );
        },
        child: Icon(Icons.bar_chart),
      ),
    );
  }

  List<charts.Series<ProgressData, String>> _createSampleData() {
    final List<ProgressData> data = [
      ProgressData('Correct', totalCorrectAnswers),
      ProgressData('Wrong', totalWrongAnswers),
    ];

    return [
      charts.Series<ProgressData, String>(
        id: 'Progress',
        domainFn: (ProgressData progress, _) => progress.status,
        measureFn: (ProgressData progress, _) => progress.value,
        data: data,
        colorFn: (ProgressData progress, _) {
          if (progress.status == 'Correct') {
            return charts.MaterialPalette.green.shadeDefault;
          } else {
            return charts.MaterialPalette.red.shadeDefault;
          }
        },
        labelAccessorFn: (ProgressData progress, _) =>
            '${progress.status}: ${progress.value}',
      )
    ];
  }
}

class ProgressData {
  final String status;
  final int value;

  ProgressData(this.status, this.value);
}

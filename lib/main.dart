import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  // 1. 위젯의 상황이 변경될 때마다 자동으로 호출되느 build메소드를 정의해야함
  Widget build(BuildContext context) {
    // 2. MyHomePage는 watch 메서드를 사용하여 앱의 현재 상태에 관한 변경사항을 추적합니다.
    var appState = context.watch<MyAppState>();

    // 3.모든 build 메서드는 위젯 또는 중첩된 위젯 트리(좀 더 일반적임)를 반환해야 합니다. 여기서 최상위 위젯은 Scaffold입니다
    return Scaffold(
      // 4. Column은 Flutter에서 가장 기본적인 레이아웃 위젯 중 하나입니다. Column은 위에서 아래로
      body: Column(
        children: [
          // 5.첫 번째 단계에서 이 Text 위젯을 변경했습니다.
          Text('A random AWESOME idea:'),
          // 6. 이 두 번째 Text 위젯은 appState를 사용하고 해당 클래스의 유일한 멤버인 current(즉, WordPair)에 액세스합니다.
          Text(appState.current.asUpperCase),

          // ↓ Add this.
          ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next'))
        ],
      ),
    );
  }
}

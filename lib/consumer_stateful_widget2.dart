import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final _provider = StateProvider((ref) => const Data(0, 0));

  @override
  Widget build(BuildContext context) {
    print('state build');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Label(
              'data1',
              'data1: ${ref.watch(_provider).data1}',
            ),
            Label(
              'data1 select ',
              'data1 select:${ref.watch(_provider.select((value) => value.data1))}',
            ),
            Label(
              'data2',
              'data2: ${ref.watch(_provider).data2}',
            ),
            Label(
              'data2 select',
              'data2 select: ${ref.watch(_provider.select((value) => value.data2))}',
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, child) {
        return FloatingActionButton(
          onPressed: () => ref
              .watch(_provider.notifier)
              .update((state) => Data(state.data1 + 1, state.data2)),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}

class Data {
  const Data(this.data1, this.data2);
  final int data1;
  final int data2;
}

class Label extends StatelessWidget {
  const Label(this.id, this.text, {Key? key}) : super(key: key);

  final String id;
  final String text;

  @override
  Widget build(BuildContext context) {
    print('build $id = $text');
    return Text(
      text,
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

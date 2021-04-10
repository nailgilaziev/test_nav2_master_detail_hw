import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_text_controller/data.dart';
import 'package:test_text_controller/ui/detail_editor_hw.dart';
import 'package:test_text_controller/ui/master_list.dart';
import 'package:test_text_controller/ui/no_selection.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

final itemPanelKey = GlobalKey(debugLabel: 'itemPanelKey');
final navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'navigatorKey');

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ProviderSubscription<void> sub;

  @override
  void initState() {
    sub = ProviderScope.containerOf(context, listen: false)
        .listen(selectedStateProvider, mayHaveChanged: (r) {
      setState(() {}); // rebuild navigator pages
    });
    super.initState();
  }

  @override
  void dispose() {
    sub.close();
    super.dispose();
  }

  bool twoPanelMode = true;

  void switchMode() {
    setState(() {
      twoPanelMode = !twoPanelMode;
    });
  }

  List<Widget> getPages() {
    final id = context.read(selectedStateProvider).state;
    final showDetails = id != null;
    final pages = [
      MasterList(),
      if (showDetails) DetailEditorHW(key: itemPanelKey),
    ];
    if (!twoPanelMode) return pages;
    return [
      Row(
        children: [
          Expanded(child: pages[0]),
          Expanded(
              child: pages.length > 1 ? pages[1] : const NoSelectionPage()),
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Press action button to switch panel mode'),
        actions: [
          IconButton(
              tooltip: 'Switch mode: navigation pages or master detail panels',
              icon: Icon(
                twoPanelMode ? Icons.view_column : Icons.line_weight,
                color: twoPanelMode ? Colors.orangeAccent : Colors.white,
              ),
              onPressed: switchMode),
        ],
      ),
      body: Navigator(
          onPopPage: _handleNavigatorPop,
          pages: getPages().map((e) => MaterialPage<void>(child: e)).toList()),
    );
  }

  // Handle Navigator.pop for any routes in our stack
  bool _handleNavigatorPop(Route<dynamic> route, dynamic result) {
    print('._handleNavigatorPop(route,result)');
    // Ask the route if it can handle pop internally... (has own stack)
    if (route.didPop(result)) {
      // router hasn't internal stack, so we will pop one level in our stack
      // but router already create the animation of popping, so we must actualize our stack
      print('._handleNavigatorPop() ask us to pop one level');
      context.read(selectedStateProvider).state = null;

      return true;
    } else {
      print('route.didPop() false. It means that it has internal stack');
      return false; // or return true? when it happens? what the case?
    }
  }
}

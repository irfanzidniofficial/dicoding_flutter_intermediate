import 'package:advanced_navigation_return_data/routes/page_manager.dart';
import 'package:advanced_navigation_return_data/routes/router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const QuotesApp());
}

class QuotesApp extends StatefulWidget {
  const QuotesApp({super.key});

  @override
  State<QuotesApp> createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  late MyRouterDelegate myRouterDelegate;

  @override
  void initState() {
    super.initState();
    myRouterDelegate = MyRouterDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PageManager>(
      create: (_) => PageManager(),
      child: MaterialApp(
        title: 'Quotes App',

        /// todo 4: change Navigator widget to Router widget
        home: Router(
          routerDelegate: myRouterDelegate,

          /// todo 5: add backButtonnDispatcher to handle System Back Button
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}

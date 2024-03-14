import 'package:advanced_navigation_redirection/db/auth_repository.dart';
import 'package:advanced_navigation_redirection/provider/auth_provider.dart';
import 'package:advanced_navigation_redirection/routes/router_delegate.dart';
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
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    authProvider = AuthProvider(authRepository);

    myRouterDelegate = MyRouterDelegate(authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => authProvider,
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

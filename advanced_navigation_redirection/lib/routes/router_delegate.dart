import 'package:advanced_navigation_redirection/db/auth_repository.dart';
import 'package:advanced_navigation_redirection/screen/login_screen.dart';
import 'package:advanced_navigation_redirection/screen/register_screen.dart';
import 'package:advanced_navigation_redirection/screen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../model/quote.dart';
import '../screen/quote_detail_screen.dart';
import '../screen/quotes_list_screen.dart';

/// todo 1: create new class router-delegate
class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  /// todo 2: add navigator key,
  /// change other method, and
  /// add the variable to Navigator widget
  final GlobalKey<NavigatorState> _navigatorKey;

  final AuthRepository authRepository;

  MyRouterDelegate(this.authRepository)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// todo 3: move Navigator widget to build method,
  /// add selected quote variable,
  /// delete setState function, and
  /// change with notifiyListener().
  String? selectedQuote;

  // add variable untuk mengelola statue login dan navigatinon stack

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;

  // add navigation stack baru berdasarkan kondisi dari sesi login

  List<Page> get _splashStack => [
        const MaterialPage(
          key: ValueKey("SplashPage"),
          child: SplashScreen(),
        )
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("LoginPage"),
          child: LoginScreen(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
              key: const ValueKey("RegisterPage"),
              child: RegisterScreen(
                onRegister: () {
                  isRegister = false;
                  notifyListeners();
                },
                onLogin: () {
                  isRegister = false;
                  notifyListeners();
                },
              ))
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("QuotesListPage"),
          child: QuotesListScreen(
            quotes: quotes,
            onTapped: (String quoteId) {
              selectedQuote = quoteId;
              notifyListeners();
            },
            onLogout: () {
              isLoggedIn = false;
              notifyListeners();
            },
          ),
        ),
        if (selectedQuote != null)
          MaterialPage(
            key: ValueKey(selectedQuote),
            child: QuoteDetailsScreen(
              quoteId: selectedQuote!,
            ),
          ),
      ];

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegister = false;

        selectedQuote = null;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    /* Do Nothing */
  }
}

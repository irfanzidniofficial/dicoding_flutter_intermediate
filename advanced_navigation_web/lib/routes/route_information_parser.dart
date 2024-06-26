import 'package:advanced_navigation_web/model/page_configutation.dart';
import 'package:flutter/material.dart';

class MyRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouterInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location.toString());

    @override
    RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
      if (configuration.isUnknownPage) {
        return const RouteInformation(location: '/unknown');
      } else if (configuration.isSplashPage) {
        return const RouteInformation(location: '/splash');
      } else if (configuration.isRegisterPage) {
        return const RouteInformation(location: '/register');
      } else if (configuration.isLoginPage) {
        return const RouteInformation(location: '/login');
      } else if (configuration.isHomePage) {
        return const RouteInformation(location: '/');
      } else if (configuration.isDetailPage) {
        return RouteInformation(location: '/quote/${configuration.quoteId}');
      } else {
        return null;
      }
    }

    if (uri.pathSegments.isEmpty) {
      // without path parameter => "/"
      return PageConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      // path parameter => "/aaa"
      final first = uri.pathSegments[0].toLowerCase();

      if (first == 'home') {
        return PageConfiguration.home();
      } else if (first == 'login') {
        return PageConfiguration.login();
      } else if (first == 'register') {
        return PageConfiguration.register();
      } else if (first == 'splash') {
        return PageConfiguration.splash();
      } else {
        return PageConfiguration.unknown();
      }
    } else if (uri.pathSegments.length == 2) {
      // path parameter => "/aaa/bbb"
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      final quoteId = int.tryParse(second) ?? 0;
      if (first == 'quote' && (quoteId >= 1 && quoteId <= 5)) {
        return PageConfiguration.detailQuote(second);
      } else {
        return PageConfiguration.unknown();
      }
    } else {
      return PageConfiguration.unknown();
    }
  }
}

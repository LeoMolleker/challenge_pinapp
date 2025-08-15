import 'package:challenge_pinapp/presentation/ui/screens/detail_page.dart';
import 'package:challenge_pinapp/presentation/ui/screens/home_page.dart';
import 'package:flutter/material.dart';

import 'constants/routes_names.dart';

abstract class Routes {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return <String, Widget Function(BuildContext)>{
      RoutesNames.home: (context) => const HomePage(),
      RoutesNames.detail: (context) {
        final postId = ModalRoute.of(context)?.settings.arguments as int;
        return DetailPage(postId: postId,);
      },
    };
  }
}

import 'package:challenge_pinapp/presentation/controllers/detail/detail_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/ui/core/extensions/context_extension.dart';
import 'package:challenge_pinapp/presentation/ui/screens/detail_page.dart';
import 'package:challenge_pinapp/presentation/ui/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/keys.dart';
import 'constants/routes_names.dart';
import '../../../core/injector.dart';

abstract class Routes {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return <String, Widget Function(BuildContext)>{
      RoutesNames.home: (context) => const HomePage(),
      RoutesNames.detail: (context) {
        final arguments = context.routeArguments as Map<String, dynamic>;
        final postId = arguments[Keys.postIdKey] as int;
        final isLiked = arguments[Keys.isLikedKey] as bool?;
        return BlocProvider(
          create: (context) => Injector.get<DetailBloc>()..getPostComments(postId),
          child: DetailPage(postId: postId, isLiked: isLiked),
        );
      },
    };
  }
}

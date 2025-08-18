import 'package:challenge_pinapp/presentation/controllers/detail/detail_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/ui/screens/detail_page.dart';
import 'package:challenge_pinapp/presentation/ui/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/routes_names.dart';
import '../../../core/injector.dart';

abstract class Routes {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return <String, Widget Function(BuildContext)>{
      RoutesNames.home: (context) => const HomePage(),
      RoutesNames.detail: (context) {
        final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
        final postId = arguments['postId'] as int;
        final canLike = arguments['canLike'] as bool;
        return BlocProvider(
          create: (context) => Injector.get<DetailBloc>()..getPostComments(postId),
          child: DetailPage(postId: postId, canLike: canLike,),
        );
      },
    };
  }
}

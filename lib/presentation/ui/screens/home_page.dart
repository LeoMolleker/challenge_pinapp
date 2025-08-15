import 'package:challenge_pinapp/core/extensions/context_extension.dart';
import 'package:challenge_pinapp/core/extensions/style_extension.dart';
import 'package:challenge_pinapp/core/injector.dart';
import 'package:challenge_pinapp/domain/entities/post.dart';
import 'package:challenge_pinapp/presentation/controllers/worker.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/home_search_bar.dart';
import 'package:challenge_pinapp/presentation/ui/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/ui_labels.dart';
import '../../controllers/home/home_bloc_controller.dart';
import '../../controllers/home/home_state.dart';
import '../models/button_content.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/result_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Posts', style: context.titleLargeTheme?.black.bold),
      ),
      body: BlocProvider(
        create: (BuildContext context) => Injector.get<HomeBloc>()..getPosts(),
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) => previous.posts != current.posts || previous.searchValue != current.searchValue,
          builder: (context, state) => switch (state.posts) {
            Success<List<Post>>() => () {
              final posts = state.filteredPosts();
              return posts.isEmpty
                  ? ResultIndicator.empty(
                      title: UiLabels.emptyPostsTitle,
                      description: UiLabels.emptyPostDescription,
                      button: _retryButton(context),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spaceXLarge,
                      ),
                      child: Column(
                        spacing: AppDimensions.spaceLarge,
                        children: [
                          HomeSearchBar(
                            showSuffixIcon: true,
                            onChanged: (value) {
                              context.read<HomeBloc>().getFilteredPosts(value);
                            },
                            onSuffixPressed: () {
                              context.read<HomeBloc>().getFilteredPosts('');
                            }
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(
                                  top: AppDimensions.spaceLarge,
                                ),
                                child: PostCard(post: posts[index]),
                              ),
                              itemCount: posts.length,
                            ),
                          ),
                        ],
                      ),
                    );
            }(),

            Loading<List<Post>>() => LoadingIndicator(
              message: UiLabels.loadingPosts,
            ),

            Error<List<Post>>() => ResultIndicator.error(
              title: state.posts.error!.title,
              description: state.posts.error!.description,
              button: _retryButton(context),
            ),
          },
        ),
      ),
    );
  }

  ButtonContent _retryButton(BuildContext context) => ButtonContent(
    onPressed: () => context.read<HomeBloc>().getPosts(),
    text: UiLabels.retryLabel,
  );
}

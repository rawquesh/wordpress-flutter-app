import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/wp_config.dart';
import '../../models/article.dart';
import '../../repositories/posts/post_repository.dart';

/// Provides Feature Posts
final featurePostController = FutureProvider<List<ArticleModel>>((ref) async {
  final repo = ref.read(postRepoProvider);

  /// If popular post plugin is enabled and no custom feature category is provided
  List<ArticleModel> allPosts = await repo.getPostByTag(
    tagID: WPConfig.featuredTagID,
    pageNumber: 1,
  );

  if (allPosts.isEmpty) {
    debugPrint('all posts is empty');
    allPosts = await repo.getAllPost(pageNumber: 1);
  } else {
    debugPrint('all posts is not empty');
  }

  final updatedList =
      allPosts.map((e) => e.copyWith(heroTag: '${e.link}feature')).toList();

  return updatedList;
});

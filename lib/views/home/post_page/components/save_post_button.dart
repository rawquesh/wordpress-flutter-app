import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/ads/ad_state_provider.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/controllers/posts/saved_post_controller.dart';
import '../../../../core/models/article.dart';

class SavePostButton extends ConsumerWidget {
  const SavePostButton({
    Key? key,
    required this.article,
    this.iconSize = 18,
  }) : super(key: key);

  final ArticleModel article;
  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(savedPostController);
    bool isSaved = saved.value?.contains(article) ?? false;
    bool isSaving = ref.watch(savedPostController.notifier).isSavingPost;

    return InkWell(
      onTap: () async {
        ref.read(loadInterstitalAd);
        if (isSaved) {
          await ref
              .read(savedPostController.notifier)
              .removePostFromSaved(article.id);
          Fluttertoast.showToast(msg: 'article_removed_message'.tr());
        } else {
          await ref.read(savedPostController.notifier).addPostToSaved(article);
          Fluttertoast.showToast(msg: 'article_saved_message'.tr());
        }
      },
      child:Row(
        children: [
          IconButton(
            onPressed: () async {
              ref.read(loadInterstitalAd);
              if (isSaved) {
                await ref
                    .read(savedPostController.notifier)
                    .removePostFromSaved(article.id);
                Fluttertoast.showToast(msg: 'article_removed_message'.tr());
              } else {
                await ref.read(savedPostController.notifier).addPostToSaved(article);
                Fluttertoast.showToast(msg: 'article_saved_message'.tr());
              }
            },
           icon:Icon(Icons.favorite,size: 25,),
            color:isSaved? Colors.red:HexColor("#F5E6CA"),

          ),
          Text('222',style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}



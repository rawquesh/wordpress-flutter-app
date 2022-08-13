import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_pro/core/components/app_video.dart';

import '../../../config/wp_config.dart';
import '../../../core/components/network_image.dart';
import '../../../core/constants/constants.dart';
import '../../../core/models/article.dart';
import '../../../core/utils/app_utils.dart';
import 'components/post_page_body.dart';

class PostPage extends StatelessWidget {
  const PostPage({
    Key? key,
    required this.article,
    this.isHeroDisabled = false,
  }) : super(key: key);
  final ArticleModel article;
  final bool isHeroDisabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#006199'),
      appBar: AppBar(
        backgroundColor: HexColor('#006199'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),

        elevation: 6,
        title: Text(
          article.title,
          overflow: TextOverflow.clip,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Freight',
            fontWeight: FontWeight.w400,
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 6,bottom: 6),
        //   child: ElevatedButton(
        //
        //     style: ElevatedButton.styleFrom(
        //       shape: const CircleBorder(),
        //       primary: AppColors.cardColorDark.withOpacity(0.3),
        //       elevation: 0,
        //     ),
        //     onPressed: () {
        //       Navigator.pushReplacementNamed(context, AppRoutes.entryPoint,
        //           );
        //     },
        //     child: Icon(
        //       Icons.adaptive.arrow_back_rounded,
        //       color: Colors.white,
        //       size: 18,
        //     ),
        //   ),
        // ),
      ),
      body: SafeArea(
        bottom: false,
        top: article.tags.contains(WPConfig.videoTagID),
        child: Scrollbar(
          child: ListView(
            children: [
              article.tags.contains(WPConfig.videoTagID)
                  ? CustomVideoRenderer(article: article)
                  : AspectRatio(
                      aspectRatio: AppDefaults.aspectRatio,
                      child: isHeroDisabled
                          ? Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                              ),
                              child: NetworkImageWithLoader(
                                article.featuredImage,
                                fit: BoxFit.cover,
                                borderRadius: BorderRadius.zero,
                              ),
                            )
                          : Hero(
                              tag: article.heroTag,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 7,
                                ),
                                child: NetworkImageWithLoader(
                                  article.featuredImage,
                                  fit: BoxFit.cover,
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                    ),
              PostPageBody(article: article),
            ],
          ),
        ),
      ),

      // floatingActionButton: Consumer(builder: (context, ref, child) {
      //   return FloatingActionButton.extended(
      //     foregroundColor: Colors.white,
      //     onPressed: () {
      //       Navigator.pushNamed(context, AppRoutes.comment, arguments: article);
      //     },
      //     label: Text('load_comments'.tr()),
      //     icon: const Icon(Icons.comment_rounded),
      //   );
      // }),
    );
  }
}

/// Used for rendering vidoe on top
class CustomVideoRenderer extends StatelessWidget {
  const CustomVideoRenderer({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    printWrapped('article: ${article.content}');
    return Html(
      data: article.content,
      tagsList: const ['html', 'body', 'figure', 'video'],
      style: {
        'body': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
        'figure': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
        ),
      },
      onLinkTap: (String? url, RenderContext renderCtx,
          Map<String, String> attributes, _) {
        if (url != null) {
          AppUtil.openLink(url);
        } else {
          Fluttertoast.showToast(msg: 'Cannot launch this url');
        }
      },
      customRender: {
        'video': (RenderContext renderContext, Widget child) {
          return AppVideo(
            url: renderContext.tree.element!.attributes['src'].toString(),
          );
        },
      },
    );
  }
}


/*

 */
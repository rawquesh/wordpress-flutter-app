import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_pro/views/home/post_page/components/save_post_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unicons/unicons.dart';

import '../../../../config/wp_config.dart';
import '../../../../core/components/app_video.dart';
import '../../../../core/components/banner_ad.dart';
import '../../../../core/components/network_image.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/models/article.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/app_utils.dart';
import 'post_meta_data.dart';

class PostPageBody extends StatelessWidget {
  const PostPageBody({Key? key, required this.article}) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!article.tags.contains(WPConfig.videoTagID)) AppSizedBox.h16,

        /// Post Info
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: AnimationConfiguration.toStaggeredList(
                childAnimationBuilder: (child) => SlideAnimation(
                  duration: AppDefaults.duration,
                  verticalOffset: 50.0,
                  horizontalOffset: 0,
                  child: child,
                ),
                children: [
                  AppSizedBox.h10,
                  //date
                  // PostCategoriesName(article: article),
                  const BannerAdWidget(),
                  ArticleHtmlConverter(article: article),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: PostMetaData(article: article),
                      ),
                    ],
                  ),
                  const BannerAdWidget(),
                  const SizedBox(height: 12),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: HexColor('#F5E6CA'),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.refresh,
                                  color: Colors.blue.shade800,
                                )),
                            Text(
                              'INSPIRE',
                              style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SavePostButton(article: article),
                        Padding(
                          padding: const EdgeInsets.only(right: 6, left: 3),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.comment,
                                        arguments: article);
                                  },
                                  icon: const Icon(
                                    UniconsLine.comment,
                                    color: Colors.orange,
                                  )
                                  // Image.asset('assets/icons/comment.png',color: Colors.orange,)

                                  ),
                              const Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Text(
                                  '14',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 10),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () async =>
                                      await Share.share(article.link),
                                  icon: const Icon(
                                    UniconsLine.share,
                                    color: Colors.white,
                                  )
                                  // SvgPicture.asset('assets/icons/share.svg',color: Colors.blue,),

                                  ),
                              const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Text(
                                  '33',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        AppSizedBox.h10,
        const Divider(height: 0),
      ],
    );
  }
}

class ArticleHtmlConverter extends StatelessWidget {
  const ArticleHtmlConverter({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: article.content,
      shrinkWrap: false,
      style: {
        'body': Style(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          fontSize: const FontSize(16.0),
          lineHeight: const LineHeight(1.4),
          color: Colors.white70,
          fontFamily: 'Avenir',
        ),
        'figure': Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
      },
      onImageTap: (String? url, RenderContext context1,
          Map<String, String> attributes, _) {
        if (url != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewImageFullScreen(url: url),
            ),
          );
        } else {
          Fluttertoast.showToast(msg: 'Can\'t find image link');
        }
      },
      customRender: {
        'video': (RenderContext renderContext, Widget child) {
          if (article.tags.contains(WPConfig.videoTagID)) {
            return const SizedBox();
          } else {
            return AppVideo(
              url: renderContext.tree.element!.attributes['src'].toString(),
            );
          }
        },
      },
      onLinkTap: (url, renderCtx, _, __) {
        if (url == null) {
          Fluttertoast.showToast(msg: 'Error parsing url');
        } else {
          AppUtil.openLink(url);
        }
      },
    );
  }
}

class ViewImageFullScreen extends StatelessWidget {
  const ViewImageFullScreen({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: InteractiveViewer(
          child: Hero(
            tag: url,
            child: NetworkImageWithLoader(
              url,
              radius: 0,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

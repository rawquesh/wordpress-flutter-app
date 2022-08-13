import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/ads/ad_state_provider.dart';
import '../../../core/components/network_image.dart';
import '../../../core/constants/constants.dart';
import '../../../core/controllers/auth/auth_controller.dart';
import '../../../core/controllers/auth/auth_state.dart';
import '../../../core/controllers/comments/comments_controllers.dart';
import '../../../core/models/article.dart';
import '../../../core/utils/app_utils.dart';
import '../../auth/login_page.dart';
import 'components/all_comments.dart';
import 'components/comment_reply_text_field.dart';
import 'components/comment_text_field.dart';
import 'components/user_comments.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticleModel article;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  bool isInReplyMode = false;
  int parentcommentID = 0;
  String replyUserName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.text_snippet,color: Colors.white,),
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close,color: Colors.black,)),
        ],
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('View Comments',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'FreightText-Book.otf'
              ),


            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 3,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 36,
            //   width: 60,
            //   child: NetworkImageWithLoader(
            //     widget.article.featuredImage,
            //     radius: 8.0,
            //   ),
            // ),
            // AppSizedBox.w16,
            // Expanded(
            //   child: AutoSizeText(
            //     widget.article.title,
            //     maxLines: 2,
            //     style: Theme.of(context).textTheme.bodyText1,
            //   ),
            // ),
          ],
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       await Share.share(widget.article.link);
        //     },
        //     icon: const Icon(IconlyLight.send),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(AppDefaults.padding),
              //       child: Text(
              //         'all_comments'.tr(),
              //         style: Theme.of(context).textTheme.headline6,
              //       ),
              //     ),
              //     const Spacer(),
              //   ],
              // ),

              // const Divider(),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    ref.watch(loadInterstitalAd);
                    final commentProvider =
                        ref.watch(postCommentController(widget.article.id));
                    final controller = ref.watch(
                        postCommentController(widget.article.id).notifier);

                    if (commentProvider.initialLoaded == false) {
                      return const LoadingComments();
                    } else if (commentProvider.comments.isEmpty) {
                      return const CommentIsEmpty();
                    } else if (commentProvider.refreshError) {
                      return Center(child: Text(commentProvider.errorMessage));
                    } else {
                      return AllComments(
                        allComments: commentProvider.comments,
                        articleID: widget.article.id,
                        handlePagination: controller.handlePagination,
                        onRefresh: controller.onRefresh,
                        onReply: (String userName, int commentID) {
                          final authState = ref.watch(authController);
                          if (authState is AuthLoggedIn) {
                            replyUserName = userName;
                            parentcommentID = commentID;
                            isInReplyMode = true;
                            setState(() {});
                          } else {
                            Fluttertoast.showToast(
                                msg: 'You must be logged in to reply');
                          }
                        },
                      );
                    }
                  },
                ),
              ),


              isInReplyMode
                  ? WriteReplySection(
                      postID: widget.article.id,
                      parentCommentId: parentcommentID,
                      userName: replyUserName,
                      onCancel: () {
                        replyUserName = '';
                        parentcommentID = 0;
                        isInReplyMode = false;
                        setState(() {});
                        AppUtil.dismissKeyboard(context: context);
                      },
                    )
                  : WriteCommentSection(postID: widget.article.id),

            ],
          ),
        ),
      ),
    );
  }
}

class LoadingComments extends StatelessWidget {
  const LoadingComments({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: List.generate(4, (index) => const DummyUserComment())),
    );
  }
}

class WriteCommentSection extends ConsumerWidget {
  const WriteCommentSection({
    Key? key,
    required this.postID,
  }) : super(key: key);

  final int postID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authController);
    if (authState is AuthLoggedIn) {
      return
        Row(
          children: [
            Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image.asset(
                       'assets/others/man.jpeg',
                    fit: BoxFit.cover,
                    ),
                    clipBehavior: Clip.antiAlias,

                  ),
                ),
            ),
            Expanded(
                flex: 1,
                child: CommentTextField(postId: postID)),
          ],
        );
    } else {
      return Row(
        children: [
        SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                    (v) => false);
          },
          child: Text('login_to_write_comment'.tr()),
        ),
      ),

        ],
      );
    }
  }
}





class WriteReplySection extends ConsumerWidget {
  const WriteReplySection({
    Key? key,
    required this.postID,
    required this.parentCommentId,
    required this.userName,
    required this.onCancel,
  }) : super(key: key);

  final int postID;
  final int parentCommentId;
  final String userName;
  final void Function() onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authController);
    if (authState is AuthLoggedIn) {
      return ReplyTextField(
        postId: postID,
        parentCommentID: parentCommentId,
        userName: userName,
        onCancel: onCancel,
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (v) => false);
          },
          child: Text('login_to_write_comment'.tr()),
        ),
      );
    }
  }
}

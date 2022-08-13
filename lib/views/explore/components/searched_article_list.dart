import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/components/list_view_responsive.dart';
import '../../../core/constants/constants.dart';
import '../../../core/models/article.dart';
import '../../../core/utils/responsive.dart';

class SearchedArticleList extends StatelessWidget {
  const SearchedArticleList({
    Key? key,
    required List<ArticleModel> searchedList,
    required this.isSearching,
  })  : _searchedList = searchedList,
        super(key: key);

  final List<ArticleModel> _searchedList;
  final bool isSearching;

  @override
  Widget build(BuildContext context) {
    return isSearching
        ? Center(
            child: Column(
              children: const [
                SizedBox(height: 16),
                CircularProgressIndicator.adaptive(),
                SizedBox(height: 16),
              ],
            ),
          )
        : _searchedList.isEmpty
            ? const SearchedListEmpty()
            : Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: ResponsiveListView(
                  data: _searchedList,
                  handleScrollWithIndex: (v) {},
                  isInSliver: false,
                  shrinkWrap: true,
                  isDisabledScroll: true,
                ),
              );
  }
}

class SearchedListEmpty extends StatelessWidget {
  const SearchedListEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        Center(
          child: Responsive(
            mobile: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Image.asset(AppImages.emptyPost),
            ),
            tablet: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Image.asset(AppImages.emptyPost),
            ),
          ),
        ),
        AppSizedBox.h16,
        AppSizedBox.h16,
        Text(
          'search_empty'.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6,
        ),
        AppSizedBox.h16,
        Text(
          'search_empty_message'.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

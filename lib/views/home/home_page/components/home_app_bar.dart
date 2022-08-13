import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/models/category.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/themes/theme_manager.dart';

class HomeAppBarWithTab extends StatelessWidget {
  const HomeAppBarWithTab({
    Key? key,
    required this.categories,
    required this.tabController,
    required this.forceElevated,
  }) : super(key: key);

  final List<CategoryModel> categories;
  final TabController tabController;

  final bool forceElevated;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.primary,
      elevation: 1,
      pinned: true,
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,
      forceElevated: forceElevated,
      title: const Text(
        'Home Feeds',
      ),
      titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.notification),
          icon: const Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
          icon: const Icon(
            Icons.filter_list,
            color: Colors.white,
            size: 27,

          ),
        ),
      ],
    );
  }
}

class HorizontalAppLogo extends ConsumerWidget {
  const HorizontalAppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(isDarkMode(context));
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Image.asset(
        isDark ? AppImages.horizontalLogoDark : AppImages.horizontalLogo,
        fit: BoxFit.contain,
      ),
    );
  }
}

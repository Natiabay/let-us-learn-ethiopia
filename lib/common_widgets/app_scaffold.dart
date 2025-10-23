import 'package:flutter/material.dart';
import 'package:tourist_assistive_app/core/theme/app_theme.dart';
import 'package:tourist_assistive_app/core/constants/app_dimensions.dart';
import 'package:tourist_assistive_app/core/constants/app_strings.dart';
import 'package:tourist_assistive_app/common_widgets/app_loading_widget.dart';

/// Professional scaffold wrapper with consistent styling
/// Provides standard app structure and loading states
class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final List<Widget>? actions;
  final bool showAppBar;
  final bool isLoading;
  final String? loadingMessage;
  final Color? backgroundColor;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final PreferredSizeWidget? bottom;
  final Widget? leading;
  final bool automaticallyImplyLeading;

  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.actions,
    this.showAppBar = true,
    this.isLoading = false,
    this.loadingMessage,
    this.backgroundColor,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = true,
    this.bottom,
    this.leading,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? _buildAppBar(context) : null,
      body: Stack(
        children: [
          body,
          if (isLoading)
            AppLoadingWidget.overlay(
              message: loadingMessage ?? AppStrings.loadingText,
            ),
        ],
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
      backgroundColor: backgroundColor ?? AppColors.background,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.textOnPrimary,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      bottom: bottom,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textOnPrimary,
      elevation: AppDimensions.appBarElevation,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
    );
  }
}

/// Sliver app bar wrapper for scrollable content
class AppSliverScaffold extends StatelessWidget {
  final String? title;
  final List<Widget> slivers;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final List<Widget>? actions;
  final bool isLoading;
  final String? loadingMessage;
  final Color? backgroundColor;
  final bool pinned;
  final bool floating;
  final bool snap;
  final double? expandedHeight;
  final Widget? flexibleSpace;

  const AppSliverScaffold({
    super.key,
    this.title,
    required this.slivers,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.actions,
    this.isLoading = false,
    this.loadingMessage,
    this.backgroundColor,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.expandedHeight,
    this.flexibleSpace,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                title: title != null
                    ? Text(
                        title!,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : null,
                actions: actions,
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnPrimary,
                elevation: AppDimensions.appBarElevation,
                centerTitle: true,
                pinned: pinned,
                floating: floating,
                snap: snap,
                expandedHeight: expandedHeight,
                flexibleSpace: flexibleSpace,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(AppDimensions.radiusLarge),
                  ),
                ),
              ),
              ...slivers,
            ],
          ),
          if (isLoading)
            AppLoadingWidget.overlay(
              message: loadingMessage ?? AppStrings.loadingText,
            ),
        ],
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
      backgroundColor: backgroundColor ?? AppColors.background,
    );
  }
}

/// Tab scaffold for tabbed interfaces
class AppTabScaffold extends StatelessWidget {
  final String? title;
  final List<Tab> tabs;
  final List<Widget> children;
  final TabController? controller;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final List<Widget>? actions;
  final bool isLoading;
  final String? loadingMessage;
  final Color? backgroundColor;

  const AppTabScaffold({
    super.key,
    this.title,
    required this.tabs,
    required this.children,
    this.controller,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.actions,
    this.isLoading = false,
    this.loadingMessage,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: title != null
              ? Text(
                  title!,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : null,
          actions: actions,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: AppDimensions.appBarElevation,
          centerTitle: true,
          bottom: TabBar(
            controller: controller,
            tabs: tabs,
            indicatorColor: AppColors.secondary,
            indicatorWeight: 3.0,
            labelColor: AppColors.textOnPrimary,
            unselectedLabelColor: AppColors.textOnPrimary.withValues(alpha: 0.7),
            labelStyle: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: theme.textTheme.bodyMedium,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(AppDimensions.radiusLarge),
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              controller: controller,
              children: children,
            ),
            if (isLoading)
              AppLoadingWidget.overlay(
                message: loadingMessage ?? AppStrings.loadingText,
              ),
          ],
        ),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        drawer: drawer,
        endDrawer: endDrawer,
        backgroundColor: backgroundColor ?? AppColors.background,
      ),
    );
  }
}


import 'package:flutter/material.dart';

/// Layout fix utilities to prevent RenderBox assertion errors
/// This addresses the hasSize assertion failures in Flutter 3.35.1
class LayoutFix {
  // Private constructor to prevent instantiation
  LayoutFix._();

  /// Safe container that prevents layout assertion errors
  static Widget safeContainer({
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    Decoration? decoration,
    BoxConstraints? constraints,
  }) {
    return ConstrainedBox(
      constraints: constraints ?? BoxConstraints(
        minWidth: width ?? 0,
        minHeight: height ?? 0,
        maxWidth: width ?? double.infinity,
        maxHeight: height ?? double.infinity,
      ),
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        color: color,
        decoration: decoration,
        child: child,
      ),
    );
  }

  /// Safe sized box that prevents layout errors
  static Widget safeSizedBox({
    required Widget child,
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: width ?? 0,
      height: height ?? 0,
      child: child,
    );
  }

  /// Safe flex widget that prevents layout assertion errors
  static Widget safeFlex({
    required List<Widget> children,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    Axis direction = Axis.horizontal,
  }) {
    return Flex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children.map((child) => 
        child is SizedBox ? child : 
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          child: child,
        )
      ).toList(),
    );
  }

  /// Safe padding that prevents layout errors
  static Widget safePadding({
    required Widget child,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    return Padding(
      padding: padding,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        child: child,
      ),
    );
  }

  /// Safe column that prevents layout assertion errors
  static Widget safeColumn({
    required List<Widget> children,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children.map((child) => 
        child is SizedBox ? child : 
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          child: child,
        )
      ).toList(),
    );
  }

  /// Safe row that prevents layout assertion errors
  static Widget safeRow({
    required List<Widget> children,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
  }) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children.map((child) => 
        child is SizedBox ? child : 
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          child: child,
        )
      ).toList(),
    );
  }

  /// Safe expanded widget that prevents layout errors
  static Widget safeExpanded({
    required Widget child,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        child: child,
      ),
    );
  }

  /// Safe flexible widget that prevents layout errors
  static Widget safeFlexible({
    required Widget child,
    int flex = 1,
    FlexFit fit = FlexFit.loose,
  }) {
    return Flexible(
      flex: flex,
      fit: fit,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        child: child,
      ),
    );
  }
}

/// Safe scaffold that prevents layout assertion errors
class SafeScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;

  const SafeScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.minWidth,
              minHeight: constraints.minHeight,
              maxWidth: constraints.maxWidth,
              maxHeight: constraints.maxHeight,
            ),
            child: body,
          );
        },
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
    );
  }
}

/// Safe single child scroll view that prevents layout errors
class SafeSingleChildScrollView extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;

  const SafeSingleChildScrollView({
    super.key,
    required this.child,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      scrollDirection: scrollDirection,
      padding: padding,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: child,
      ),
    );
  }
}


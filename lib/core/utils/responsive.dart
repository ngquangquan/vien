import 'package:flutter/material.dart';

/// Responsive helper for adapting UI across mobile, tablet, and desktop screens.
class Responsive {
  static const double mobileBreakpoint = 640.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1440.0;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  static bool isWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= mobileBreakpoint;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.landscape;

  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static double contentHorizontalPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < mobileBreakpoint) return 16.0;
    if (width < tabletBreakpoint) return 24.0;
    return 32.0;
  }

  /// Calculates dynamic column count based on available width
  static int dynamicColumns(double availableWidth, {double itemMinWidth = 260.0, int maxColumns = 4}) {
    final cols = (availableWidth / itemMinWidth).floor();
    if (cols < 1) return 1;
    if (cols > maxColumns) return maxColumns;
    return cols;
  }
}

/// A container that constrains content to a maximum readable width and
/// centers it horizontally on large screens (tablets, foldables, desktops).
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;
  final bool expand;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = 1080.0,
    this.padding,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = Responsive.contentHorizontalPadding(context);
    final effectivePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 16.0,
        );

    Widget content = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        minHeight: expand ? double.infinity : 0.0,
      ),
      child: Padding(
        padding: effectivePadding,
        child: child,
      ),
    );

    if (expand) {
      return SizedBox.expand(
        child: Align(
          alignment: Alignment.topCenter,
          child: content,
        ),
      );
    }

    return Align(
      alignment: Alignment.topCenter,
      child: content,
    );
  }
}

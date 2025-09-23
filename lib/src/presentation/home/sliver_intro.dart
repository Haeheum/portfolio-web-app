import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SliverIntro extends SingleChildRenderObjectWidget {
  const SliverIntro({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderSliverIntro();
}

class _RenderSliverIntro extends RenderSliverSingleBoxAdapter {
  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    final double childExtent = switch (constraints.axis) {
      Axis.horizontal => child!.size.width,
      Axis.vertical => child!.size.height,
    };
    final double paintedChildSize = calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent = calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      layoutExtent: 0,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent || constraints.scrollOffset > 0.0,
    );
    setChildParentData(child!, constraints, geometry!);
  }
}

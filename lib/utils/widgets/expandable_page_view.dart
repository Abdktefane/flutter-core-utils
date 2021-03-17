import 'package:flutter/material.dart';

/// The idea is:
/// 1) We wrap each child of PageView with a custom widget that can report widget size after each frame.
///  Here I called it SizeReportingWidget
/// 2) Each height is saved in a list, called _heights on an index that corresponds to the child's index.
/// 3) Attach a PageController that will let you determine the currently displayed page's index.
///  Here we save it to a field called _currentPage
/// 4) Wrap PageView in a SizedBox and give it the height of the currently displayed child.
///  I've added a convenient getter called _currentHeight to retrieve the height.
/// 5) (Optional) Wrap the SizedBox in TweenAnimationBuilder,
///  so that the height changes are smooth and animated rather than clanky jumps.

class ExpandablePageView extends StatefulWidget {
  const ExpandablePageView({
    Key key,
    @required this.children,
    this.physics,
    this.controller,
  }) : super(key: key);

  @override
  _ExpandablePageViewState createState() => _ExpandablePageViewState();

  final List<Widget> children;
  final ScrollPhysics physics;
  final PageController controller;
}

class _ExpandablePageViewState extends State<ExpandablePageView> with TickerProviderStateMixin {
  PageController _pageController;
  List<double> _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    _pageController = widget.controller;
    _heights = widget.children.map((e) => 0.0).toList();
    super.initState();
    /* _pageController = (_pageController ?? PageController())
      ..addListener(() {
        final _newPage = _pageController.page.round();
        if (_currentPage != _newPage) {
          setState(() => _currentPage = _newPage);
        }
      }); */

    _pageController.addListener(() {
      final _newPage = _pageController.page.round();
      if (_currentPage != _newPage) {
        if (mounted) {
          setState(() => _currentPage = _newPage);
        }
        //setState(() => _currentPage = _newPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 100),
      tween: Tween<double>(begin: _heights[0], end: _currentHeight),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: PageView(
        physics: widget.physics,
        controller: _pageController,
        children: _sizeReportingChildren
            .asMap() //
            .map((index, child) => MapEntry(index, child))
            .values
            .toList(),
      ),
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children
      .asMap() //
      .map(
        (index, child) => MapEntry(
          index,
          OverflowBox(
            //needed, so that parent won't impose its constraints on the children, thus skewing the measurement results.
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeReportingWidget(
              onSizeChange: (size) => setState(() => _heights[index] = size?.height ?? 0),
              child: Align(child: child),
            ),
          ),
        ),
      )
      .values
      .toList();
}

class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const SizeReportingWidget({
    Key key,
    @required this.child,
    @required this.onSizeChange,
  }) : super(key: key);

  @override
  _SizeReportingWidgetState createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  Size _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return widget.child;
  }

  void _notifySize() {
    final size = context?.size;
    if (_oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size);
    }
  }
}

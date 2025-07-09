// ignore_for_file: deprecated_member_use, must_be_immutable
import 'package:converter_hub/core/app_imports.dart';

class CustomRippleAnimation extends StatefulWidget {
  final double circleRadius;
  final int totalCircle;
  final double circleGap;
  AnimationController? animationController;
  final Duration duration;
  final Color animationColor;
  final double lowerBound;
  final Widget? centerItem;

  CustomRippleAnimation({
    super.key,
    this.circleRadius = 30,
    this.totalCircle = 4,
    this.circleGap = 35,
    this.animationController,
    this.duration = const Duration(seconds: 4),
    this.animationColor = Colors.amber,
    this.lowerBound = 0.3,
    this.centerItem,
  }) : assert(
         lowerBound >= 0.0 && lowerBound <= 1.0,
         'LowerBound must be between 0.0 and 1.0',
       );

  @override
  State<CustomRippleAnimation> createState() => _CustomRippleAnimationState();
}

class _CustomRippleAnimationState extends State<CustomRippleAnimation>
    with SingleTickerProviderStateMixin {
  bool _isExternalController = false;
  late AnimationController _internalController;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.animationController != null) {
      _controller = widget.animationController!;
      _isExternalController = true;
    } else {
      _internalController = AnimationController(
        vsync: this,
        duration: widget.duration,
      )..repeat();
      _controller = _internalController;
    }
  }

  @override
  void dispose() {
    // Only dispose if we created controller
    if (!_isExternalController) {
      _internalController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lowerValue = widget.lowerBound.clamp(0.0, 1.0);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height:
              widget.circleRadius + widget.circleGap * (widget.totalCircle - 1),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final scale = lowerValue + (1 - lowerValue) * _controller.value;
              return Stack(
                alignment: Alignment.center,
                children: List.generate(widget.totalCircle, (index) {
                  return Container(
                    height:
                        index == 0
                            ? widget.circleRadius + 10
                            : (widget.circleRadius + index * widget.circleGap) *
                                scale,
                    width:
                        index == 0
                            ? widget.circleRadius + 10
                            : (widget.circleRadius + index * widget.circleGap) *
                                scale,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.animationColor.withOpacity(
                        1 - _controller.value,
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
        widget.centerItem != null ? widget.centerItem! : SizedBox(),
      ],
    );
  }
}

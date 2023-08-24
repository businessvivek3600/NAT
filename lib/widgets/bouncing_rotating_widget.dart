import 'package:flutter/material.dart';

class BouncingRotatingWidget extends StatefulWidget {
  const BouncingRotatingWidget(
      {super.key,
        this.child,
        this.height = 30,
        this.belowHeight = false,
        required this.bounceSpeed,
        required this.rotationSpeed});
  final Widget? child;
  final double height;
  final int bounceSpeed;
  final int rotationSpeed;
  final bool belowHeight;

  @override
  _BouncingRotatingWidgetState createState() => _BouncingRotatingWidgetState();
}

class _BouncingRotatingWidgetState extends State<BouncingRotatingWidget>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _rotationController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _bounceController = AnimationController(
        duration: Duration(milliseconds: widget.bounceSpeed), vsync: this);

    _rotationController = AnimationController(
        duration: Duration(milliseconds: widget.rotationSpeed), vsync: this);

    _bounceAnimation =
    Tween<double>(begin: widget.belowHeight?-widget.height:0, end: widget.height).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _bounceController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _bounceController.forward();
      }
    });

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotationController.reset();
        _rotationController.forward();
      } else if (status == AnimationStatus.dismissed) {
        _rotationController.reset();
        _rotationController.forward();
      }
    });

    _bounceController.forward();
    _rotationController.forward();
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounceController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_bounceAnimation.value),
          child: AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return Transform.rotate(
                  angle: _rotationAnimation.value *
                      2 *
                      3.14159, // Convert to radians
                  child: child);
            },
            child: widget.child ??
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient:
                      LinearGradient(colors: [Colors.red, Colors.green])),
                ),
          ),
        );
      },
      child: widget.child ??
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Colors.red, Colors.green])),
          ),
    );
  }
}
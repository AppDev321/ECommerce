import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedImage extends StatefulWidget {
  final double imageSize;
  final Widget imageWidget;
  const AnimatedImage({
    Key? key,
    required this.imageSize,
    required this.imageWidget,
  }) : super(key: key);

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage> {
  bool isBig = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isBig = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: isBig ? widget.imageSize : 50.w,
        child: widget.imageWidget,
      ),
    );
  }
}

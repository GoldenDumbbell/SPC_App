import 'package:flutter/material.dart';
import 'package:webspc/widget/sizer.dart';
import '../../widget/image.dart';

class AppCircleAvatar extends StatelessWidget {
  const AppCircleAvatar({
    this.size = 80,
    required this.imageUrl,
    this.borderWidth = 2,
    this.shouldShowHeart = false,
    this.isOnline = false,
    this.widgetOnlineIndicator,
    this.checkOnline = false,
    Key? key,
  }) : super(key: key);
  final double size;
  final String? imageUrl;
  final double borderWidth;
  final bool shouldShowHeart;
  final bool? isOnline;
  final Widget? widgetOnlineIndicator;
  final bool? checkOnline;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(borderWidth),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CircleAvatar(
              radius: 100,
              child: ImageAssets.networkImage(
                url: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        checkOnline == true
            ? Positioned(
                bottom: 5,
                right: 7,
                child: Container(
                  width: 15.sp,
                  height: 15.sp,
                  decoration: BoxDecoration(
                    color:
                        isOnline == true ? Colors.green[400] : Colors.grey[400],
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}

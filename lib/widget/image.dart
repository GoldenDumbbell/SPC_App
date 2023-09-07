import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageAssets {
  static Widget networkImage({
    String? url,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    Alignment alignment = Alignment.center,
    LoadingErrorWidgetBuilder? errorWidget,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        alignment: alignment,
        imageUrl: url ?? '',
        fit: fit ?? BoxFit.cover,
        color: color,
        errorWidget: errorWidget ??
            (context, error, _) {
              return Container();
            },
      ),
    );
  }
}

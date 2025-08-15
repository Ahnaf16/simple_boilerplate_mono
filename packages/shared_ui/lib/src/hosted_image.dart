import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_functionality/core_functionality.dart';
import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:shared_ui/src/k_hero.dart';

class HostedImage extends StatelessWidget {
  const HostedImage(
    this.url, {
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.onImgTap,
    this.errorIcon,
    this.isAvatar = false,
    this.radius,
  });

  const HostedImage.square(
    this.url, {
    super.key,
    double? dimension,
    this.fit = BoxFit.cover,
    this.onImgTap,
    this.errorIcon,
    this.isAvatar = false,
    this.radius,
  }) : height = dimension,
       width = dimension;

  final void Function()? onImgTap;

  final IconData? errorIcon;
  final BoxFit fit;
  final double? height;
  final String url;
  final double? width;
  final bool isAvatar;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      hoverColor: Colors.transparent,
      onTap: onImgTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: CachedNetworkImage(
          imageUrl: url,
          height: height,
          width: width,
          fit: fit,
          memCacheHeight: height?.toInt(),
          memCacheWidth: width?.toInt(),
          progressIndicatorBuilder: (context, url, p) {
            return SizedBox.square(
              dimension: (height ?? 25) - 5,
              child: Center(child: CircularProgressIndicator.adaptive(strokeWidth: 3, value: p.progress)),
            );
          },
          errorWidget: (context, url, _) {
            if (errorIcon != null) return Icon(errorIcon);

            if (isAvatar) {
              return DecoContainer(
                height: height,
                width: width,
                color: context.colors.primary.op1,
                borderRadius: 100,
                alignment: Alignment.center,
                child: Icon(Icons.person_rounded, color: context.colors.primary),
              );
            }

            return const Center(child: FittedBox(child: Icon(Icons.broken_image_outlined, size: 25)));
          },
        ),
      ),
    );
  }
}

class PhotoView extends StatelessWidget {
  const PhotoView(this.image, {super.key});

  final String image;

  static void open(BuildContext context, String image) {
    context.nPush(PhotoView(image), fullScreen: true);
  }

  @override
  Widget build(BuildContext context) {
    final isNetwork = image.startsWith('http');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: KHero(
          tag: image,
          child: isNetwork ? HostedImage(image, fit: BoxFit.contain) : Image.file(File(image), fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class PhotoViewWrapper extends StatelessWidget {
  const PhotoViewWrapper({super.key, required this.image, required this.child});

  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return KHero(
      tag: image,
      child: GestureDetector(onTap: () => PhotoView.open(context, image), child: child),
    );
  }
}

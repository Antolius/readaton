import 'package:flutter/foundation.dart';

abstract class ImageData {
  const ImageData();

  T accept<T>(ImageDataVisitor<T> visitor);
}

abstract class ImageDataVisitor<T> {
  T visitUrlImage(UrlImageData urlImage);

  T visitLocalImage(LocalImageData localImage);
}

class UrlImageData extends ImageData {
  final String imageUrl;

  const UrlImageData({
    @required this.imageUrl,
  });

  @override
  T accept<T>(ImageDataVisitor<T> visitor) => visitor.visitUrlImage(this);
}

class LocalImageData extends ImageData {
  final String imageName;

  const LocalImageData({
    @required this.imageName,
  });

  @override
  T accept<T>(ImageDataVisitor<T> visitor) => visitor.visitLocalImage(this);
}


class PresentationData {
  String name;
  List<ImageData> images;

  PresentationData({required this.name, required this.images});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'images': images.map((e) => e.toMap()).toList(),
    };
  }

  factory PresentationData.fromMap(Map<String, dynamic> map) {
    return PresentationData(
      name: map['name'],
      images: List<ImageData>.from(map['images'].map((e) => ImageData.fromMap(e))),
    );
  }
}

class ImageData {
  String name;
  String imageUrl;

  ImageData({required this.name, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory ImageData.fromMap(Map<String, dynamic> map) {
    return ImageData(
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }
}
class BannerModel {
  final String image;
  final String link;
  final Function onTap;


  BannerModel({
    required this.image,
    required this.link,
    required this.onTap,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json['image'],
      link: json['link'],
      onTap: () {
        print('Tapped on Banner ${json['image']}');
      },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'link': link,
    };
  }

  static List<BannerModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => BannerModel.fromJson(item)).toList();
  }
}

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratingsCount,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.ratings
  });

  factory RestaurantModel.fromJson({
    required Map<String, dynamic> json,
  }){
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: json['thumbUrl'],
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values.firstWhere(
            (e) => e.name == json['priceRange'],
      ),
      // priceRange: RestaurantPriceRange.cheep,
      ratingsCount: json['ratingsCount'],
      deliveryFee: json['deliveryFee'],
      deliveryTime: json['deliveryTime'],
      ratings: json['ratings'],
    );
  }
}
class ProductModel {
  String? name;
  int? price;
  String? image;
  String? about;
  double? rating;
  int? reviews;
  int? count;
  String? id;

  ProductModel(
      {this.name,
      this.price,
      this.image,
      this.about,
      this.rating,
      this.reviews,
      this.count,
      this.id});

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    image = json['image'];
    about = json['about'];
    rating = json['rating'];
    reviews = json['reviews'];
    count = json['count'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['about'] = about;
    data['rating'] = rating;
    data['reviews'] = reviews;
    data['count'] = count;
    data['id'] = id;
    return data;
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, image: $image, price: $price, reviews: $reviews, rating: $rating)';
  }
}

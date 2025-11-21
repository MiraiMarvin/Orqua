import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.thumbnail,
    required super.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? 'general',
      thumbnail: json['thumbnail'] as String? ?? json['image'] as String? ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'] as List)
          : [json['image'] as String? ?? json['thumbnail'] as String? ?? ''],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'thumbnail': thumbnail,
      'images': images,
    };
  }
}


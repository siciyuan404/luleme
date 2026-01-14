enum KnowledgeCategory { health, behavior, diet, training, other }

class Knowledge {
  final String id;
  final String title;
  final String content;
  final KnowledgeCategory category;
  final String? imageUrl;
  final DateTime publishDate;
  final bool isAiGenerated;
  final bool isFavorite;

  Knowledge({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    this.imageUrl,
    required this.publishDate,
    this.isAiGenerated = false,
    this.isFavorite = false,
  });

  String get categoryName {
    switch (category) {
      case KnowledgeCategory.health: return '健康';
      case KnowledgeCategory.behavior: return '行为';
      case KnowledgeCategory.diet: return '饮食';
      case KnowledgeCategory.training: return '训练';
      case KnowledgeCategory.other: return '其他';
    }
  }

  Knowledge copyWith({bool? isFavorite}) {
    return Knowledge(
      id: id,
      title: title,
      content: content,
      category: category,
      imageUrl: imageUrl,
      publishDate: publishDate,
      isAiGenerated: isAiGenerated,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'category': category.index,
    'imageUrl': imageUrl,
    'publishDate': publishDate.toIso8601String(),
    'isAiGenerated': isAiGenerated,
    'isFavorite': isFavorite,
  };

  factory Knowledge.fromJson(Map<String, dynamic> json) => Knowledge(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    category: KnowledgeCategory.values[json['category']],
    imageUrl: json['imageUrl'],
    publishDate: DateTime.parse(json['publishDate']),
    isAiGenerated: json['isAiGenerated'] ?? false,
    isFavorite: json['isFavorite'] ?? false,
  );
}

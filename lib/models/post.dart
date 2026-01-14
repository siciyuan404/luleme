class Post {
  final String id;
  final String authorId;
  final String authorName;
  final String? authorAvatar;
  final String title;
  final String content;
  final List<String> images;
  final List<String> tags;
  final int likeCount;
  final bool isLiked;
  final bool isFavorite;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    required this.title,
    required this.content,
    this.images = const [],
    this.tags = const [],
    this.likeCount = 0,
    this.isLiked = false,
    this.isFavorite = false,
    required this.createdAt,
  });

  Post copyWith({int? likeCount, bool? isLiked, bool? isFavorite}) {
    return Post(
      id: id,
      authorId: authorId,
      authorName: authorName,
      authorAvatar: authorAvatar,
      title: title,
      content: content,
      images: images,
      tags: tags,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'authorId': authorId,
    'authorName': authorName,
    'authorAvatar': authorAvatar,
    'title': title,
    'content': content,
    'images': images,
    'tags': tags,
    'likeCount': likeCount,
    'isLiked': isLiked,
    'isFavorite': isFavorite,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'],
    authorId: json['authorId'],
    authorName: json['authorName'],
    authorAvatar: json['authorAvatar'],
    title: json['title'],
    content: json['content'],
    images: List<String>.from(json['images'] ?? []),
    tags: List<String>.from(json['tags'] ?? []),
    likeCount: json['likeCount'] ?? 0,
    isLiked: json['isLiked'] ?? false,
    isFavorite: json['isFavorite'] ?? false,
    createdAt: DateTime.parse(json['createdAt']),
  );
}

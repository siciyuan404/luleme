import 'package:flutter/material.dart';
import '../../models/post.dart';
import '../../app/theme.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  // MVP阶段使用模拟数据
  final List<Post> _posts = [
    Post(
      id: '1',
      authorId: 'admin',
      authorName: '撸了么官方',
      title: '推荐：超好用的猫粮',
      content: '这款猫粮我家主子超爱吃！营养均衡，适口性好，推荐给各位铲屎官~',
      tags: ['猫粮', '推荐'],
      likeCount: 128,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Post(
      id: '2',
      authorId: 'admin',
      authorName: '撸了么官方',
      title: '猫抓板选购指南',
      content: '选猫抓板要注意材质和稳定性，瓦楞纸材质最受猫咪欢迎，记得定期更换哦！',
      tags: ['猫抓板', '攻略'],
      likeCount: 89,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Post(
      id: '3',
      authorId: 'admin',
      authorName: '撸了么官方',
      title: '夏季猫咪降温好物',
      content: '天气热了，给猫咪准备一个冰垫吧！放在猫窝里，主子会很喜欢的~',
      tags: ['夏季', '降温'],
      likeCount: 156,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('用品推荐 🛍️')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _posts.length,
        itemBuilder: (context, index) => _PostCard(
          post: _posts[index],
          onLike: () => setState(() {
            final post = _posts[index];
            _posts[index] = post.copyWith(
              isLiked: !post.isLiked,
              likeCount: post.isLiked ? post.likeCount - 1 : post.likeCount + 1,
            );
          }),
          onFavorite: () => setState(() {
            final post = _posts[index];
            _posts[index] = post.copyWith(isFavorite: !post.isFavorite);
          }),
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onFavorite;

  const _PostCard({required this.post, required this.onLike, required this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 作者信息
            Row(
              children: [
                CircleAvatar(backgroundColor: AppTheme.accentColor, child: const Icon(Icons.pets, color: AppTheme.primaryColor)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(_formatTime(post.createdAt), style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 标题和内容
            Text(post.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(post.content, style: TextStyle(color: Colors.grey[700], height: 1.5)),
            const SizedBox(height: 12),
            // 标签
            Wrap(
              spacing: 8,
              children: post.tags.map((tag) => Chip(
                label: Text(tag, style: const TextStyle(fontSize: 12)),
                backgroundColor: AppTheme.accentColor,
                padding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )).toList(),
            ),
            const SizedBox(height: 12),
            // 操作栏
            Row(
              children: [
                _ActionButton(
                  icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                  label: '${post.likeCount}',
                  color: post.isLiked ? Colors.red : Colors.grey,
                  onTap: onLike,
                ),
                const SizedBox(width: 24),
                _ActionButton(
                  icon: post.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                  label: '收藏',
                  color: post.isFavorite ? AppTheme.primaryColor : Colors.grey,
                  onTap: onFavorite,
                ),
                const SizedBox(width: 24),
                _ActionButton(icon: Icons.share_outlined, label: '分享', color: Colors.grey, onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes}分钟前';
    if (diff.inHours < 24) return '${diff.inHours}小时前';
    return '${diff.inDays}天前';
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: color, fontSize: 13)),
        ],
      ),
    );
  }
}

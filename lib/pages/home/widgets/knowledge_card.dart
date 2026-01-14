import 'package:flutter/material.dart';
import '../../../models/knowledge.dart';
import '../../../app/theme.dart';

class KnowledgeCard extends StatelessWidget {
  final Knowledge knowledge;
  final bool compact;
  final VoidCallback? onFavorite;

  const KnowledgeCard({
    super.key,
    required this.knowledge,
    this.compact = false,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(compact ? 12 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(knowledge.categoryName, style: const TextStyle(fontSize: 12, color: Color(0xFF5D4037))),
                ),
                const Spacer(),
                if (knowledge.isAiGenerated)
                  const Icon(Icons.auto_awesome, size: 16, color: AppTheme.primaryColor),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              knowledge.title,
              style: TextStyle(
                fontSize: compact ? 16 : 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF5D4037),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              knowledge.content,
              style: TextStyle(
                fontSize: compact ? 13 : 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
              maxLines: compact ? 2 : null,
              overflow: compact ? TextOverflow.ellipsis : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  '${knowledge.publishDate.month}月${knowledge.publishDate.day}日',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    knowledge.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: knowledge.isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: onFavorite,
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.share_outlined, color: Colors.grey),
                  onPressed: () {},
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

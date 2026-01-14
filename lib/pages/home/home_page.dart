import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/knowledge_provider.dart';
import '../../app/theme.dart';
import 'widgets/knowledge_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('撸了么 🐱')),
      body: Consumer<KnowledgeProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 今日知识卡片
                const Text('今日猫咪知识', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5D4037))),
                const SizedBox(height: 12),
                if (provider.todayKnowledge != null)
                  KnowledgeCard(
                    knowledge: provider.todayKnowledge!,
                    onFavorite: () => provider.toggleFavorite(provider.todayKnowledge!.id),
                  ),
                
                const SizedBox(height: 24),
                
                // 历史知识列表
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('往期知识', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5D4037))),
                    TextButton(onPressed: () {}, child: const Text('查看全部')),
                  ],
                ),
                const SizedBox(height: 8),
                ...provider.knowledgeList.skip(1).take(3).map((k) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: KnowledgeCard(
                    knowledge: k,
                    compact: true,
                    onFavorite: () => provider.toggleFavorite(k.id),
                  ),
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}

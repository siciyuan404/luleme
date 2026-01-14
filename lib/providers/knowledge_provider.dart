import 'package:flutter/foundation.dart';
import '../models/knowledge.dart';

class KnowledgeProvider extends ChangeNotifier {
  List<Knowledge> _knowledgeList = [];
  Knowledge? _todayKnowledge;
  bool _isLoading = false;

  List<Knowledge> get knowledgeList => _knowledgeList;
  Knowledge? get todayKnowledge => _todayKnowledge;
  bool get isLoading => _isLoading;

  KnowledgeProvider() {
    _loadMockData();
  }

  void _loadMockData() {
    // MVP阶段使用模拟数据，后续接入AI API
    _knowledgeList = [
      Knowledge(
        id: '1',
        title: '猫咪为什么喜欢纸箱？',
        content: '猫咪喜欢纸箱是因为它们提供了安全感和温暖。纸箱的封闭空间让猫咪感到被保护，同时纸板材质还能保温。这是猫咪的天性，在野外它们也会寻找类似的隐蔽处休息。',
        category: KnowledgeCategory.behavior,
        publishDate: DateTime.now(),
        isAiGenerated: true,
      ),
      Knowledge(
        id: '2',
        title: '每天应该撸猫多久？',
        content: '建议每天花15-30分钟与猫咪互动。撸猫不仅能增进感情，还能帮助猫咪放松、促进血液循环。但要注意观察猫咪的反应，如果它开始甩尾巴或耳朵后压，说明它需要休息了。',
        category: KnowledgeCategory.behavior,
        publishDate: DateTime.now().subtract(const Duration(days: 1)),
        isAiGenerated: true,
      ),
      Knowledge(
        id: '3',
        title: '猫咪的最佳饮食时间',
        content: '成年猫建议每天喂食2-3次，定时定量。早晚各一次是比较理想的安排。幼猫需要更频繁的喂食，每天3-4次。保持规律的喂食时间有助于猫咪的消化系统健康。',
        category: KnowledgeCategory.diet,
        publishDate: DateTime.now().subtract(const Duration(days: 2)),
        isAiGenerated: true,
      ),
    ];
    _todayKnowledge = _knowledgeList.first;
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final index = _knowledgeList.indexWhere((k) => k.id == id);
    if (index != -1) {
      _knowledgeList[index] = _knowledgeList[index].copyWith(
        isFavorite: !_knowledgeList[index].isFavorite,
      );
      if (_todayKnowledge?.id == id) {
        _todayKnowledge = _knowledgeList[index];
      }
      notifyListeners();
    }
  }

  List<Knowledge> get favorites => _knowledgeList.where((k) => k.isFavorite).toList();
}

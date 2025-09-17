import 'package:flutter/material.dart';
import 'package:meera/features/articles/view/articles_screen.dart';
import 'package:meera/features/coping/view/coping_screen.dart';
import 'package:meera/features/helplines/view/helplines_screen.dart';
import 'package:meera/features/mindfulness/view/mindfulness_screen.dart';
import 'package:meera/features/tools/widgets/tool_tab.dart';

class ToolsScreen extends StatelessWidget {
  final Function(Widget, String) onToolSelected;

  const ToolsScreen({super.key, required this.onToolSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          ToolTab(
            title: 'Articles',
            icon: Icons.article_outlined,
            onTap: () => onToolSelected(const ArticlesScreen(), 'Articles'),
          ),
          ToolTab(
            title: 'Helplines',
            icon: Icons.phone_in_talk_outlined,
            onTap: () => onToolSelected(const HelplinesScreen(), 'Helplines'),
          ),
          ToolTab(
            title: 'Mindfulness',
            icon: Icons.self_improvement_outlined,
            onTap: () => onToolSelected(const MindfulnessScreen(), 'Mindfulness'),
          ),
          ToolTab(
            title: 'Coping',
            icon: Icons.healing_outlined,
            onTap: () => onToolSelected(const CopingScreen(), 'Coping'),
          ),
        ],
      ),
    );
  }
}

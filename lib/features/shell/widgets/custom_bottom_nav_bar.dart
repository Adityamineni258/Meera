import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meera/constants/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final PageController pageController;
  final int selectedIndex;
  final Function(int) onNavItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.pageController,
    required this.selectedIndex,
    required this.onNavItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final navBarWidth = screenWidth - (2 * 12) - (2 * 20);
    final iconSlotWidth = navBarWidth / 5; // Changed from 4 to 5

    final pageOffset =
        pageController.hasClients ? pageController.page ?? 0.0 : 0.0;
    final pillPosition =
        (pageOffset * iconSlotWidth) + (iconSlotWidth / 2) - 35;

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          final newPosition = pageController.offset - details.delta.dx;
          if (pageController.position.hasContentDimensions) {
            pageController.jumpTo(newPosition.clamp(
                0.0, pageController.position.maxScrollExtent));
          }
        },
        onHorizontalDragEnd: (details) {
          final velocity = details.primaryVelocity ?? 0;
          int targetPage = selectedIndex;

          if (velocity.abs() > 300) {
            if (velocity < 0) {
              targetPage = (selectedIndex + 1);
            } else {
              targetPage = (selectedIndex - 1);
            }
          } else {
            targetPage = pageController.page!.round();
          }

          final int finalPage = targetPage.clamp(0, 4); // Changed from 3 to 4
          onNavItemTapped(finalPage);
        },
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                spreadRadius: 2,
                blurRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                left: pillPosition,
                top: (75 - 55) / 2,
                child: Container(
                  width: 70,
                  height: 55,
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withAlpha((255 * 0.2).round()),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: _buildNavItem(0)), // MoodScreen
                  Expanded(child: _buildNavItem(1)), // ToolsScreen
                  Expanded(child: _buildNavItem(2)), // Home
                  Expanded(child: _buildNavItem(3)), // Journal
                  Expanded(child: _buildNavItem(4)), // AI Chat
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected =
        (pageController.hasClients ? pageController.page?.round() : 0) ==
            index;
    String assetName;

    switch (index) {
      case 0:
        assetName = 'assets/images/mood.svg'; // MoodScreen icon
        break;
      case 1:
        assetName = 'assets/images/tools.svg'; // ToolsScreen icon
        break;
      case 2:
        assetName = 'assets/images/home_button.svg'; // Home icon
        break;
      case 3:
        assetName = 'assets/images/journal.svg'; // Journal icon
        break;
      case 4:
        assetName = 'assets/images/ai_chat.svg'; // AI Chat icon
        break;
      default:
        assetName = 'assets/images/home_button.svg'; // Fallback
    }

    return GestureDetector(
      onTap: () => onNavItemTapped(index),
      child: Container(
        height: 75,
        color: Colors.transparent,
        child: AnimatedOpacity(
          opacity: isSelected ? 1.0 : 0.6,
          duration: const Duration(milliseconds: 300),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: isSelected ? 32.0 : 28.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            builder: (context, size, child) {
              return Center(
                child: SizedBox(
                  height: size,
                  width: size,
                  child: child,
                ),
              );
            },
            child: SvgPicture.asset(
              assetName,
              colorFilter: ColorFilter.mode(
                isSelected ? AppTheme.darkerPrimaryColor : AppTheme.textColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

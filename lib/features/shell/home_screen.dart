import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meera/constants/app_theme.dart';
import 'package:meera/features/home_content/view/main_content_screen.dart';
import 'package:meera/features/journal/view/journal_screen.dart';
import 'package:meera/features/language/view/language_selection_screen.dart';
import 'package:meera/features/shell/widgets/custom_bottom_nav_bar.dart';
import 'package:meera/features/tools/view/tools_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 1;
  late PageController _pageController;
  bool _isLanguageSelectionVisible = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _pageController.addListener(() {
      setState(() {});
    });

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  void _toggleLanguageScreen() {
    setState(() {
      _isLanguageSelectionVisible = !_isLanguageSelectionVisible;
      if (_isLanguageSelectionVisible) {
        _fadeController.forward();
      } else {
        _fadeController.reverse();
      }
    });
  }

  Widget _buildPageForIndex(int index) {
    if (_isLanguageSelectionVisible && index == _selectedIndex) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: const LanguageSelectionScreen(),
      );
    }
    switch (index) {
      case 0:
        return const ToolsScreen();
      case 1:
        return const MainContentScreen();
      case 2:
      default:
        return const JournalScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isLanguageSelectionVisible
          ? AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                child: GestureDetector(
                  onTap: _toggleLanguageScreen,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(15),
                          spreadRadius: 1,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, size: 20),
                  ),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Languages',
                  style: GoogleFonts.lexend(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textColor,
                  ),
                ),
              ),
            )
          : AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.language),
                  iconSize: 30.0, // Increased icon size
                  onPressed: _toggleLanguageScreen,
                ),
                const SizedBox(width: 12),
              ],
            ),
      bottomNavigationBar: CustomBottomNavBar(
        pageController: _pageController,
        selectedIndex: _selectedIndex,
        onNavItemTapped: _onNavItemTapped,
      ),
      body: PageView(
        controller: _pageController,
        physics: const ClampingScrollPhysics(),
        onPageChanged: (index) {
          if (_isLanguageSelectionVisible) {
            _toggleLanguageScreen();
          }
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildPageForIndex(0),
          _buildPageForIndex(1),
          _buildPageForIndex(2),
        ],
      ),
    );
  }
}
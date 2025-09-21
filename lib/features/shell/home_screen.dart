import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meera/constants/app_theme.dart';
import 'package:meera/features/home_content/view/main_content_screen.dart';
import 'package:meera/features/journal/view/journal_screen.dart';
import 'package:meera/features/language/view/language_selection_screen.dart';
import 'package:meera/features/shell/widgets/custom_bottom_nav_bar.dart';
import 'package:meera/features/tools/view/tools_screen.dart';
import 'package:meera/features/ai_chat/chat_screen.dart';
import 'package:meera/features/mood_tracking/mood_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 2; // Changed initial index to 2 for Home
  late PageController _pageController;
  bool _isLanguageSelectionVisible = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  Widget? _selectedToolBody;
  String? _selectedToolTitle;

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
    if (_selectedToolBody != null) {
      _goBackFromTool();
    }
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

  void _selectTool(Widget body, String title) {
    setState(() {
      _selectedToolBody = body;
      _selectedToolTitle = title;
    });
  }

  void _goBackFromTool() {
    setState(() {
      _selectedToolBody = null;
      _selectedToolTitle = null;
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
        return const MoodScreen(); // MoodScreen at index 0
      case 1:
        return ToolsScreen(onToolSelected: _selectTool); // ToolsScreen at index 1
      case 2:
        return const MainContentScreen(); // Home at index 2
      case 3:
        return const JournalScreen(); // Journal at index 3
      case 4:
        return const ChatScreen(); // AI Chat at index 4
      default:
        return const MainContentScreen(); // Fallback to Home
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isToolSelected = _selectedToolBody != null;

    return Scaffold(
      backgroundColor: AppTheme.primaryColor, // Added from PhoneFrame
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Added from PhoneFrame
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40), // Added from PhoneFrame
            child: Scaffold(
              appBar: isToolSelected
                  ? AppBar(
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                        child: GestureDetector(
                          onTap: _goBackFromTool,
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
                          _selectedToolTitle ?? '',
                          style: GoogleFonts.lexend(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textColor,
                          ),
                        ),
                      ),
                    )
                  : _isLanguageSelectionVisible
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
                              AppLocalizations.of(context).toolLanguages,
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
                              iconSize: 30.0,
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
              body: Stack(
                children: [
                  PageView(
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
                      _buildPageForIndex(3),
                      _buildPageForIndex(4),
                    ],
                  ),
                  if (isToolSelected)
                    Container(
                      color: AppTheme.scaffoldBackgroundColor,
                      child: _selectedToolBody,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

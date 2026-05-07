import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:grocery_app/core/app_export.dart';
import 'package:grocery_app/routes/app_routes.dart';

/// Onboarding flow shown on first launch.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = const [
    _OnboardingPage(
      title: AppStrings.onboarding1Title,
      description: AppStrings.onboarding1Desc,
      emoji: '🥦',
      color: Color(0xFFE8F5E9),
      accentColor: AppColors.primary,
    ),
    _OnboardingPage(
      title: AppStrings.onboarding2Title,
      description: AppStrings.onboarding2Desc,
      emoji: '⚡',
      color: Color(0xFFFFF8E1),
      accentColor: AppColors.warning,
    ),
    _OnboardingPage(
      title: AppStrings.onboarding3Title,
      description: AppStrings.onboarding3Desc,
      emoji: '💳',
      color: Color(0xFFE3F2FD),
      accentColor: AppColors.info,
    ),
  ];

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _done();
    }
  }

  void _done() {
    Get.find<StorageService>()
        .setBool(AppConstants.keyOnboardingDone, true);
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentPage == _pages.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _done,
                child: Text(
                  AppStrings.skip,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppSizes.fontMD,
                    fontFamily: 'Poppins',
                  ),
                ),
              ).paddingOnly(top: AppSizes.paddingSM, right: AppSizes.paddingMD),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _pages.length,
                itemBuilder: (_, i) => _OnboardingPageWidget(page: _pages[i]),
              ),
            ),

            // Bottom actions
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.paddingXXL,
                AppSizes.paddingLG,
                AppSizes.paddingXXL,
                AppSizes.paddingXXXL,
              ),
              child: Column(
                children: [
                  // Page indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                      activeDotColor: _pages[_currentPage].accentColor,
                      dotColor: AppColors.grey200,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingXXL),

                  // CTA button
                  ElevatedButton(
                    onPressed: _onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _pages[_currentPage].accentColor,
                    ),
                    child: Text(
                      isLast ? AppStrings.getStarted : AppStrings.next,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Page data model ──────────────────────────────────────────────────────────

class _OnboardingPage {
  final String title;
  final String description;
  final String emoji;
  final Color color;
  final Color accentColor;

  const _OnboardingPage({
    required this.title,
    required this.description,
    required this.emoji,
    required this.color,
    required this.accentColor,
  });
}

// ─── Page widget ──────────────────────────────────────────────────────────────

class _OnboardingPageWidget extends StatelessWidget {
  final _OnboardingPage page;

  const _OnboardingPageWidget({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingXXL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration placeholder
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              color: page.color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                page.emoji,
                style: const TextStyle(fontSize: 100),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spacingXXXL),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSizes.spacingLG),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
          ),
        ],
      ),
    );
  }
}

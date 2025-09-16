# Adding a New Feature

To add a new feature to the app, follow the steps below. This will ensure that the new feature is well-integrated with the existing architecture.

1.  **Create a new feature directory:**
    Create a new directory for your feature inside the `lib/features/` directory. For example, if you are adding a "Settings" feature, create a `lib/features/settings/` directory.

2.  **Define the feature structure:**
    Inside your feature directory, create subdirectories to organize your code. A typical feature directory will have the following structure:
    - `view/`: Contains the UI widgets for the feature.
    - `widgets/`: Contains smaller, reusable widgets specific to this feature.
    - `controller/` or `bloc/`: Contains the business logic for the feature.

3.  **Create the view:**
    Inside the `view/` directory, create a new file for your screen widget. For example, `lib/features/settings/view/settings_screen.dart`.

4.  **Integrate the new screen:**
    If the new feature should be accessible from the bottom navigation bar, you need to:
    - Add a new screen widget to the `PageView` in `lib/features/shell/home_screen.dart`.
    - Add a new item to the `CustomBottomNavBar` in `lib/features/shell/widgets/custom_bottom_nav_bar.dart`.

    If the new feature is accessed from another screen, add the navigation logic to the appropriate widget.

5.  **Write Tests:**
    For every new feature, it's crucial to write unit and/or widget tests to ensure its correctness and prevent regressions. Place your tests in the `test/` directory, mirroring the structure of your `lib/` directory. For example, tests for `lib/features/settings/view/settings_screen.dart` would go into `test/features/settings/view/settings_screen_test.dart`.

6.  **Follow the architecture:**
    - **Separation of Concerns:** Keep the UI code in the `view/` directory and the business logic in the `controller/` or `bloc/` directory.
    - **Modularity:** The feature should be as self-contained as possible. Avoid creating tight dependencies between features.
    - **Reusability:** If you create a widget that can be used in other features, consider moving it to the `lib/widgets/` directory.

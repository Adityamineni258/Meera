# Project Structure

The project follows a feature-first, modular, and scalable architecture to facilitate team collaboration and maintainability. The `lib` directory is organized as follows:

- **`main.dart`**: The entry point of the application. It contains the `main()` function and the root `MyApp` widget.

- **`constants/`**: This directory contains app-wide constants.
  - **`app_theme.dart`**: Defines the application's theme, including colors, fonts, and text styles.

- **`widgets/`**: This directory contains shared or common widgets that can be used across multiple features.
  - **`phone_frame.dart`**: A widget that creates the phone frame effect around the main content.

- **`features/`**: This directory contains the different features of the app, with each feature having its own subdirectory.
  - **`shell/`**: This feature contains the main application shell, including the `HomeScreen` that manages the `PageView` and the bottom navigation bar.
    - **`home_screen.dart`**: The main screen widget that holds the `PageView` and the logic for switching between screens.
    - **`widgets/`**: Contains widgets specific to the `shell` feature.
      - **`custom_bottom_nav_bar.dart`**: The custom bottom navigation bar widget.
  - **`tools/`**: The "Tools" feature.
    - **`view/`**: Contains the screen for this feature.
      - **`tools_screen.dart`**: The UI for the "Tools" screen.
  - **`home_content/`**: The content for the home screen.
    - **`view/`**: Contains the screen for this feature.
      - **`main_content_screen.dart`**: The UI for the main content of the home screen.
  - **`journal/`**: The "Journal" feature.
    - **`view/`**: Contains the screen for this feature.
      - **`journal_screen.dart`**: The UI for the "Journal" screen.
  - **`language/`**: The language selection feature.
    - **`view/`**: Contains the screen for this feature.
      - **`language_selection_screen.dart`**: The UI for the language selection screen.

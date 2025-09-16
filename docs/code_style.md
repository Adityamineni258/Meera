# Code Style and Conventions

To maintain a consistent and readable codebase, we adhere to the following code style and conventions.

1.  **Dart Style Guide:**
    Follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style).

2.  **Naming Conventions:**
    - **Files:** Use `snake_case` for file names (e.g., `home_screen.dart`).
    - **Classes and Enums:** Use `PascalCase` for classes and enums (e.g., `HomeScreen`, `Status.success`).
    - **Variables, Functions, and Parameters:** Use `camelCase` for variables, functions, and parameters (e.g., `userName`, `getUserProfile()`).

3.  **Code Formatting:**
    - Use the default Flutter code formatter. You can format your code by running `flutter format .` in the terminal.
    - Set up your editor to format the code on save.

4.  **Linting and Analysis:**
    - The project uses `analysis_options.yaml` to enforce a consistent code style and catch potential issues. Ensure your IDE is configured to use these analysis options. Running `flutter analyze` will show any issues.

5.  **Widgets:**
    - **`const` constructors:** Use `const` constructors for widgets where possible to improve performance.
    - **Keep widgets small:** Break down large widgets into smaller, more manageable widgets. Each widget should have a single responsibility.
    - **Private widgets:** If a widget is only used in one file, make it a private widget by prefixing its name with an underscore (e.g., `_buildHeader()`).

6.  **Comments:**
    - Add comments to explain complex or non-obvious logic.
    - Use `//` for single-line comments and `/* ... */` for multi-line comments.
    - Use `///` for documentation comments that can be processed by `dart doc`.

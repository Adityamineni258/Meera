# Visual Guide

This guide provides a visual representation of the app's UI to help you understand the different components of the Meera app.

## Home Screen

The Home Screen is the main screen of the app. It is composed of three main parts:

```
+-------------------------------------------------+
| [AppBar]                                        |
|                                                 |
|    [IconButton: Language]                       |
+-------------------------------------------------+
|                                                 |
|                                                 |
|                [Main Content]                   |
|                                                 |
|                                                 |
|                                                 |
|                                                 |
+-------------------------------------------------+
| [Bottom Navigation Bar]                         |
|                                                 |
|   [Tools]     [Home]      [Journal]             |
+-------------------------------------------------+
```

- **AppBar:** The bar at the top of the screen. It contains the language selection button.
- **Main Content:** The central part of the screen. It shows the main content of the selected feature.
- **Bottom Navigation Bar:** The bar at the bottom of the screen. It allows you to switch between the "Tools", "Home", and "Journal" screens.

## Language Selection Screen

The Language Selection Screen is an overlay that appears on top of the current screen.

```
+-------------------------------------------------+
| [AppBar]                                        |
|                                                 |
| [Back Button]   [Title: Languages]              |
+-------------------------------------------------+
|                                                 |
|           [List of Languages]                   |
|                                                 |
|   - Language 1                       [Radio]    |
|   - Language 2                       [Radio]    |
|   - ...                                         |
|                                                 |
|                                                 |
+-------------------------------------------------+
```

- **AppBar:** The bar at the top of the screen. It contains a back button and the title of the screen.
- **List of Languages:** A scrollable list of available languages. You can select a language by tapping on it.

# Main Concepts

This document explains the main concepts of the Menta app in simple terms.

## 1. The Shell

The "Shell" is the main frame of our application. It's like the frame of a house. It holds everything together. The shell is composed of:
- The **AppBar** at the top, which shows the title and action buttons.
- The **Bottom Navigation Bar** at the bottom, which allows you to switch between different screens.
- The **Page View** in the middle, which shows the content of the currently selected screen.

## 2. Features

Each screen in the app is a "Feature". We have a `features` directory where each feature has its own folder. This helps us keep the code organized. For example, the "Tools" screen is a feature, and all the code for it is in the `lib/features/tools/` directory.

## 3. Widgets

In Flutter, everything is a "Widget". A widget can be a button, a text, an icon, or even a whole screen. We create small, reusable widgets to build our UI. We have a `widgets` directory for widgets that are shared across multiple features.

## 4. State Management

"State" is the data that can change over time. For example, the currently selected language is a state. We use `StatefulWidget` to manage the state of our widgets. When the state changes, the UI is updated automatically.

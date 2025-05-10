# Flutter Article App

A simple Flutter app that displays articles from an API with search and favorite functionality.

## 🔧 Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/anandat/BharatNXT.git
   cd BharatNXT
   ```

2. Get the dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## 🧠 State Management

This app uses the **BLoC pattern** (`flutter_bloc`) for state management.
- `HomeBloc` handles loading articles, searching, and toggling favorites.
- UI updates automatically through `BlocBuilder` and `BlocListener` as states change.

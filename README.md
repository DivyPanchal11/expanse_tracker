# Expense Tracker

A modern Flutter + Firebase application that helps users manage their daily expenses, track spending habits, and visualize financial data through interactive analytics dashboards.

## Features

### Authentication

* User Registration
* User Login
* Secure Firebase Authentication
* Logout Functionality
* Auto Login with Splash Screen

### Expense Management

* Add Expense
* View Expense List
* Update Expense
* Delete Expense
* Real-time Firestore Updates

### Search & Filtering

* Search Expenses by Title
* Search Expenses by Category

### Analytics Dashboard

* Total Expenses
* Monthly Expenses
* Today's Expenses
* Category-wise Expense Distribution
* Dynamic Pie Chart Analytics
* Monthly Spending Bar Chart
* Real-time Analytics Updates

### User Experience

* Dark Mode Support
* Splash Screen
* Loading Indicators
* Error Handling with SnackBars
* Responsive UI
* Real-time Data Synchronization
* Bottom Navigation Bar

## Tech Stack

### Frontend

* Flutter
* Dart

### Backend

* Firebase Authentication
* Cloud Firestore

### State Management

* Provider

### Charts & Analytics

* fl_chart

## Project Structure

```text
lib/
├── providers/
│   └── theme_provider.dart
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── splash/
│   │   └── splash_screen.dart
│   ├── home/
│   │   ├── home_screen.dart
│   │   ├── expense_list_screen.dart
│   │   ├── add_expense_screen.dart
│   │   ├── analytics_screen.dart
│   │   └── profile_screen.dart
│   ├── widgets/
│   │   ├── expense_pie_chart.dart
│   │   └── monthly_bar_chart.dart
├── services/
│   ├── auth_service.dart
│   └── firestore_service.dart
├── utils/
│   ├── light_theme.dart
│   └── dark_theme.dart
├── firebase_options.dart
└── main.dart
```

## Installation

### Clone Repository

```bash
git clone https://github.com/DivyPanchal11/expanse_tracker.git
cd expanse_tracker
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

## Firebase Setup

### Step 1: Create Firebase Project

* Open Firebase Console
* Create a New Project
* Enable Authentication (Email/Password)
* Enable Cloud Firestore

### Step 2: Configure FlutterFire

```bash
flutterfire configure
```

### Step 3: Install Firebase Packages

```bash
flutter pub add firebase_core
flutter pub add firebase_auth
flutter pub add cloud_firestore
```

### Step 4: Initialize Firebase

Ensure Firebase is initialized in `main.dart`.

## Dependencies

* firebase_core
* firebase_auth
* cloud_firestore
* provider
* fl_chart
* flutter_launcher_icons

## Current Features Completed

* Firebase Authentication
* User Registration & Login
* Splash Screen
* Expense CRUD Operations
* Firestore Integration
* Search Functionality
* Analytics Dashboard
* Pie Chart Visualization
* Monthly Bar Chart
* Dynamic Expense Tracking
* Dark Mode Toggle
* Profile Screen
* Loading States
* Error Handling
* Responsive UI
* Custom App Icon

## Future Enhancements

* Expense Budget Planning
* Income Tracking
* PDF Report Export
* Expense Categories Management
* Notifications & Reminders
* Cloud Backup
* Monthly Financial Reports

## Author

### Divy Panchal

Built with Flutter, Firebase, Firestore, Provider, and Dart.

## License

This project is for educational and portfolio purposes.

# 📰 Flutter News App
### Modern News Application Built with Flutter

Flutter News App is a modern mobile news application that delivers the latest headlines from around the world using the **NewsAPI** service. The application provides an intuitive interface for browsing top headlines, searching articles, exploring trending news, and reading detailed news content.

The project demonstrates REST API integration, asynchronous data fetching, responsive UI development, and local preference management using Flutter.

---

## ✨ Features

- 📰 Top Headlines
- 🔥 Trending News
- 🔍 Search News
- 📂 Browse by Category
- 📖 Article Detail Page
- 🌙 Dark Mode Support
- 👤 Developer Profile
- 🌐 Open Original Article in Browser
- ⚡ Fast REST API Integration

---

## 📱 Screens

- Home
- Trending News
- Category News
- Search Result
- Article Detail
- Developer Profile

---

## 🏗 Project Structure

```
lib/
│
├── main.dart
├── home_page.dart
├── category_page.dart
├── trending_page.dart
├── detail_page.dart
├── profile_page.dart
├── news_model.dart
└── news_service.dart
```

---

## ⚙️ Technology Stack

| Technology | Description |
|------------|-------------|
| Flutter | Cross-platform Mobile Framework |
| Dart | Programming Language |
| NewsAPI | News Data Provider |
| HTTP Package | REST API Communication |
| Shared Preferences | Local Storage |
| URL Launcher | Open News Source |
| Material Design | UI Components |

---

## 📡 API Integration

The application retrieves news data from:

**NewsAPI**

Features provided by the API include:

- Top Headlines
- Search News
- Trending Articles
- Category-based News

---

## 📂 Core Components

### Home Page

- Latest Headlines
- Search Bar
- Featured News
- Navigation Menu

### Trending News

- Popular News Articles
- Real-time Headlines
- Article Preview

### Category

Browse articles by selected categories.

Examples:

- Business
- Technology
- Sports
- Entertainment
- Health
- Science

### Detail Article

Displays:

- News Image
- Title
- Author
- Published Date
- Description
- Full Content
- Open Original Source

### Profile

Developer information including:

- Profile Picture
- Name
- Email
- Personal Information

---

## 🔄 Application Flow

```
Splash
   │
   ▼
Home
   │
   ├───────────────┐
   ▼               ▼
Trending       Categories
   │               │
   └──────┬────────┘
          ▼
     Detail Article
          │
          ▼
   Open Original News
```

---

## 🚀 Getting Started

### Requirements

- Flutter SDK 3.x+
- Dart SDK
- Android Studio / VS Code
- Android Emulator or Physical Device

---

### Installation

Clone repository

```bash
git clone https://github.com/your-username/flutter-newsapp.git
```

Move into project

```bash
cd flutter-newsapp
```

Install dependencies

```bash
flutter pub get
```

Run application

```bash
flutter run
```

---

## 📦 Dependencies

```yaml
http
shared_preferences
url_launcher
```

---

## 🎯 Design Principles

- Simple User Experience
- Responsive Interface
- RESTful API Communication
- Modular Components
- Clean Navigation
- Lightweight Architecture

---

## 📈 Future Improvements

- User Authentication
- Bookmark Favorite News
- Push Notifications
- Infinite Scrolling
- Pagination
- Multiple News Sources
- Offline Reading
- Localization (Multi-language)
- Firebase Analytics
- AI-based News Recommendation

---

## 👨‍💻 Developer

**Nizam Hukmul Kautsar**

Computer Science Student

Universitas Islam Negeri Maulana Malik Ibrahim Malang

---

## 📄 License

This project was developed for educational purposes and portfolio demonstration.

# News Example App

A modern news application that provides users with up-to-date news articles from various sources using the News API. Built with **Swift** and **UIKit**, this application offers a clean and intuitive interface for users to browse, search and share news articles.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Requirements](#requirements)
- [Screenshots](#screenshots)
- [Usage Video](#usage-video)

---

## Overview

The News app is designed to deliver a seamless news reading experience with features like article sharing, search functionality, and customizable settings. Built using **MVVM** architecture, the app demonstrates best practices in iOS development including responsive design, dark mode support, pagination and search.

---

## Features

- **Splash Screen**  
  - A welcoming splash screen featuring the app icon and name.

- **News Feed**
  - Dynamic list of news articles from News API
  - Smooth scrolling and responsive layout
  - Bottom sheet for sharing options
  - Native share functionality for article links
  - Pagination for seamless content loading
  - Loading state indicators during pagination
  - Smart cache management for paginated content

- **Advanced Search**
  - Native search bar implementation
  - Smart search with 3+ character threshold
  - Smooth animations for search results
  - Real-time API integration
  - Paginated search results

- **Article Details**
  - Full article view with rich content
  - Image loading with Kingfisher
  - Share functionality
  - Dynamic navigation bar title

- **Settings**
  - Theme toggle (Light/Dark mode)
  - Push notification management
  - App rating integration
  - Privacy policy and Terms of use
  - Dynamic theme switching

- **Responsive Design**
  - Support for all iPhone models
  - iPad compatibility
  - Landscape orientation support
  - Auto Layout implementation

---

## Architecture

![MVVM](https://github.com/user-attachments/assets/30031f29-08b6-4002-a487-28c12ba6f830)

The application follows the **MVVM+Protocol** architecture pattern:

### 📦 Model
- Defines the data structures, including news articles and app settings.
- Contains no business logic — purely represents data.

### 🎛 ViewModel (Business Logic)
- Acts as an intermediary between View and Model.
- Uses protocols to communicate with View and decouple dependencies.
- Handles data fetching, transformation, and state management.
- Implements core features like searching and settings updates.

### 🖥 View (UI)
- Built using **UIKit**, supporting **programmatic UI**.
- Uses `UITableView` for displaying articles.
- Observes the ViewModel for state changes via delegation.
- Sends user actions to ViewModel through protocols.

This pattern ensures a modular, maintainable, and scalable codebase.

---

## Technologies Used

- **Swift**  
  Primary programming language

- **UIKit**  
  Framework for building the user interface

- **Kingfisher**  
  For efficient image loading and caching

- **News API**  
  Primary data source for news articles

- **Snapkit**  
  For programmatic responsive design implementation

- **UserNotifications**  
  For handling push notifications

---

## Installation

1. **Clone the repository**  
   ```bash
   git clone https://github.com/yourusername/news-app.git
   ```

2. **Navigate to Project Directory**
   ```bash
   cd news-app
   ```

3. **API Key Setup**
   - Get an API key from [News API](https://newsapi.org/)
   - Add your API key to the configuration

4. **Open Project**
   ```bash
   open News.xcodeproj
   ```

---

## Requirements

- iOS 17.0+

---

## Key Implementation Goals

- Clean MVVM architecture implementation
- Reusable TableView components with enums and sections
- Robust network layer
- Efficient view model logic
- Light/Dark mode support
- Pagination support for listing news
- Proper auto layout support for various screen sizes

---

## Screenshots

| Screen                | Light Mode            | Dark Mode             |
|----------------------|------------------------|------------------------|
| News Feed            | ![News Feed Light](https://github.com/user-attachments/assets/faee1cae-a7cb-45e1-b254-4db230b1a955) | ![News Feed Dark](https://github.com/user-attachments/assets/625bf9ab-33ea-41ac-a146-30917e396944) |
| Article Detail       | ![Article Detail Light](https://github.com/user-attachments/assets/6ac6b32e-7b40-47f2-8dd9-651240cb79f8) | ![Article Detail Dark](https://github.com/user-attachments/assets/c80b0c6e-e3ed-4ffe-b92d-1ecca5a55545) |
| Search Results       | ![Search Results Light](https://github.com/user-attachments/assets/f74d48c6-fb57-49dd-a8ee-27b838b7e9ee) | ![Search Results Dark](https://github.com/user-attachments/assets/73649961-f3fa-4281-8792-c13626e18059) |
| Settings             | ![Settings Light](https://github.com/user-attachments/assets/27e256f1-60b2-4e42-9bf8-22684dacfb7c) | ![Settings Dark](https://github.com/user-attachments/assets/0eae7b8e-83ef-4a09-8587-741ab1dcbf2e) |

---

## [Usage Video](https://1drv.ms/v/c/5fedba1a2e8824e9/EXMaW4uTjO1FsGflgXWuRssBvMIwOIah5ks_sIh2j6ePkA?e=OOvulv)

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

The application follows the **MVVM+Protocol** architecture pattern:

- **Model**  
  Represents the data structures for news articles and app settings.

- **View**  
  - Built using UIKit
  - Supports both Storyboard and programmatic UI
  - Implements CollectionView for news listing
  - Responsive design across all devices

- **ViewModel**  
  - Handles business logic
  - Manages API calls and data processing
  - Implements search functionality
  - Handles settings management

---

## Technologies Used

- **Swift**  
  Primary programming language

- **UIKit**  
  Framework for building the user interface

- **Kingfisher**  
  For efficient image loading and caching

- **Google News API**  
  Primary data source for news articles

- **Auto Layout**  
  For responsive design implementation

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
- Reusable TableView components
- Robust network layer
- Efficient view model logic
- Light/Dark mode support

---

## Screenshots

| Screen                | Light Mode            | Dark Mode             |
|----------------------|------------------------|------------------------|
| Splash Screen        | [Image]               | [Image]               |
| News Feed            | [Image]               | [Image]               |
| Article Detail       | [Image]               | [Image]               |
| Search Results       | [Image]               | [Image]               |
| Settings             | [Image]               | [Image]               |

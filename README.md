# AppsForBharat Assignment

## Overview
This project is an assignment for AppsForBharat, implementing a static page using the VIPER architecture and programmatic UIKit. It demonstrates clean code organization, adherence to iOS development best practices, and efficient UI implementation without the use of storyboards.

## Features
- Static page implementation
- VIPER architecture
- Programmatic UIKit
- Mock data fetching to simulate API calls
- Swift Package Manager for dependency management

## Architecture
The project follows the VIPER (View, Interactor, Presenter, Entity, Router) architecture:

- **View**: Manages the UI and user interactions
- **Interactor**: Handles business logic and data operations
- **Presenter**: Mediates between View and Interactor, prepares data for presentation
- **Entity**: Represents data models
- **Router**: Manages navigation between modules

## Dependencies
- SDWebImage: Used for efficient image loading and caching

## Setup and Installation
1. Clone the repository:
   ```
   git clone https://github.com/MISHANDLED/AppAssignment.git
   ```
2. Navigate to the project directory:
   ```
   cd apps-for-bharat-assignment
   ```
3. Open the `.xcodeproj` file in Xcode:
   ```
   open Task.xcodeproj
   ```
4. Wait for Xcode to resolve the SPM packages automatically

## Running the Project
1. Select your target device or simulator in Xcode
2. Press `Cmd + R` or click the "Run" button in Xcode

## Project Structure
```
.
├── README.md
├── Task
│   ├── AppDelegate.swift
│   ├── Assets.xcassets
│   ├── Base.lproj
│   │   └── LaunchScreen.storyboard
│   ├── Info.plist
│   ├── MovieDetails
│   │   ├── MovieDetailEntity.swift
│   │   ├── MovieDetailInteractor.swift
│   │   ├── MovieDetailPresenter.swift
│   │   ├── MovieDetailRouter.swift
│   │   ├── MovieDetailViewController.swift
│   │   ├── MovieDetailsContracts.swift
│   │   └── Views
│   │       ├── AboutView
│   │       │   ├── AboutView.swift
│   │       │   └── AboutViewItemCell.swift
│   │       ├── BookingView
│   │       │   ├── BookingsView.swift
│   │       │   ├── TimerLabel.swift
│   │       │   ├── TimerView.swift
│   │       │   ├── UserImageStackView.swift
│   │       │   └── UserImageView.swift
│   │       ├── DetailsView
│   │       │   ├── DetailsView.swift
│   │       │   └── IconLabelView.swift
│   │       └── ImageCarousel
│   │           ├── ImageCarouselCell.swift
│   │           └── ImageCarouselView.swift
│   ├── SceneDelegate.swift
│   └── Utilities
│       ├── Color+Extension.swift
│       └── Date+Extension.swift
└── Task.xcodeproj
```
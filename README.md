# CodeBuilder

Welcome to **CodeBuilder**! CodeBuilder is an educational iOS application designed to help users learn and practice coding skills in a fun and interactive way. The app provides a platform where users can solve coding problems by arranging code blocks, read educational articles, participate in daily challenges, and engage with a community through a built-in forum.

## Table of Contents
-	Features
- Requirements
- Installation
- Usage
- App Structure
- Screenshots
- Technologies Used
- Contributing
- License
- Contact

## Features
- Interactive Problem Solving: Solve coding problems by dragging and dropping code blocks to build correct solutions.
- Daily Challenges: Tackle a new coding challenge every day to keep your skills sharp.
- Educational Articles: Access a library of articles covering fundamental programming concepts and algorithms.
- User Authentication: Sign up and log in securely using Firebase Authentication.
- Progress Tracking: Keep track of problems solved, streaks, and overall progress.
- Community Forum: Engage with other users by asking questions and sharing knowledge.
- User Profiles: Manage your account information and view your achievements.
- Responsive Design: Supports both light and dark modes with adaptive layouts.

## Requirements
- Xcode 15.0 or later
- iOS 17.0 or later
- Swift 5.9
- CocoaPods (for dependency management)
- Firebase Account (for authentication and database services)

## Installation
1. Clone the Repository
  ```bash
  git clone https://github.com/yourusername/CodeBuilder.git
  cd CodeBuilder
  ```

2. Install Dependencies
Ensure you have CocoaPods installed. If not, install it using:
  ```bash
  sudo gem install cocoapods
  ```
Install the required pods:
  ```bash
  pod install
  ```
3. Open the Project
Open the workspace file in Xcode:
```bash
open CodeBuilder.xcworkspace
```
4. Configure Firebase
- Create a new project in the Firebase Console.
- Add an iOS app to your Firebase project.
- Download the GoogleService-Info.plist file and add it to your project in Xcode.
- Enable Email/Password authentication in the Firebase Console.
- Enable Firestore Database and set the appropriate security rules.

## Usage
1.	Build and Run
  - Select a simulator or connect a device, then build and run the project from Xcode.
2.	Sign Up or Log In
  - Create a new account using your email and a password.
  - Alternatively, sign in if you already have an account.
3.	Explore Features
  - Home: View your progress and navigate to different sections.
  - Problems: Browse and solve coding problems.
  - Daily Challenge: Attempt the daily coding challenge.
  - Forum: Interact with the community by reading and creating posts.
  - Settings: Manage your account and app preferences.
 4.	Solve Problems
  - Drag and drop code blocks from the available blocks section to the solution area.
  - Check your solution and receive immediate feedback.
  - Read related articles to understand the concepts better.

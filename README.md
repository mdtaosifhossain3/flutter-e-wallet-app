# E-Wallet App
![image alt](https://github.com/mdtaosifhossain3/flutter-e-wallet-app/blob/1950c8ff7f395cb8e32027ad46a29262fac7f90f/e-wallet-app-mockup.jpeg)

## Overview

This is a Flutter-based e-wallet application that allows users to manage their finances seamlessly. With Firebase integration for authentication and database management, users can securely send and receive money, and view transaction history. The app is built using GetX for efficient state management.

## Features

- **User Authentication:** Secure login and registration using Firebase Authentication.
- **Send Money:** Transfer funds to other users within the app.
- **Receive Money:** Accept payments from other users.
- **Transaction History:** View a detailed history of all transactions.
- **State Management:** Implemented using GetX for smooth and efficient performance.

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/mdtaosifhossain3/flutter-e-wallet-app.git
   cd flutter-e-wallet-app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Set up Firebase:**
   - Create a Firebase project in the [Firebase Console](https://console.firebase.google.com/).
   - Add your Android and iOS app to the Firebase project.
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) and place them in the appropriate directories (`android/app` and `ios/Runner` respectively).
   - Enable Firebase Authentication and Firestore Database in the Firebase Console.

4. **Run the app:**
   ```bash
   flutter run
   ```

## Usage

- **Registration:** New users can register using their email and password.
- **Login:** Existing users can log in using their credentials.
- **Send Money:** Navigate to the send money screen, enter the recipient's details and the amount, and confirm the transaction.
- **View Transactions:** Go to the transaction history to see all past transactions.

## Technologies Used

- **Flutter:** Cross-platform app development framework.
- **Firebase Authentication:** Secure user authentication.
- **Firebase Firestore:** Real-time database for storing user data and transactions.
- **GetX:** State management, dependency injection, and route management.

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request for any features, bug fixes, or enhancements.

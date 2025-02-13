# Simple Image Gallery App (Flutter)

This project creates a simple image gallery app in Flutter, allowing users to view images in a ListView and select images from their device's gallery.

## Task Description

The app displays images in a scrollable list (ListView).  A "Pick Image" button allows users to select images from their device, which are then added to the gallery.

## Requirements

*   **Requirement 1:** Add a ListView to your app.  Create a page that has a ListView where the images will be displayed.
*   **Requirement 2:** Add a button to choose photos from the device. Build a button below your list named "Pick Image." When clicked, it opens the device's gallery, allowing the user to select multiple images.  Once the user is done selecting, the chosen images are displayed in the ListView.

## Project Overview

This Flutter app uses the `image_picker` package to access the device's gallery and display selected images in a `ListView`.

## Getting Started

1.  **Clone the repository (if applicable).**

2.  **Install Dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the app:**

    ```bash
    flutter run
    ```

## Code Explanation (Simplified)

The `lib/main.dart` file contains the Flutter code. It uses the `image_picker` package to select images from the device gallery. The selected images are then displayed in a `ListView`. The "Pick Image" button triggers the image selection process.

## Dependencies

*   `image_picker`: Used for accessing the device's gallery. Add this to your `pubspec.yaml` file.

## Screenshots

<p float="left">
  <img src="https://github.com/user-attachments/assets/26450503-00fc-4c30-b66b-f9944991fa02" width="200" />
  <img src="https://github.com/user-attachments/assets/7189c4d5-1f38-4b5a-8ac6-233a793c2c1f" width="200" /> 
  <img src="https://github.com/user-attachments/assets/f4701cef-ba42-418c-b309-bcf6bf72151a" width="200" /> 
</p>


## Version

1.0.0

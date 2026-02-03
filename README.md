# Onboarding App

A Flutter app with a smooth onboarding flow, location permission handling, and alarm management.

## Features

- **Onboarding Screens**: Three interactive onboarding pages to guide new users.  
  - State managed with **GetX (`Obx`)** for reactive updates.
- **Skip Button**: Users can skip onboarding if they want.
- **Location Permission**: Request and fetch user's location for location-based functionality.
- **Alarm Management**:
  - Set alarms
  - Edit alarms
  - Toggle alarms on/off
  - Display notifications for alarms
- **Third-party Packages**: Utilizes external Flutter packages for enhanced functionality (e.g., notifications, location, onboarding).

## Technology Used

- **Flutter**: UI toolkit for building natively compiled applications.  
- **Dart**: Programming language for Flutter development.  
- **GetX**: State management using `Obx` for reactive onboarding flow.  
- **introduction_screen**: For creating onboarding pages.  
- **permission_handler**: To request and manage location permissions.  
- **geolocator**: To fetch user location.  
- **flutter_local_notifications**: To set and manage alarms with notifications.

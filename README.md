# Flutter IOT Energy
IoT Energy allows you to control IoT devices from anywhere (without being connected to the local network).
A new Flutter project.

### Introduction
**IoT Energy** is a Flutter application that enables users to control IoT-enabled devices remotely, eliminating the need for local network connections. With a user-friendly interface, IoT Energy offers easy access to device settings, real-time monitoring of device status, and energy consumption tracking. Users can also create custom scenes, allowing for automation based on specific conditions, such as time intervals or events, adding flexibility and convenience to their smart home or workspace.

Designed with collaborative control in mind, IoT Energy also supports scenarios where multiple users manage the same device. When a device is shared, existing scenes associated with that device become available to new users, ensuring a seamless experience across shared accounts. The app’s battery monitoring feature displays charge levels for battery-powered devices, helping users stay informed about their device’s power status at all times.


<img src="https://github.com/user-attachments/assets/f21b8fa7-166d-4e50-b13b-87a0759f23cc" height="300" style="display: inline-block; margin-right: 10px;">
<img src="https://github.com/user-attachments/assets/a777c39a-eb02-4d90-9faf-3ef52fcca74e" height="300" style="display: inline-block;">

### Features

- **Remote IoT Device Control**  
  Control your IoT devices from anywhere, without needing to connect to the same local network. Whether at home, work, or on the go, IoT Energy enables seamless device management remotely.

- **Real-Time Data Monitoring**  
  Receive up-to-date data from all connected devices in real time. Monitor key metrics such as device status, battery levels, and usage statistics instantly, ensuring you always have a complete view of your device network.

- **Customizable Automation Scenes**  
  Create custom scenes to automate device behavior based on specific conditions, such as time-based triggers or device status changes. With automation scenes, you can streamline routines and increase the efficiency of your device network.


## Installation and Setup

### Prerequisites
- **Flutter SDK**: Ensure that Flutter is installed on your machine. [Download Flutter](https://flutter.dev/docs/get-started/install).
- **Firebase Account**: You need a Firebase account and a project set up to connect the app.

### 1. Clone the Repository
Clone this repository to your local machine:

```
git clone https://github.com/CanArslanDev/flutter_iot_energy.git
cd flutter_iot_energy
```

### 2. Install Dependencies
Run the following command to install the necessary Flutter packages:

```
flutter pub get
```

### 3. Firebase Setup
1. Go to the [Firebase Console](https://console.firebase.google.com/), create a new project, and add an Android/iOS app.
2. Download the `google-services.json` file for Android and place it in `android/app`. For iOS, download `GoogleService-Info.plist` and place it in `ios/Runner`.
3. In Firebase, enable **Firestore** for data storage and **Authentication** for user management.

### 4. Configure FlutterFire
Run this command to link Firebase to your Flutter project:

```
flutterfire configure
```

### 5. Run the App
Now, start the app on an emulator or device:

```
flutter run
```

Your app should now be set up and connected to Firebase!


## To Do List For Future
**To Do List:**
- Device settings page will be implemented.
- When a device is added on the home page, the devices section will be automatically updated.
- If there is no scene, an "Add Scene" option will appear on the scene page.
- Check if leading zeros are added when setting dates from Arduino.
- The charge icon in the home page devices widget will only appear for devices with batteries.
- Charge/home scene icon will be created, and it will be fetched from the search and the home page.
- When adding a scene from the device detail page, the "1 active scene" section will suddenly appear. An animation will be added for smoother transition.
- A feature to rename scenes will be added.
- Last active scene information will be added to the device detail page.
- Battery charge status will be added for devices (this can be added to the Status).
- If another person adds the same device that already has scenes from a different account, the previously added scenes will not appear in the new account. When a new device is added, the old scenes will also appear in the new account.

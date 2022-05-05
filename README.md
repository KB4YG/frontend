# Table of Contents
1. [Introduction](#introduction)
2. [Running Locally](#running-locally)
3. [Folder Structure](#folder-structure)
4. [Application Flow](#program-flow)
5. [Implementation Details](#implementation-details)
6. [Deployment](#deployment)
7. [Future Development](#future-development)


## Introduction

Know Before You Go (KB4YG) is


### Resources

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view the [online documentation](https://flutter.dev/docs), 
which offers tutorials, samples, guidance on mobile development, and a full API reference.


## Running Locally
1. Install Flutter: https://docs.flutter.dev/get-started/install
2. Set up IDE (Android Studio recommended): https://docs.flutter.dev/get-started/editor
3. Clone Repo: Run <code>git clone https://github.com/KB4YG/frontend</code> from terminal
4. Install Packages: Navigate to cloned folder and run <code>flutter pub get</code> from terminal
5. Run: Open cloned folder in editor and run with Chrome (or other browser), physical Android phone, 
   or device emulator (see https://docs.flutter.dev/get-started/test-drive)


## Folder Structure


## Program Flow
![Startup program flow](doc/img/startup-flowchart.png)
First, we enter the main() function in main.dart, where the code initializes and runs App(). 
The App() (widgets/app.dart) widget checks whether it is the user's first time running the app on 
and on what platform.

If not on the web (i.e., using the mobile app) and the user hasn't opened the app before, the IntroScreen() 
(screens/intro_screen.dart) is displayed and guides the user through the various screens within the app. 
Afterwards (or if the user has opened the application before), the AppScreen() is built and displayed

After the above occurs on the mobile app or if the user is accessing the website, the HomeScreen() 
(screens/home) introduces the application, at which point the user is able to navigate to any of the 
main screens as shown below.
![Screen flowchart](doc/img/screens.png)
The text boxes at the top of each column show the page name displayed to the user (i.e., what they
click/tap on) while each rounded rectangle represents a particular screen.

On the web, the user clicks on one of the items in the Navbar() (widgets/navbar.dart) (or in 
the NavigationDrawer() (widgets/navigation_drawer.dart) on a phone) to navigate to a particular page. 
On mobile, the user taps on one of the bottom tabs of the CustomTabBar() (widgets/custom_tab_bar.dart).


## Implementation Details


## Deployment


### How to Deploy Website

Running <code>git push</code> triggers a GitHub action that deploys the site with Firebase. 
See https://www.youtube.com/watch?v=xJo7Mqse960 and the related 
[repo](https://github.com/JohannesMilke/flutter_firebase_hosting/blob/master/.github/workflows/main.yml) for more information.

### How to Deploy Mobile App


## Future Development

### Known Bugs

### Areas for Improvement

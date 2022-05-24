# Table of Contents
1. [Introduction](#introduction)
2. [Running Locally](#running-locally)
3. [Folder Structure](#folder-structure)
4. [Application Flow](#application-flow)
5. [Implementation Details](#implementation-details)
6. [Deployment](#deployment)
7. [Future Development](#future-development)


## Introduction

Know Before You Go (KB4YG) is a cross-platform Flutter application available on Android, iOS, and 
the web.


### Resources

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [YouTube Playlist](https://www.youtube.com/playlist?list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ)

For help getting started with Flutter, view the [online documentation](https://flutter.dev/docs), 
which offers tutorials, samples, guidance on mobile development, and a full API reference.


## Running Locally
Before beginning setting up this project, it’s essential to know that there is a slight chance that you might run into trouble setting up the environment flutter. For troubleshooting, I would recommend [Google](https://www.google.com/) searching these issues or searching on [YouTube](https://www.youtube.com/) for a troubleshooting video that matches the problem that you are having.

1. Install Flutter: https://docs.flutter.dev/get-started/install
2. Set up IDE (Android Studio recommended): https://docs.flutter.dev/get-started/editor
3. Clone Repo: Run `git clone https://github.com/KB4YG/frontend` from terminal
4. Install Packages: Navigate to cloned folder and run `flutter pub get` from terminal
5. Run: Open cloned folder in editor and run with Chrome (or other browser), physical Android phone, 
   or device emulator (see https://docs.flutter.dev/get-started/test-drive)


## Folder Structure
One of the most confusing aspects of Flutter (initially, at least) for us was the folder structure.
This section attempts to demystify this default structure while also explaining our additions. For 
reference, our folder structure was informed by [this style guide](https://www.geeksforgeeks.org/flutter-file-structure/)

By default, Flutter created three main folders in the root directory: lib, android, ios, and web.
The latter three folders contain files specific to their respective platforms. Very few files in these
directories were manually added or modified by us, so a newcomer hoping to familiarize themself with
our codebase might best ignore them for now. The following list describes the purpose of every 
notable folder in the project:

![Lib file structure image]([https://github.com/KB4YG/frontend/blob/doc-test/doc/img/lib_file_structure.png](https://github.com/KB4YG/frontend/blob/doc-test/doc/img/lib%20file%20structure.svg))

- `.github`: Workflows associated with this repository (see [How to Deploy Website](#deployment)).
- `android`: Android specific files.
- `assets`: Static assets (fonts, home screen images, logo, etc.).
- `doc`: Documentation files (e.g., the images within this README).
- `ios`: iOS specific files.
- `lib`: Widgets, classes, and functions that make up the KB4YG application. ("library".)
- `web`: Web specific files.
- `lib/extensions`: Helper functions for pre-existing classes (e.g., `String.Capitalize()`). 
- `lib/models`: Classes that modularize and help interact with data from the backend.
- `lib/providers`: Singletons used throughout the application, typically to interact with external APIs.
- `lib/screens`: Primary views of the user interface of the app.
- `lib/utilities`: Functions or logic used in the app.
- `lib/widgets`: Widgets (discrete "object" on screen) / layouts.


## Application Flow
![Startup program flow](doc/img/startup-flowchart.png)

First, we enter the `main()` function in `main.dart`, where the code initializes and runs `App()`. 
The `App()` (`widgets/app.dart`) widget checks whether it is the user's first time running the app 
and on what platform.

If not on the web (i.e., using the mobile app) and the user hasn't opened the app before, the `IntroScreen()` 
(`screens/intro_screen.dart`) is displayed and guides the user through the various screens within the app. 
Afterwards (or if the user has opened the application before), the `AppScreen()` is built and displayed

After the above occurs on the mobile app or if the user is accessing the website, the `HomeScreen()` 
(`screens/home`) introduces the application, at which point the user is able to navigate to any of the 
main screens as shown below.

![Screen flowchart](doc/img/screens.png)

The text boxes at the top of each column show the page name displayed to the user (i.e., what they
click/tap on) while each rounded rectangle represents a particular screen.

On the web, the user clicks on one of the items in the `Navbar()` (`widgets/navbar.dart`) (or in 
the `NavigationDrawer()` (`widgets/navigation_drawer.dart`) on a phone) to navigate to a particular page. 
On mobile, the user taps on one of the bottom tabs of the `CustomTabBar()` (`widgets/custom_tab_bar.dart`).


## Implementation Details

### Models

### Backend Connection

### Screens

### Routing / Navigation

### Theme

### Testing
We created a file (`benton_county.dart`) to model how data is stored in the backend. So on any screen
that queries the backend for information (`CountyListScreen()`, `CountyScreen()`, `RecreationAreaScreen()`),
one may replace backend context accessor (`BackendProvider.of(context).getCounty(widget.countyUrl);`)
with a future constructor that uses the test file (`Future<County>.value(County.fromJson(bentonCountyJson));`).
This way one can more easily test and modify location data without affecting information in the database.

## Deployment
### How to Deploy Website

Running `git push` triggers a GitHub action that automatically deploys the site with Firebase.
IMPORTANT: this means that any merge or push to master will rebuild the website, so the master branch 
is tied with production. Note that a failed build will leave the site unchanged and Firebase allows 
you to rollback to previous site versions.

(See https://www.youtube.com/watch?v=xJo7Mqse960 and the related 
[repo](https://github.com/JohannesMilke/flutter_firebase_hosting/blob/master/.github/workflows/main.yml) 
for more information on GitHub flows.)

We chose Firebase since it was easy to both setup a Flutter application and purchase a domain from 
Google Domains. Using the [Firebase console](https://console.firebase.google.com), one is able to 
rollback the site to previous versions, handle domains, and monitor usage. 

[comment]: <> ([Website downloads for the month of May]&#40;doc/img/firebase-hosting-usage.png&#41;)

NOTE: Firebase (free tier) has a 10 GB storage limit (which shouldn't be an issue since you can just 
delete old versions of the site) and a 10 GB download limit. Given that each page might cause the 
user to download around 13 KB (according to [this site](https://sitechecker.pro/page-size/)) we don't 
expect this limit to be an issue with the current popularity of our project, but this could change as
KB4YG grows in popularity.

### How to Deploy Mobile App
Here are some resources that will provide you with a step by step process on how to publish or update your mobile app to the app store: 

- These links will lead you to the most up to date resources because it's written the Google Flutter team: 

  - For Android (Google Play Store) - https://docs.flutter.dev/deployment/android
  - For IOS (App Store) - https://docs.flutter.dev/deployment/ios

- If you rather watch a video, here are some links to videos on flutter app deployment:

  - For Android (Google Play Store) - https://www.youtube.com/watch?v=g0GNuoCOtaQ&ab_channel=JohannesMilke

  - For IOS (App Store) - https://www.youtube.com/watch?v=akFF1uJWZck&ab_channel=MJSDCoding

## Future Development

### Known Bugs

- Gestures seem to be disabled / don't work correctly on phones with Firefox (Chrome works great though). 
  We suspect this may just be a limitation of Flutter on non-chromium based browsers.
- Refreshing the ParkingLot()s (models/parking_lot.dart) of a ParkingMap() (widgets/maps/parking_map.dart)
  updates the spot counts but will cause errors if the number of locations shrinks. I.e., a given pin
  will not disappear even if one calls setState() to update the parking lots in a ParkingMap()'s 
  parent widget. Tapping on this defunct card on the map will cause an exception due to the underlying
  data no longer existing. We prioritized our time elsewhere as the likelihood of the number of parking
  lots reducing between reloads is low/non-existent. Stated differently, while the spot counts may 
  change, there would be no reason (save for some backend error) why a given parking lot would cease
  to be in the database. One potential solution would be to attach a ChangeNotifier() or some other
  listener as a parent to a ParkingMap().

### Areas for Improvement

- Currently, the web application has a "View Locations" button while the mobile app does not. This is 
  due to being unable to navigate between different `BeamerDelegate()`s multiple times. Specifically, 
  the mobile app has a separate `BeamerDelegate()` for each tab (which is necessary for saving nested 
  navigation), so using `Beamer.of(context).beamToNamed({});` seems to check only the delegate of that 
  tab rather than the tab we want to navigate to. We were unable to figure out a work-around due to 
  time constraints and its low urgency.
- Recreationists may want to know the temperature / weather of a location, so it may be worth 
  incorporating an external API like the OpenWeatherAPI.
- The about section for a given recreation area is retrieved from the backend. These paragraphs 
  sometimes contain web addresses, but we are unable to display them as links easily. Maybe create a 
  parser that creates the necessary `TextSpan()` links from the related field in the 
  `RecreationArea()` model, making the addresses clickable.
- One downside of Flutter for the web is poor SEO (search engine optimization). Hopefully, the 
  Flutter development team will improve SEO in a future update. But in the interim, one  may be able 
  to create a normal, static HTML page that users will first visit before starting up the actual 
  application, or just add meta tags to index.html. [PageSpeed Insights](https://pagespeed.web.dev/report?url=kb4yg.org) 
  can evaluate a website's performance and [this blog post](https://cinnamon.agency/blog/post/flutter_and_seo) 
  describes the SEO problem in more detail.

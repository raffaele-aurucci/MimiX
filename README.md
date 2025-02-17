<p align="center">
    <img width="200" src="https://github.com/user-attachments/assets/f7322182-7f81-4e71-89c6-f6d01fcbb6c2" alt="MìmiX logo">
</p>

<h3 align="center">
 MìmiX
</h3>

<p align="center">
 A <b>Digital Therapeutics app</b> designed to support the execution of facial expression exercises :innocent:.  
</p>

<p align="center">
 <a href="#"><img src="https://img.shields.io/github/contributors/raffaele-aurucci/MìmiX?style=for-the-badge" alt="Contributors"/></a>
 <img src="https://img.shields.io/github/last-commit/raffaele-aurucci/MìmiX?style=for-the-badge" alt="last commit">
</p>

<div align="center">
  
[@raffaele-aurucci](https://github.com/raffaele-aurucci), [@CSSabino](https://github.com/CSSabino), [@DomenicoAnzalone](https://github.com/DomenicoAnzalone)

</div>



# Mìmix

Every day, millions of people with facial muscle degeneration see their ability to move gradually decline. Rehabilitation is essential, but it’s often boring and hard to follow consistently.  

The problem? Without regular exercise, the degeneration progresses more rapidly. And when exercises are repetitive and unengaging, it’s easy to give up.  

That’s why we created **MìmiX**: an innovative **Digital Therapeutics app** that turns therapy into a game! Using **AI-powered Facial Expression Detection**, our app offers targeted exercises through interactive mini-games, helping users slow down the loss of facial mobility in a fun and effective way.  

The experience is enhanced with **Gamification techniques**: increasing levels of challenge, tasks to complete, milestones to reach, and rewards to win-making the process engaging and motivating.

***"With MìmiX, we want to help people preserve their facial expressions… one smile at a time!"*** 😊

## Table of Contents 
- [App Overview](#app-overview)
   - [Home Page](#home-page)
   - [Minigame Pages](#minigame-pages)
   - [Training Pages](#training-pages)
- [Architecture](#architecture)
- [Repository Contents](#repository-contents)
- [Installation Guide](#installation-guide)

## App Overview

### Home Page
![HOME_PAGE](https://github.com/user-attachments/assets/51e0c380-628b-4715-b101-fa2fce156a08)

### Minigame Pages
<div>
  <img src="https://github.com/user-attachments/assets/e32d4412-cdca-4ecd-b4c6-66f3560d5c0d" alt="FACE_BREAKOUT"> &nbsp;
  <img src="https://github.com/user-attachments/assets/7254e9f0-c56e-425a-aa2d-29de7dd67180" alt="FACE_RUN"> &nbsp;
  <img src="https://github.com/user-attachments/assets/c66ae782-17c4-40a3-9bcc-20e274b00e29" alt="FACE_SKI">
</div>

### Training Pages
<div>
  <img src="https://github.com/user-attachments/assets/79c4d718-185e-4fa8-85b8-d57e4514120e" alt="FACE_BREAKOUT"> &nbsp;
  <img src="https://github.com/user-attachments/assets/189123c5-5426-41ee-a5d8-ebb345596e45" alt="FACE_RUN"> &nbsp;
  <img src="https://github.com/user-attachments/assets/f2f74c1e-cc98-4373-ab88-c92c467406cc" alt="FACE_SKI">
</div>

## Architecture
MìmiX is designed as a standalone application. We use ```Flutter``` for both the frontend and backend, except for AI model computation, which is handled using ```HTML5```, ```CSS```, and ```JavaScript``` executed through a local server embedded through a WebView. This WebView handles the processing and accesses the device's camera to display the user's face in real-time.  
The AI models used are part of the Face Landmarks package from ```MediaPipe```, which includes a Face Detector, a Face Mesh, and a Face Blendshape for real-time facial analysis and expression recognition.  
For persistent data storage, we utilize ```SQLite```, ensuring efficient and reliable local data management. Finally, we leverage the ```Flame``` game engine, which is optimized for 2D development and seamlessly integrates with Flutter, providing a performant and smooth gaming experience.  

<img width="600" src="https://github.com/user-attachments/assets/f0c31612-2a44-47fd-b9ba-48fdc1979afb" alt="MìmiX Architectures">


## Repository Contents
The repository is structured as follows:  
- ```android/```: Contains all configuration files for Android, such as permissions, splash screen, etc.  
- ```ios/```: Similar to the Android directory (additional adjustments might be necessary).  
- ```assets/```: Includes all assets used by the app, such as images, GIFs, fonts, etc.  
- ```lib/```: The core of the system, containing all the app's subsystems.  
- ```web_project/```: Contains files executed on localhost, including an HTML page that accesses the device's camera and a TypeScript file for running inference with MediaPipe AI models.  
- ```pubspec.yaml```: Essential configuration file for the Flutter project.

## Installation Guide

### Flutter project
To correctly execute the project, follow the installation guide for ```Flutter``` at this [link](https://docs.flutter.dev/get-started/install): choose your preferred development environment and target device. We recommend Android as the target environment.  

Use Flutter SDK version **>=3.5.3** and **<=3.6.0** to avoid dependency issues.  

Next, run the following command in your terminal from root of project:  

```bash
flutter pub get
```

### Web project
Optionally, if you need to edit the files executed within the ```web_project``` directory, install ```NodeJS``` from this [link](https://nodejs.org/en/download/current).  

The only files that should be modified are:  
- ```index.html```  
- ```index.ts```  
- ```style.ts```  

After installing NodeJS, run the following commands installing all required dependencies:  

```bash
npm install
```

Starts the local development server.
```bash
npm run start
```

Builds the project to be deployed in the WebView.
```bash
npm run build
```

Insert the build in folder ```assets/``` overwriting the ```camera/``` folder (old build).



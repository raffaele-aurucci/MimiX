<p align="center">
    <img width="200" src="https://github.com/user-attachments/assets/f7322182-7f81-4e71-89c6-f6d01fcbb6c2" alt="Mimix logo">
</p>

<h3 align="center">
 Mimix
</h3>

<p align="center">
 A <b>Digital Therapeutics app</b> designed to support the execution of facial expression exercises :innocent:.  
</p>

<p align="center">
 <a href="#"><img src="https://img.shields.io/github/contributors/raffaele-aurucci/Mimix?style=for-the-badge" alt="Contributors"/></a>
 <img src="https://img.shields.io/github/last-commit/raffaele-aurucci/Mimix?style=for-the-badge" alt="last commit">
</p>

<div align="center">
  
[@raffaele-aurucci](https://github.com/raffaele-aurucci), [@CSSabino](https://github.com/CSSabino), [@DomenicoAnzalone](https://github.com/DomenicoAnzalone)

</div>



# Mimix

Every day, millions of people with facial muscle degeneration see their ability to move gradually decline. Rehabilitation is essential, but it’s often boring and hard to follow consistently.  

The problem? Without regular exercise, the degeneration progresses more rapidly. And when exercises are repetitive and unengaging, it’s easy to give up.  

That’s why we created **Mimix**: an innovative **Digital Therapeutics app** that turns therapy into a game! Using **AI-powered facial expression recognition**, our app offers targeted exercises through interactive mini-games, helping users slow down the loss of facial mobility in a fun and effective way.  

The experience is enhanced with **Gamification techniques**: increasing levels of challenge, tasks to complete, milestones to reach, and rewards to win-making the process engaging and motivating.

***With Mimix, we want to help people preserve their facial expressions… one smile at a time!*** 😊

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

### Minigame Pages

### Training Pages

## Architecture
Mimix is designed as a standalone application. We use ```Flutter``` for both the frontend and backend, except for AI model computation, which is handled using ```HTML5```, ```CSS```, and ```JavaScript``` executed through a local server embedded through a WebView. This WebView handles the processing and accesses the device's camera to display the user's face in real-time.  
The AI models used are part of the Face Landmarks package from ```MediaPipe```, which includes a Face Detector, a Face Mesh, and a Face Blendshape for real-time facial analysis and expression recognition.  
For persistent data storage, we utilize ```SQLite```, ensuring efficient and reliable local data management. Finally, we leverage the ```Flame``` game engine, which is optimized for 2D development and seamlessly integrates with Flutter, providing a performant and smooth gaming experience.  

<img width="600" src="https://github.com/user-attachments/assets/f0c31612-2a44-47fd-b9ba-48fdc1979afb" alt="Mimix Architectures">


## Repository Contents


## Installation Guide

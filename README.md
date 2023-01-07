# RT Salt Bettor

## About
The RT Salt Bettor is an iOS, iPadOS and macOS app that can help make more informed bets for Twitch Channel Points. 
It is provided for entertainment & educational purposes only and should not be used for any other purpose.

Sick of loosing all your Salt (Artosis' Twitch Channel Points) to B-Rank Protoss Smurf's? 
Make better bets with the RT Salt Bettor App.

<p align="center">
    <img src="https://github.com/rloniello/RT-Salt-Bettor/blob/main/RT%20Salt%20Bettor/Resources/screenplay.gif" width=30% height=30%/>
    <img src="https://github.com/rloniello/RT-Salt-Bettor/blob/main/RT%20Salt%20Bettor/Resources/screenshot-main.png" width=30% height=30%/>
    <img src="https://github.com/rloniello/RT-Salt-Bettor/blob/main/RT%20Salt%20Bettor/Resources/screenshot-credits.png" width=30% height=30%/>
</p>

## Features
RT Salt Bettor showcases the follwing Features:

- [x] Core ML
- [x] Entirely Programmatic UI
- [x] Starcraft Broodwar Themed
- [x] Simple State Restoration
- [x] View Factory Pattern
- [x] Model View Controller Pattern

### Human Readable Output Chart

In addition to a boolean win/loss (true or false) condition, 
the model also predicts a relative percentage that represents the strength of the prediction.   

| Message     | Win % |
| ----------- | ----------- |
| Artosis is strongly favored. | 75-99 |
| Artosis is slightly favored. | 55-75 |
| The match is fairly even.    | 45-55 |
| Opponent is slightly favored. | 45-25 |
| Opponent is strongly favored.| 25-0 |

### Data Collection

Data was collected via VODs from Artosis' Twitch Channel, more than 365 games where collected to create the ML model using CreateML. 
Games must satisfy the following criteria and constraints: 
* MMR of each player is known before the match. (No Unranked Players)
* Player(s) must trade material (a battle fought or material lost).
* The Game must be more than 1 minute in length.
* A player must leave the match, a decisive victory. (No Disconnects).

Note: For Random players the race data was collected after the race was known and the above conditions met. 

### Machine Learning Model Details

CoreML was used to create the model using a Random Forest to avoid overfitting. 
The following evaluation was generated after training:

| Win / Loss | Record Count | Precision | Recall | F1 Score | 
| ---------- | ------------ | --------- | ------ | -------- |
| Win        |      176     |   93%     |  95%   |   0.94   |
| Loss       |      165     |   95%     |  92%   |   0.94   |

29 Records where used for validation, for a total of 370 records.

## Additonal Disclaimer
"RT Salt Bettor" is a predictive app for Starcraft Broodwar matches between Artosis and another player. It is provided for entertainment & educational purposes only and should not be used for any other purpose. The predictions made by the app are not guaranteed to be accurate and should not be relied upon for any financial or other important decisions. The app does not endorse or encourage gambling or any other illegal activity. Use of the app is at the user's own risk and the creators of the app shall not be held responsible for any losses or damages that may result from using the app.

## Installation 

The following install steps may be helpful to a beginner:

Requirements:
1. A Mac computer running the latest macOS. (macOS Ventura 13.1).
2. Latest version of Xcode (download from the App store).
    
Download and Run
1. Download or Clone the repository **Clone** > **Download Zip**
2. Open the **.xcodeproj** file with Xcode.
3. Select a simulator or connected device from the dropdown menu in the top left corner of the window.
4. Click the play button (▶️) to build and run the project.
5. Do not close the iOS Simulator, instead press the stop button in Xcode (⏹️) to kill the app. This prevents the simulator from having to reset and restart on every run.
    
Xcode may prompt you to sign in with your Apple ID to create an Apple Developer Account in most cases this is not necessary.
You do not need to pay for a Apple Developer Account to use this app. 
If you do create an developer account, you may need to re-sign the app by changing the **team** in *RT Salt Bettor > Signing & Capabilities* to your own developer account. 


## Feedback, Bugs and Feature Requests.

Good or Bad, I am always interested in hearing your feedback. Please submit your feedback, bug reports and Feature Requests by creating a new *Issue post* in **Issues** on this repository.

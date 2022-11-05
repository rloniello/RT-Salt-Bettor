# RT Salt Bettor

### About
The RT Salt Bettor is an iOS, iPadOS and macOS app that can help make more informed bets for Twitch Channel Points. 
The App is intended to showcase the use of a simple CoreML Model while having fun.

Sick of loosing all your Salt (Artosis' Twitch Channel Points) to B-Rank Protoss Smurf's? 
Make better bets with the salt bettor app.

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

Data was collected via VODs from Artosis' Twitch Channel, more than 250 games where collected to create the ML model using CreateML. 
Games must satisfy the following criteria: 
* MMR of each player is known before the match. (No Unranked Players)
* Player(s) must trade material (a battle fought or material lost).
* The Game must be more than 1 minute in length.
* A player must leave the match, a decisive victory. (No Disconnects).

Note: For Random players the race data was collected after the race was known and the above conditions met. 

### Machine Learning Model Details

CoreML was used to create the model using a Boosted Tree. 
The following evaluation was generated after training:

| Win / Loss | Record Count | Precision | Recall | F1 Score | 
| ---------- | ------------ | --------- | ------ | -------- |
| Win        |      130     |   98%     |  98%   |   0.98   |
| Loss       |      115     |   98%     |  97%   |   0.98   |

12 Records where used for validation, for a total of 257 records.

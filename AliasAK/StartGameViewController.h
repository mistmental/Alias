//
//  StartGameViewController.h
//  AliasAK
//
//  Created by mistmental on 17.08.15.
//  Copyright (c) 2015 mistmental. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface StartGameViewController : UIViewController {
    
    
    IBOutlet UIImageView* backgroundImageView;
    
    IBOutlet UILabel* currentRound;
    IBOutlet UILabel* currentAndNameLabel;
   
    
    IBOutlet UILabel* timeLabel;
    
    IBOutlet UIButton* startButton;
    IBOutlet UILabel* wordLabel;
    
   
    IBOutlet UIView* scoreView;
    
    NSMutableArray* succedWords;
    NSMutableArray* failureWords;
    NSMutableArray* succedAndFailureWordsArray;
    
    NSTimer* timer;

    
    UISwipeGestureRecognizer* swipeUp;
    UISwipeGestureRecognizer* swipeDown;
    
    IBOutlet UIView* lineView;
    
    IBOutlet UIButton* command1;
    IBOutlet UIButton* command2;
    IBOutlet UIButton* command3;
    IBOutlet UIButton* command4;
    IBOutlet UIButton* command5;
    IBOutlet UIButton* nobody;
    
    IBOutlet UIImageView* cardImage;
    
    IBOutlet UILabel* succesCountLabel;
    IBOutlet UILabel* failureCountLabel;
    
    IBOutlet UILabel* succWordLabel;
    IBOutlet UILabel* failWordLabel;
    
    IBOutlet UILabel* scoreLabel;
    IBOutlet UILabel* scoreCommandAndRoundLabelPart1;
    IBOutlet UILabel* scoreCommandAndRoundLabelPart2;
    
    IBOutlet UIButton* nextCommandButton;
    
    IBOutlet UIView* viewOfPoints;
    IBOutlet UIButton* okOk;
    
    IBOutlet UIView* pointViewOfCommand1;
    IBOutlet UIView* pointViewOfCommand2;
    IBOutlet UIView* pointViewOfCommand3;
    IBOutlet UIView* pointViewOfCommand4;
    IBOutlet UIView* pointViewOfCommand5;
    
    IBOutlet UILabel* pointViewRoundContinie;
    
    IBOutlet UILabel* pointViewNameOfCommand1;
    IBOutlet UILabel* pointViewNameOfCommand2;
    IBOutlet UILabel* pointViewNameOfCommand3;
    IBOutlet UILabel* pointViewNameOfCommand4;
    IBOutlet UILabel* pointViewNameOfCommand5;
    
    IBOutlet UILabel* pointViewScoreOfCommand1;
    IBOutlet UILabel* pointViewScoreOfCommand2;
    IBOutlet UILabel* pointViewScoreOfCommand3;
    IBOutlet UILabel* pointViewScoreOfCommand4;
    IBOutlet UILabel* pointViewScoreOfCommand5;
    
    IBOutlet UIButton* newGame;
    
    
}

@property (assign, nonatomic) int pointCommand1;
@property (assign, nonatomic) int pointCommand2;
@property (assign, nonatomic) int pointCommand3;
@property (assign, nonatomic) int pointCommand4;
@property (assign, nonatomic) int pointCommand5;

@property (assign, nonatomic) int roundCount;
@property (assign, nonatomic) int currentCommand;
@property (assign, nonatomic) int randomA;

@property (assign, nonatomic) int secondsInRound;
@property (assign, nonatomic) int pointsToWin;
@property (assign, nonatomic) int constantSeconds;

@property (assign, nonatomic) BOOL isTimerOver;


@property (strong, nonatomic) NSMutableArray* commandNameArray;
@property (strong, nonatomic) NSMutableArray* gameModeWordsArray;

@property (assign, nonatomic) int indexOfWordsInSuccArray;
@property (assign, nonatomic) int indexOfWordsInFailArray;

@property (assign, nonatomic) int i;
@property (assign, nonatomic) BOOL isDoubleClick;




- (IBAction) startButton:(id)sender;

- (IBAction) command1:(id)sender;
- (IBAction) command2:(id)sender;
- (IBAction) command3:(id)sender;
- (IBAction) command4:(id)sender;
- (IBAction) command5:(id)sender;
- (IBAction) nobody:(id)sender;
@end

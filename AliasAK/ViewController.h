//
//  ViewController.h
//  AliasAK
//
//  Created by mistmental on 17.08.15.
//  Copyright (c) 2015 mistmental. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartGameViewController.h"

static NSMutableArray* gameModeWords;
static NSMutableArray* chosenCommandNameArray;

static int secondsInRound;
static int pointsToWin;


@interface ViewController : UIViewController
{
    IBOutlet UIButton* startGame;
    IBOutlet UIImageView* backgroundImage;

    
    IBOutlet NSMutableArray* allCommandNameArray;
    
    IBOutlet UILabel* firstCommand;
    IBOutlet UILabel* secondCommand;
    IBOutlet UILabel* thirdCommand;
    IBOutlet UILabel* fourCommand;
    IBOutlet UILabel* fifthCommand;
    
    IBOutlet NSMutableArray* hardModeWords;
    IBOutlet NSMutableArray* easyModeWords;
    IBOutlet NSMutableArray* mediumModeWords;
    
    IBOutlet UIButton* oK;
    
    IBOutlet UIButton* addButton;
    
    IBOutlet UIButton* levelHardButton;
    
    IBOutlet UISegmentedControl* timeSegmend;
    IBOutlet UISegmentedControl* pointsToWinSegmend;
    IBOutlet UISegmentedControl* levelModeSegmend;
    
    IBOutlet UILabel* labelForTimeSegmend;
    IBOutlet UILabel* labelForPointsToWinSegmend;

    
}



@property (assign, nonatomic) BOOL isEnableOKButton;

- (IBAction) startGame:(id)sender;
- (void) getCommandsNameFromArray;

- (IBAction) addCommand:(id)sender;

- (IBAction) hardMode:(id)sender;
- (IBAction) easyMode:(id)sender;
- (IBAction) mediumMode:(id)sender;

- (IBAction) oK:(id)sender;

- (NSMutableArray*) returnWordsArray;
- (NSMutableArray*) returnCommandNames;
- (int) returnSecondsInRound;
- (int) returnPointsToWin;

- (IBAction) levelHardButton:(id)sender;

@end


//
//  KommandViewController.h
//  AliasAK
//
//  Created by mistmental on 17.08.15.
//  Copyright (c) 2015 mistmental. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartGameViewController.h"



static NSMutableArray* gameModeWords;
static NSMutableArray* chosenCommandNameArray;

@interface KommandViewController : UIViewController


{
    
        
    
    IBOutlet UIImageView* backgroundImage;

    IBOutlet NSMutableArray* allCommandNameArray;
        
    IBOutlet UILabel* firstCommand;
    IBOutlet UILabel* secondCommand;
    IBOutlet UILabel* thirdCommand;

    IBOutlet UIButton* hardMode;
    IBOutlet UIButton* easyMode;
    IBOutlet UIButton* mediumMode;
    
    IBOutlet NSMutableArray* hardModeWords;
    IBOutlet NSMutableArray* easyModeWords;
    IBOutlet NSMutableArray* mediumModeWords;
    
    IBOutlet UIButton* oK;
    
    IBOutlet UIButton* addButton;
    
    IBOutlet UILabel* comands;
    IBOutlet UILabel* hardLevel;
    
    
}

@property (assign, nonatomic) BOOL isEnableOKButton;
//@property (strong, nonatomic) NSMutableArray* gameModeWords;
//@property (strong, nonatomic) NSMutableArray* chosenCommandNameArray;

- (void) getCommandsNameFromArray;

- (IBAction) addCommand:(id)sender;

- (IBAction) hardMode:(id)sender;
- (IBAction) easyMode:(id)sender;
- (IBAction) mediumMode:(id)sender;

- (IBAction) oK:(id)sender;

- (NSMutableArray*) returnWordsArray;
- (NSMutableArray*) returnCommandNames;

@end

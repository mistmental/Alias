//
//  GameViewController.m
//  AliasAK
//
//  Created by mistmental on 17.08.15.
//  Copyright (c) 2015 mistmental. All rights reserved.
//

#import "GameViewController.h"


@interface GameViewController ()

@property (assign, nonatomic) int roundCount;

@end

@implementation GameViewController



- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.roundCount = 1;
    
  //  [object getCommandNameArray:commandNameArray andArrayWords:gameModeWordsArray];
  //  NSLog(@"%@, %@", commandNameArray, gameModeWordsArray);
    //object = [[KommandViewController alloc] init];
   // object.gameModeWords = gameModeWordsArray;
    //object.chosenCommandNameArray = commandNameArray;
    KommandViewController* object = [[KommandViewController alloc] init];
    
  //  self.gameModeWordsArray = [[NSMutableArray alloc] initWithArray:object.gameModeWords];
  //  self.commandNameArray = [[NSMutableArray alloc] initWithArray:object.chosenCommandNameArray];
    
    [object propertiesArray:self.commandNameArray andArrayWords:self.gameModeWordsArray];
    
    for (id obj in self.gameModeWordsArray) {
        NSLog(@"%@",obj);
    }
    for (id obj in self.commandNameArray) {
        NSLog(@"%@", obj);
    }
    
    
 //   presentRoundandCOmmandNameLabel.text = [[NSString stringWithFormat:@"Раунд %d \n Первыми ходит команда <%@>", self.roundCount,[super.chosenCommandNameArray objectAtIndex:0]];


}

@end

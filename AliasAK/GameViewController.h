//
//  GameViewController.h
//  AliasAK
//
//  Created by mistmental on 17.08.15.
//  Copyright (c) 2015 mistmental. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KommandViewController.h"

@interface GameViewController : UIViewController {

    IBOutlet UILabel* presentRoundandCOmmandNameLabel;
  
    
}

@property (strong, nonatomic) NSMutableArray* commandNameArray;
@property (strong, nonatomic) NSMutableArray* gameModeWordsArray;

@end

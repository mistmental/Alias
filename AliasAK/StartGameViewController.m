//
//  StartGameViewController.m
//  AliasAK
//
//  Created by mistmental on 17.08.15.
//  Copyright (c) 2015 mistmental. All rights reserved.
//

#import "StartGameViewController.h"
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface StartGameViewController() <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView* succAndFailWordsTableView;
@property (assign, nonatomic) BOOL y;
@property (strong, nonatomic) AVAudioPlayer* musicOfLastTenSeconds;
@property (strong, nonatomic) AVAudioPlayer* musicOfLastSeconds;

@property (assign, nonatomic) BOOL isThisWin;
@property (assign, nonatomic) BOOL isThisSecondPresentThisViewController;


@end

@implementation StartGameViewController

- (void) viewDidLoad {
   [super viewDidLoad];
    if (self.isThisSecondPresentThisViewController == NO) {
        [self loadViewWithGameOptions];
        self.isThisSecondPresentThisViewController = YES;
    }
   [self createCurrentRoundAndCommandNames];
    startButton.hidden = NO;
   startButton.frame = cardImage.frame;
   startButton.center = cardImage.center;
    newGame.hidden = YES;
    newGame.enabled = NO;
    
    self.isThisWin = NO;
}

#pragma mark -
#pragma mark - currentRoundAndCommand

- (void) createCurrentRoundAndCommandNames {
    if (self.currentCommand == [self.commandNameArray count]) {
        self.roundCount++;
        self.currentCommand = 0;
    }
   
    
    int fontSizeOfRoundLabel;
    int fontSizeOfCommandNameLabels;
    float roundLabelCenterCoefficient;
    float commandNameLabelCenterCoefficient;
    
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        
        
        fontSizeOfRoundLabel = 30;
        fontSizeOfCommandNameLabels = 23;
        roundLabelCenterCoefficient = 0.09;
        commandNameLabelCenterCoefficient = 0.142;
    }
    
    if (self.view.frame.size.height == 667) { //IPhone 6
        
        
        
        fontSizeOfRoundLabel = 30;
        fontSizeOfCommandNameLabels = 17;
        roundLabelCenterCoefficient = 0.13;
        commandNameLabelCenterCoefficient = 0.185;
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        
        
        fontSizeOfRoundLabel = 30;
        fontSizeOfCommandNameLabels = 15;
        roundLabelCenterCoefficient = 0.12;
        commandNameLabelCenterCoefficient = 0.182;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        
        
        
        fontSizeOfRoundLabel = 30;
        fontSizeOfCommandNameLabels = 13;
        roundLabelCenterCoefficient = 0.145;
        commandNameLabelCenterCoefficient = 0.21;
        
    }

    currentRound.hidden = NO;
    currentAndNameLabel.hidden = NO;
    
    currentRound.frame = CGRectMake(0, 0, self.view.bounds.size.width/2, self.view.bounds.size.height/15);
    currentRound.text = [NSString stringWithFormat:@"РАУНД %d",self.roundCount];
    currentRound.textColor = [UIColor whiteColor];
    currentRound.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    currentRound.font = [UIFont fontWithName:@"Palatino" size:fontSizeOfRoundLabel];
    currentRound.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height*roundLabelCenterCoefficient);
    [self.view addSubview:currentRound];
    
    NSLog(@"NORM!!");
    currentAndNameLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width/1.5, self.view.bounds.size.height/15);
    currentAndNameLabel.text = [NSString stringWithFormat:@"Ход команды %@", [self.commandNameArray objectAtIndex:self.currentCommand]];
    currentAndNameLabel.textColor = [UIColor blackColor];
    currentAndNameLabel.font = [UIFont fontWithName:@"Palatino" size:fontSizeOfCommandNameLabels];
    currentAndNameLabel.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height*commandNameLabelCenterCoefficient);
    [self.view addSubview:currentAndNameLabel];
    
   
    
}

#pragma mark -
#pragma mark - loadViewWithGameOptions

- (void) loadViewWithGameOptions {
    
    cardImage.hidden = NO;
    scoreView.hidden = YES;
    self.roundCount = 1;
    self.currentCommand = 0;
    wordLabel.hidden = YES;
    self.isTimerOver = NO;
    
    float cardImageHeightCoefficient;
    
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        
        
        cardImageHeightCoefficient = 1.5;
    }
    
    if (self.view.frame.size.height == 667) { //IPhone 6
        
        
        cardImageHeightCoefficient = 1.7;
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        
        
        cardImageHeightCoefficient = 1.8;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        
        cardImageHeightCoefficient = 2;
    }
    
    cardImage.frame = CGRectMake(0, 0,self.view.bounds.size.width/1.7, self.view.bounds.size.height/cardImageHeightCoefficient);
    cardImage.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    startButton.frame = cardImage.frame;
    startButton.center = cardImage.center;
   startButton.backgroundColor = [UIColor clearColor];
    
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:30]];
    
    
    failureWords = [[NSMutableArray alloc] init];
    succedWords = [[NSMutableArray alloc] init];
    
    ViewController* vv = [[ViewController alloc] init];
    NSMutableArray* newWordsArray = [vv returnWordsArray];
    NSMutableArray* newCommandNamesArray = [vv returnCommandNames];
    
    self.gameModeWordsArray = [[NSMutableArray alloc] init];
    self.commandNameArray = [[NSMutableArray alloc] init];
    
    self.commandNameArray = newCommandNamesArray;
    self.gameModeWordsArray = newWordsArray;
    
    int secondsInRound = [vv returnSecondsInRound];
    int pointsToWin = [vv returnPointsToWin];
    
    self.secondsInRound = secondsInRound;
    self.pointsToWin = pointsToWin;
    
    self.constantSeconds = self.secondsInRound;
    
    NSLog(@"self.secondsInRound = %d", self.secondsInRound);
    NSLog(@"self.pointsToWin = %d", self.pointsToWin);
    
    
   


}

#pragma mark -
#pragma mark - startButtonAction

- (IBAction) startButton:(id)sender {
    
    startButton.frame = cardImage.frame;
    startButton.center = cardImage.center;
    currentAndNameLabel.hidden = YES;
    currentRound.hidden = YES;
    
    if (swipeDown == nil && swipeUp == nil) {
      
        swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown)];
        [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
        [self.view addGestureRecognizer:swipeDown];
        
        swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp)];
        [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
        [self.view addGestureRecognizer:swipeUp];
        }

    
    
    
    
    float timeLabelHeightCoefficient;
    int timeLabelRectHeight;
    int timeLabelFontSize;
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        
        
        timeLabelRectHeight = 100;
        timeLabelHeightCoefficient = 0.09;
        timeLabelFontSize = 50;
    }
    
    if (self.view.frame.size.height == 667) { //IPhone 6
        
        
        timeLabelRectHeight = 60;
        timeLabelHeightCoefficient = 0.13;
        timeLabelFontSize = 40;
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        
        
        timeLabelRectHeight = 60;
         timeLabelHeightCoefficient = 0.125;
        timeLabelFontSize = 40;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        
        timeLabelRectHeight = 40;
        timeLabelHeightCoefficient = 0.145;
        timeLabelFontSize = 30;
    }
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, timeLabelRectHeight, timeLabelRectHeight)];
    timeLabel.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*timeLabelHeightCoefficient);
    
    timeLabel.textAlignment = UITextAlignmentCenter;
    [timeLabel setFont:[UIFont fontWithName:@"Palatino" size:timeLabelFontSize]];
    

    
    timeLabel.textColor = [UIColor blackColor];
    
    [self.view addSubview: timeLabel];
   
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f  target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
   
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        startButton.center = CGPointMake(-400, self.view.bounds.size.height/2);
        cardImage.center = CGPointMake(-400, self.view.bounds.size.height/2);
    } completion:^(BOOL finished) {
        NSLog(@"DONE");
        startButton.hidden = YES;
        [self createWordLabel];
    }];
    
    
}

#pragma mark -
#pragma mark - swipeDownAction

- (void) swipeDown {
    [self.view removeGestureRecognizer:swipeDown];
    [self.view removeGestureRecognizer:swipeUp];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationTransitionNone animations:^{
       
        wordLabel.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height +400);
        cardImage.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height +400);
        [failureWords addObject:[self.gameModeWordsArray objectAtIndex:self.randomA]];
        
        if (self.currentCommand == 0) {
            self.pointCommand1 = self.pointCommand1 - 1;
            NSLog(@"POINT COMMAND1 %d", self.pointCommand1);
        }
        if (self.currentCommand == 1) {
            self.pointCommand2 = self.pointCommand2 - 1;
            NSLog(@"POINT COMMAND2 %d", self.pointCommand2);
        }
        if (self.currentCommand == 2) {
            self.pointCommand3 = self.pointCommand3 - 1;
            NSLog(@"POINT COMMAND3 %d", self.pointCommand3);
        }
        if (self.currentCommand == 3) {
            self.pointCommand4 = self.pointCommand4 - 1;
            NSLog(@"POINT COMMAND4 %d", self.pointCommand4);
        }
        if (self.currentCommand == 4) {
            self.pointCommand5 = self.pointCommand5 - 1;
            NSLog(@"POINT COMMAND5 %d", self.pointCommand5);
        }
       
            float failureCountLabelYCoefficient;
            float failureCountLabelXCoefficient;
            
            int failureCountLabelFontSize;
            
            if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
                
                failureCountLabelXCoefficient = self.view.frame.size.width/4;
                failureCountLabelYCoefficient = self.view.frame.size.height*10.05/12;
               
                failureCountLabelFontSize = 25;
            }
            
            if (self.view.frame.size.height == 667) { //IPhone 6
                
                failureCountLabelXCoefficient = self.view.frame.size.width/4;
                failureCountLabelYCoefficient = self.view.frame.size.height*9.53/12;
                
                failureCountLabelFontSize = 23;
            }
            if (self.view.frame.size.height == 736) { //IPhone 6Plus
                
                failureCountLabelXCoefficient = self.view.frame.size.width/4;
                failureCountLabelYCoefficient = self.view.frame.size.height*9.53/12;
                
                failureCountLabelFontSize = 23;
            }
            if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
                
                
                failureCountLabelXCoefficient = self.view.frame.size.width/4;
                failureCountLabelYCoefficient = self.view.frame.size.height*6.84/9;
                failureCountLabelFontSize = 15;
            }
        if (failureCountLabel == nil) {
            failureCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(failureCountLabelXCoefficient,failureCountLabelYCoefficient, self.view.bounds.size.width/9, self.view.bounds.size.height/19)];
            
            failureCountLabel.textAlignment = NSTextAlignmentCenter;
            failureCountLabel.textColor = [UIColor grayColor];
            [failureCountLabel setFont:[UIFont fontWithName:@"Palatino" size:failureCountLabelFontSize]];
            [failureCountLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
            [self.view addSubview:failureCountLabel];
        }
        
        failureCountLabel.hidden = NO;
        failureCountLabel.text = [NSString stringWithFormat:@"-%d", failureWords.count];
        [self.gameModeWordsArray removeObject:[self.gameModeWordsArray objectAtIndex:self.randomA]];
    } completion:^(BOOL finished) {
        [self createWordLabel];
        
        NSLog(@"-1");
    }];
    
}


#pragma mark -
#pragma mark - swipeUpAction

- (void) swipeUp {
    [self.view removeGestureRecognizer:swipeUp];
    [self.view removeGestureRecognizer:swipeDown];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationTransitionNone animations:^{
        wordLabel.center = CGPointMake((int)self.view.bounds.size.width/2, -400);
        cardImage.center = CGPointMake((int)self.view.bounds.size.width/2, -400);
        [succedWords addObject:[self.gameModeWordsArray objectAtIndex:self.randomA]];
        
        if (self.currentCommand == 0) {
            self.pointCommand1 = self.pointCommand1 + 1;
            NSLog(@"POINT COMMAND1 %d", self.pointCommand1);
        }
        if (self.currentCommand == 1) {
            self.pointCommand2 = self.pointCommand2 + 1;
            NSLog(@"POINT COMMAND2 %d", self.pointCommand2);
        }
        if (self.currentCommand == 2) {
            self.pointCommand3 = self.pointCommand3 + 1;
            NSLog(@"POINT COMMAND3 %d", self.pointCommand3);
        }
        if (self.currentCommand == 3) {
            self.pointCommand4 = self.pointCommand4 + 1;
            NSLog(@"POINT COMMAND4 %d", self.pointCommand4);
        }
        if (self.currentCommand == 4) {
            self.pointCommand5 = self.pointCommand5 + 1;
            NSLog(@"POINT COMMAND5 %d", self.pointCommand5);
        }
            float succesCountLabelYCoefficient;
            float succesCountLabelXCoefficient;
            
            int succesCountLabelFontSize;
            
            if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
                
                succesCountLabelXCoefficient = self.view.frame.size.width/4;
                succesCountLabelYCoefficient = self.view.frame.size.height*1/9;
                
                succesCountLabelFontSize = 25;
            }
            
            if (self.view.frame.size.height == 667) { //IPhone 6
                
                succesCountLabelXCoefficient = self.view.frame.size.width/4;
                succesCountLabelYCoefficient = self.view.frame.size.height*1.37/9;
                
                succesCountLabelFontSize = 23;
            }
            if (self.view.frame.size.height == 736) { //IPhone 6Plus
                
                succesCountLabelXCoefficient = self.view.frame.size.width/4;
                succesCountLabelYCoefficient = self.view.frame.size.height*1.37/9;
                
                succesCountLabelFontSize = 23;
            }
            if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
                
                
                succesCountLabelXCoefficient = self.view.frame.size.width/4;
                succesCountLabelYCoefficient = self.view.frame.size.height*1.7/9;
                succesCountLabelFontSize = 15;
            }
        if (succesCountLabel == nil) {
            succesCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(succesCountLabelXCoefficient,succesCountLabelYCoefficient, self.view.bounds.size.width/9, self.view.bounds.size.height/19)];
            succesCountLabel.textAlignment = NSTextAlignmentCenter;
            succesCountLabel.textColor = [UIColor whiteColor];
            [succesCountLabel setFont:[UIFont fontWithName:@"Palatino" size:succesCountLabelFontSize]];
            [succesCountLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
            [self.view addSubview:succesCountLabel];
        }
        succesCountLabel.hidden = NO;
        succesCountLabel.text = [NSString stringWithFormat:@"+%d", (int)succedWords.count];
        
        [self.gameModeWordsArray removeObject:[self.gameModeWordsArray objectAtIndex:self.randomA]];
        
    } completion:^(BOOL finished) {
        [self createWordLabel];
       
        NSLog(@"+1");
    }];
    
}

#pragma mark -
#pragma mark - timeLabelAction

- (void) updateTimer {
    if (self.isTimerOver == NO) {
        self.secondsInRound = self.constantSeconds;
        self.isTimerOver = YES;
    }
    
    if (self.secondsInRound > 0) {
        self.secondsInRound--;
        
        [timeLabel setText:[NSString stringWithFormat:@"%d",self.secondsInRound]];
        
        if (self.secondsInRound == 10) {
            
            if (self.musicOfLastTenSeconds == nil) {
                NSURL *musicFile = [[NSBundle mainBundle] URLForResource:@"tenSeconds"
                                                           withExtension:@"mp3"];
                NSError* error;
                self.musicOfLastTenSeconds = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:&error];
            }
            self.musicOfLastTenSeconds.currentTime = 0;
            self.musicOfLastTenSeconds.volume = 1.0;
            self.musicOfLastTenSeconds.numberOfLoops = -1;
            [self.musicOfLastTenSeconds play];
        }
        if (self.secondsInRound <= 1) {
            [self.view removeGestureRecognizer:swipeDown];
            [self.view removeGestureRecognizer:swipeUp];
        }
        
        
    } else {
        timeLabel.hidden = YES;
        [timer invalidate];
        [self.musicOfLastTenSeconds stop];
        
        if (self.musicOfLastSeconds == nil) {
            NSURL *musicFile = [[NSBundle mainBundle] URLForResource:@"lastSecond"
                                                       withExtension:@"mp3"];
            NSError* error;
            self.musicOfLastSeconds = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFile error:&error];
        }
        
        self.musicOfLastSeconds.currentTime = 0.5;
        self.musicOfLastSeconds.volume = 1.0;
        self.musicOfLastSeconds.numberOfLoops = -1;
        [self.musicOfLastSeconds play];
        
        self.isTimerOver = NO;
        succesCountLabel.hidden = YES;
        failureCountLabel.hidden = YES;
        
        NSLog(@"Timer end");
        
        [self timeFinished];
    }
}

#pragma mark -
#pragma mark - wordLabel

- (void) createWordLabel {
    self.randomA = 0;
    wordLabel.hidden = NO;
    cardImage.hidden = NO;
    
    float cardImageHeightCoefficient;
    int fontSizeOfWordLabel;
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        
        
        cardImageHeightCoefficient = 1.5;
        fontSizeOfWordLabel = 35;
    }
    
    if (self.view.frame.size.height == 667) { //IPhone 6
        
        
        cardImageHeightCoefficient = 1.7;
        fontSizeOfWordLabel = 25;
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        
        
        cardImageHeightCoefficient = 1.8;
        fontSizeOfWordLabel = 25;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        
        cardImageHeightCoefficient = 2;
        fontSizeOfWordLabel = 20;
    }
    wordLabel.frame = CGRectMake(startButton.frame.origin.x, startButton.frame.origin.y, startButton.bounds.size.width, startButton.bounds.size.height);
    cardImage.frame = CGRectMake(startButton.frame.origin.x, startButton.frame.origin.y,self.view.bounds.size.width/1.7, self.view.bounds.size.height/cardImageHeightCoefficient);
    cardImage.center = CGPointMake(-300, self.view.bounds.size.height/2);
    wordLabel.center = CGPointMake(-300, self.view.bounds.size.height/2);
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        cardImage.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
        wordLabel.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    } completion:^(BOOL finished) {
        NSLog(@"/");
        [self.view addGestureRecognizer:swipeDown];
        [self.view addGestureRecognizer:swipeUp];
    }];
   
    
    wordLabel.textAlignment = UITextAlignmentCenter;
    [wordLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfWordLabel]];
    
    self.randomA = arc4random() % ([self.gameModeWordsArray count] - 1);
    wordLabel.text = [NSString stringWithFormat:@"%@", [self.gameModeWordsArray objectAtIndex:self.randomA]];
    
    
    wordLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:wordLabel];
    NSLog(@"%d", [self.gameModeWordsArray count]);

}

#pragma mark -
#pragma mark - timeLabelFinished

- (void) timeFinished {

    cardImage.hidden = YES;
    
        scoreView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, self.view.bounds.size.width/1.5, self.view.bounds.size.height)];

    wordLabel.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height/2);
    scoreView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height*1.5);
    
    scoreView.hidden = NO;
    scoreView.center = CGPointMake(self.view.center.x, self.view.center.y + 45);
    
    [self.view addSubview:scoreView];
    [scoreView addSubview:wordLabel];
    
        lineView = [[UIView alloc] initWithFrame:CGRectMake(-100, 120, 150, 3)];
        lineView.backgroundColor = [UIColor whiteColor];

    lineView.center = CGPointMake(-200, 120);
    [scoreView addSubview:lineView];
    [scoreView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
         scoreView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2+ 45);
        wordLabel.center = CGPointMake(scoreView.bounds.size.width/2, 90);
        lineView.center = CGPointMake(scoreView.bounds.size.width/2, 120);
    } completion:^(BOOL finished) {
        NSLog(@"Done");
        [NSThread sleepForTimeInterval:1];
        [self.musicOfLastSeconds stop];
    }];
    
    int fontSizeOfCommandButton;
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        
        fontSizeOfCommandButton = 35;
    }
    if (self.view.frame.size.height == 667) { //IPhone 6
        
        fontSizeOfCommandButton = 25;
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        
        fontSizeOfCommandButton = 25;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        
        fontSizeOfCommandButton = 20;
    }

    command1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    command1.frame = CGRectMake(0, 0, scoreView.frame.size.width, scoreView.frame.size.height/15);
    command1.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height*2/8);
    [command1 setTitle:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:0]] forState:UIControlStateNormal];
    [command1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [command1.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfCommandButton]];
    [command1 addTarget:self action:@selector(command1:) forControlEvents:UIControlEventTouchUpInside];
    [scoreView addSubview:command1];
    
    command2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    command2.frame = CGRectMake(0, 0, scoreView.frame.size.width, scoreView.frame.size.height/15);
    command2.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height*3/8);
    [command2 setTitle:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:1]] forState:UIControlStateNormal];
    [command2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [command2.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfCommandButton]];
    [command2 addTarget:self action:@selector(command2:) forControlEvents:UIControlEventTouchUpInside];
    [scoreView addSubview:command2];

    if ([self.commandNameArray count] == 3) {

        command3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        command3.frame = CGRectMake(0, 0, scoreView.frame.size.width, scoreView.frame.size.height/15);
        command3.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height*4/8);
        [command3 setTitle:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:2]] forState:UIControlStateNormal];
        [command3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [command3.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfCommandButton]];
        [command3 addTarget:self action:@selector(command3:) forControlEvents:UIControlEventTouchUpInside];
        [scoreView addSubview:command3];
        
        command4.hidden = YES;
        command5.hidden = YES;
    }
    if ([self.commandNameArray count] == 4) {

        command4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        command4.frame = CGRectMake(0, 0, scoreView.frame.size.width, scoreView.frame.size.height/15);
        command4.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height*5/8);
        [command4 setTitle:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:3]] forState:UIControlStateNormal];
        [command4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [command4.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfCommandButton]];
        [command4 addTarget:self action:@selector(command4:) forControlEvents:UIControlEventTouchUpInside];
        [scoreView addSubview:command4];
        command3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        command3.frame = CGRectMake(0, 0, scoreView.frame.size.width, scoreView.frame.size.height/15);
        command3.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height*4/8);
        [command3 setTitle:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:2]] forState:UIControlStateNormal];
        [command3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [command3.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfCommandButton]];
        [command3 addTarget:self action:@selector(command3:) forControlEvents:UIControlEventTouchUpInside];
        [scoreView addSubview:command3];
      
        
        command5.hidden = YES;

    }
    if ([self.commandNameArray count] == 5) {

        command4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        command4.frame = CGRectMake(0, 0, scoreView.frame.size.width, scoreView.frame.size.height/15);
        command4.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height*5/8);
        [command4 setTitle:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:3]] forState:UIControlStateNormal];
        [command4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [command4.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfCommandButton]];
        [command4 addTarget:self action:@selector(command4:) forControlEvents:UIControlEventTouchUpInside];
        [scoreView addSubview:command4];
        command3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        command3.frame = CGRectMake(0, 0, scoreView.frame.size.width, scoreView.frame.size.height/15);
        command3.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height*4/8);
        [command3 setTitle:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:2]] forState:UIControlStateNormal];
        [command3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [command3.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfCommandButton]];
        [command3 addTarget:self action:@selector(command3:) forControlEvents:UIControlEventTouchUpInside];
        [scoreView addSubview:command3];
        command5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        command5.frame = CGRectMake(0, 0, scoreView.frame.size.width, scoreView.frame.size.height/15);
        command5.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height*6/8);
        [command5 setTitle:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:4]] forState:UIControlStateNormal];
        [command5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [command5.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfCommandButton]];
        [command5 addTarget:self action:@selector(command5:) forControlEvents:UIControlEventTouchUpInside];
        [scoreView addSubview:command5];

        
    }

        nobody = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        nobody.frame = CGRectMake(0, 0, scoreView.frame.size.width, scoreView.frame.size.height/15);
        nobody.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height*7/8);
        [nobody setTitle:[NSString stringWithFormat:@"НИКТО"] forState:UIControlStateNormal];
        [nobody setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nobody.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfCommandButton]];
        [nobody addTarget:self action:@selector(nobody:) forControlEvents:UIControlEventTouchUpInside];
        [scoreView addSubview:nobody];

   }

#pragma mark -
#pragma mark - lastWordCommandButtonsAction

- (IBAction) command1:(id)sender {
    self.pointCommand1++;
    [self exitCommandTurn];
}
- (IBAction) command2:(id)sender {
self.pointCommand2++;
    [self exitCommandTurn];
}
- (IBAction) command3:(id)sender {
self.pointCommand3++;
    [self exitCommandTurn];
}
- (IBAction) command4:(id)sender {
self.pointCommand4++;
    [self exitCommandTurn];
}
- (IBAction) command5:(id)sender {
self.pointCommand5++;
    [self exitCommandTurn];
}
- (IBAction) nobody:(id)sender {
    [self exitCommandTurn];
}


- (void) exitCommandTurn {
   
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        scoreView.center = CGPointMake(self.view.bounds.size.width + scoreView.bounds.size.width/2, self.view.bounds.size.height/2 + 45);
    } completion:^(BOOL finished) {
        NSLog(@"DONE");
        [command1 removeFromSuperview];
        [command2 removeFromSuperview];
        [command3 removeFromSuperview];
        [command4 removeFromSuperview];
        [command5 removeFromSuperview];
        [nobody removeFromSuperview];
        [lineView removeFromSuperview];
        [wordLabel removeFromSuperview];
        
        self.succAndFailWordsTableView.hidden = NO;
        succWordLabel.hidden = NO;
        failWordLabel.hidden = NO;
        scoreLabel.hidden = NO;
        scoreCommandAndRoundLabelPart1.hidden = NO;
        scoreCommandAndRoundLabelPart2.hidden = NO;
        nextCommandButton.hidden = NO;
        nextCommandButton.enabled = YES;
        
        [self makeTableView];
        [self createRoundAndCommandNameAndSuccAndFailLabel];
        [self loadFailAndSuccesView];
        
    }];
    
     
}

#pragma mark -
#pragma mark - createRoundAndCommandNameAndSuccAndFailLabel

- (void) createRoundAndCommandNameAndSuccAndFailLabel {
    
        int fontSizeOfSuccAndFailWordLabel;
        int nextCommandButtonWidth;
        int nextCommandButtonHeight;
        if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
            
            fontSizeOfSuccAndFailWordLabel = 20;
            nextCommandButtonWidth = 100;
           
        }
        if (self.view.frame.size.height == 667) { //IPhone 6
            
            fontSizeOfSuccAndFailWordLabel = 15;
            nextCommandButtonWidth = 60;
            
        }
        if (self.view.frame.size.height == 736) { //IPhone 6Plus
            
            fontSizeOfSuccAndFailWordLabel = 15;
            nextCommandButtonWidth = 60;
        }
        if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
            
            nextCommandButtonWidth = 40;
            fontSizeOfSuccAndFailWordLabel = 15;
        }
   // if (succWordLabel == nil) {
        succWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, scoreView.bounds.size.width/2, scoreView.bounds.size.height/15)];
        succWordLabel.center = CGPointMake(scoreView.bounds.size.width/4, scoreView.bounds.size.height*0.195);
        succWordLabel.textAlignment = NSTextAlignmentCenter;
        [succWordLabel setText:@"УГАДАНО"];
        succWordLabel.textColor = [UIColor whiteColor];
        [succWordLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfSuccAndFailWordLabel]];
        [succWordLabel setBackgroundColor:[UIColor colorWithRed:128/255 green:128/255 blue:0 alpha:1]];
        [scoreView addSubview:succWordLabel];
  //  }
 //   if (failWordLabel == nil) {
        failWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, scoreView.bounds.size.width/2, scoreView.bounds.size.height/15)];
        failWordLabel.center = CGPointMake(scoreView.bounds.size.width*3/4, scoreView.bounds.size.height*0.195);
        [failWordLabel setText:@"ПОТРАЧЕНО"];
        failWordLabel.textAlignment = NSTextAlignmentCenter;
        failWordLabel.textColor = [UIColor grayColor];
        [failWordLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfSuccAndFailWordLabel]];
       [failWordLabel setBackgroundColor:[UIColor colorWithRed:178/255 green:34/255 blue:34/255 alpha:1]];
        [scoreView addSubview:failWordLabel];
 //   }
   // if (scoreLabel == nil) {
        scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, scoreView.bounds.size.width, scoreView.bounds.size.height/15)];
        scoreLabel.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height*0.136);
        
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.textColor = [UIColor whiteColor];
        [scoreLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfSuccAndFailWordLabel - 3]];
        
        [scoreView addSubview:scoreLabel];
  //  }
  //  if (scoreCommandAndRoundLabelPart1 == nil) {
        scoreCommandAndRoundLabelPart1 = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, scoreView.bounds.size.width, scoreView.bounds.size.height/15)];
        scoreCommandAndRoundLabelPart1.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height*0.06);
        
        scoreCommandAndRoundLabelPart1.textAlignment = NSTextAlignmentCenter;
        scoreCommandAndRoundLabelPart1.textColor = [UIColor whiteColor];
        [scoreCommandAndRoundLabelPart1 setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfSuccAndFailWordLabel]];
        
        [scoreView addSubview:scoreCommandAndRoundLabelPart1];
  //  }
  //  if (scoreCommandAndRoundLabelPart2 == nil) {
        scoreCommandAndRoundLabelPart2 = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, scoreView.bounds.size.width, scoreView.bounds.size.height/15)];
        scoreCommandAndRoundLabelPart2.center = CGPointMake(scoreView.bounds.size.width/2, scoreView.bounds.size.height*0.1);
        
        scoreCommandAndRoundLabelPart2.textAlignment = NSTextAlignmentCenter;
        scoreCommandAndRoundLabelPart2.textColor = [UIColor whiteColor];
        [scoreCommandAndRoundLabelPart2 setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfSuccAndFailWordLabel]];
        
        [scoreView addSubview:scoreCommandAndRoundLabelPart2];

 //   }
        
 //   if (nextCommandButton == nil) {
        nextCommandButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        nextCommandButton.frame = CGRectMake(0, 0, nextCommandButtonWidth, scoreView.bounds.size.height/1.5);
        
        [nextCommandButton setTitle:[NSString stringWithFormat:@"OK"] forState:UIControlStateNormal];
        [nextCommandButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nextCommandButton.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfSuccAndFailWordLabel]];
        [nextCommandButton addTarget:self action:@selector(nextCommandButton:) forControlEvents:UIControlEventTouchUpInside];
         nextCommandButton.center = CGPointMake(self.view.bounds.size.width+ 200, self.view.bounds.size.height/2);
 //   }
    

    
    [scoreLabel setText:[NSString stringWithFormat:@"Количество набранных очков:  %d", self.i]];
    [nextCommandButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    [self.view addSubview:nextCommandButton];
    [scoreCommandAndRoundLabelPart1 setText:[NSString stringWithFormat:@"Команда %@",[self.commandNameArray objectAtIndex:self.currentCommand]]];
    [scoreCommandAndRoundLabelPart2 setText:[NSString stringWithFormat:@"завершает РАУНД %d", self.roundCount]];
}

- (void) loadFailAndSuccesView {
    
    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        scoreView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2+ 45);
        nextCommandButton.center = CGPointMake(self.view.bounds.size.width - nextCommandButton.frame.size.width/2, self.view.bounds.size.height/2);
    } completion:^(BOOL finished) {
        NSLog(@"DONE");
    }];


}


#pragma mark - 
#pragma mark - makeTableView

-(void) makeTableView

{
    
    
        self.succAndFailWordsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, scoreView.bounds.size.height*0.22, scoreView.bounds.size.width, scoreView.bounds.size.height - scoreView.bounds.size.height*0.29) style:UITableViewStylePlain];
        
        int tableViewEstimateRowHeight;
        if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
            tableViewEstimateRowHeight = 25;
        }
        if (self.view.frame.size.height == 667) { //IPhone 6
            tableViewEstimateRowHeight = 20;
        }
        if (self.view.frame.size.height == 736) { //IPhone 6Plus
            tableViewEstimateRowHeight = 20;
        }
        if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
            tableViewEstimateRowHeight = 15;
        }
        // self.succAndFailWordsTableView.estimatedRowHeight = tableViewEstimateRowHeight;
        self.succAndFailWordsTableView.rowHeight = tableViewEstimateRowHeight+ 15;
        self.succAndFailWordsTableView.sectionFooterHeight = 0;
        self.succAndFailWordsTableView.sectionHeaderHeight = 0;
        self.succAndFailWordsTableView.scrollEnabled = YES;
        self.succAndFailWordsTableView.showsVerticalScrollIndicator = YES;
        self.succAndFailWordsTableView.userInteractionEnabled = YES;
        self.succAndFailWordsTableView.bounces = YES;
        self.succAndFailWordsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.succAndFailWordsTableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        self.succAndFailWordsTableView.dataSource = self;
        self.succAndFailWordsTableView.delegate = self;
        
        
        
        [self.succAndFailWordsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"succAndFailWordsTableView"];
        [scoreView addSubview:self.succAndFailWordsTableView];

  
    
    self.i = [succedWords count] - [failureWords count];
    [self.succAndFailWordsTableView reloadData];
   
}

#pragma mark -
#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    succedAndFailureWordsArray = [[NSMutableArray alloc] init];
    for (NSString* obj in succedWords) {
        [succedAndFailureWordsArray addObject:obj];
    }
    for (NSString* obj in failureWords) {
        [succedAndFailureWordsArray addObject:obj];
    }

    NSLog(@" succedAndFailureWordsArray = %d", [succedAndFailureWordsArray count]);
    return [succedAndFailureWordsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"succAndFailWordsTableView";
      UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    int tableViewCellFontSize;
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        tableViewCellFontSize = 25;
    }
    if (self.view.frame.size.height == 667) { //IPhone 6
        tableViewCellFontSize = 20;
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        tableViewCellFontSize = 20;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        tableViewCellFontSize = 15;
    }
    if (indexPath.row > [succedWords count] - 1 || [succedWords count] == 0) {
        cell.textLabel.text = [succedAndFailureWordsArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"Palatino" size:tableViewCellFontSize - 2];
        [cell.textLabel setTextColor:[UIColor grayColor]];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = nil;
        cell.textLabel.textAlignment = NSTextAlignmentRight;
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    else {
        cell.textLabel.text = [succedAndFailureWordsArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"Palatino" size:tableViewCellFontSize - 2];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = nil;
   
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSLog(@"!!!!SCORE!!!! = %d", self.i);

    
    return cell;
}

#pragma mark -
#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.isDoubleClick == NO) {
   
    self.y = NO;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.isDoubleClick = YES;
    if (cell.textLabel.textColor == [UIColor whiteColor]) {
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [cell.textLabel setTextAlignment:NSTextAlignmentRight];
           
            self.i = self.i - 2;
            if (self.currentCommand == 0) {
                self.pointCommand1 = self.pointCommand1 - 2;
                NSLog(@"POINT COMMAND1 %d", self.pointCommand1);
            }
            if (self.currentCommand == 1) {
                self.pointCommand2 = self.pointCommand2 - 2;
                NSLog(@"POINT COMMAND2 %d", self.pointCommand2);
            }
            if (self.currentCommand == 2) {
                self.pointCommand3 = self.pointCommand3 - 2;
                NSLog(@"POINT COMMAND3 %d", self.pointCommand3);
            }
            if (self.currentCommand == 3) {
                self.pointCommand4 = self.pointCommand4 - 2;
                NSLog(@"POINT COMMAND4 %d", self.pointCommand4);
            }
            if (self.currentCommand == 4) {
                self.pointCommand5 = self.pointCommand5 - 2;
                NSLog(@"POINT COMMAND5 %d", self.pointCommand5);
            }
            self.y = YES;
        } completion:^(BOOL finished) {
             cell.textLabel.textColor = [UIColor grayColor];
            
            self.isDoubleClick = NO;
        }];
        
    }
    if (self.y == NO) {
    if (cell.textLabel.textColor == [UIColor grayColor]) {
        self.isDoubleClick = YES;
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
            self.i = self.i + 2;
            if (self.currentCommand == 0) {
                self.pointCommand1 = self.pointCommand1 + 2;
                NSLog(@"POINT COMMAND1 %d", self.pointCommand1);
            }
            if (self.currentCommand == 1) {
                self.pointCommand2 = self.pointCommand2 + 2;
                NSLog(@"POINT COMMAND2 %d", self.pointCommand2);
            }
            if (self.currentCommand == 2) {
                self.pointCommand3 = self.pointCommand3 + 2;
                NSLog(@"POINT COMMAND3 %d", self.pointCommand3);
            }
            if (self.currentCommand == 3) {
                self.pointCommand4 = self.pointCommand4 + 2;
                NSLog(@"POINT COMMAND4 %d", self.pointCommand4);
            }
            if (self.currentCommand == 4) {
                self.pointCommand5 = self.pointCommand5 + 2;
                NSLog(@"POINT COMMAND5 %d", self.pointCommand5);
            }

        } completion:^(BOOL finished) {
            cell.textLabel.textColor = [UIColor whiteColor];
            self.isDoubleClick = NO;
            
        }];
    }
    }
    NSLog(@"YA TRONYT %d", indexPath.row);
  
    }
    NSLog(@"SCORE = %d", self.i);
    [scoreLabel setText:[NSString stringWithFormat:@"Количество набранных очков:  %d", self.i]];
}

#pragma mark -
#pragma mark - nextCommandButtonAction

- (IBAction) nextCommandButton:(id)sender {
    
    self.i = 0;
    [succedWords removeAllObjects];
    [failureWords removeAllObjects];

   [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
   nextCommandButton.center = CGPointMake(self.view.bounds.size.width+ 200, self.view.bounds.size.height/2);
   scoreView.center = CGPointMake(self.view.bounds.size.width+scoreView.bounds.size.width/2, self.view.bounds.size.height/2 + 45);
   } completion:^(BOOL finished) {
   self.succAndFailWordsTableView.hidden = YES;
   succWordLabel.hidden = YES;
   failWordLabel.hidden = YES;
   scoreLabel.hidden = YES;
   scoreCommandAndRoundLabelPart1.hidden = YES;
   scoreCommandAndRoundLabelPart2.hidden = YES;
   scoreView.hidden = YES;
   nextCommandButton.hidden = YES;
   nextCommandButton.enabled = NO;
       if (self.currentCommand == [self.commandNameArray count] - 1) {

           [self createViewOfPoints];
           NSLog(@"self.pointCommand1 =%d", self.pointCommand1);
           NSLog(@"self.pointCommand2 =%d", self.pointCommand2);
           NSLog(@"self.pointCommand3 =%d", self.pointCommand3);
           NSLog(@"self.pointCommand4 =%d", self.pointCommand4);
           NSLog(@"self.pointCommand5 =%d", self.pointCommand5);
           self.currentCommand++;
       }
       else {
           self.currentCommand++;
           cardImage.hidden = NO;
           [self viewDidLoad];
       }
       
   
   }];
}

#pragma mark -
#pragma mark - scoreView

- (void) createViewOfPoints {
    
    viewOfPoints.hidden = NO;
    if (viewOfPoints == nil) {
        viewOfPoints = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        viewOfPoints.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    }

    viewOfPoints.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    
        int fontSizeWith2Commands;
        int fontSizeWith3Commands;
        int fontSizeWith4Commands;
        int fontSizeWith5Commands;
        
        if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
            fontSizeWith2Commands = 25;
            fontSizeWith3Commands = 20;
            fontSizeWith4Commands = 15;
            fontSizeWith5Commands = 11;
        }
        if (self.view.frame.size.height == 667) { //IPhone 6
            fontSizeWith2Commands = 20;
            fontSizeWith3Commands = 15;
            fontSizeWith4Commands = 15;
            fontSizeWith5Commands = 11;
        }
        if (self.view.frame.size.height == 736) { //IPhone 6Plus
            fontSizeWith2Commands = 20;
            fontSizeWith3Commands = 15;
            fontSizeWith4Commands = 11;
            fontSizeWith5Commands = 9;
        }
        if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
            
            fontSizeWith2Commands = 20;
            fontSizeWith3Commands = 15;
            fontSizeWith4Commands = 9;
            fontSizeWith5Commands = 5;
        }
        
    if ([self.commandNameArray count] == 2) {
        [self createLabelComannd1And2:fontSizeWith2Commands andWithCenterXCommand1:viewOfPoints.bounds.size.width/4 andWithCenterXCommand2:viewOfPoints.bounds.size.width*3/4 andWithWightLabel:viewOfPoints.bounds.size.width/2];
    }
    if ([self.commandNameArray count] == 3) {
        [self createLabelComannd1And2:fontSizeWith3Commands andWithCenterXCommand1:viewOfPoints.bounds.size.width/6 andWithCenterXCommand2:viewOfPoints.bounds.size.width*3/6 andWithWightLabel:viewOfPoints.bounds.size.width/3];
        [self creatLabelCommand3:fontSizeWith3Commands andWithCenterXCommand3:viewOfPoints.bounds.size.width*5/6 andWithWightLabel:viewOfPoints.bounds.size.width/3];
        
    }
    if ([self.commandNameArray count] == 4) {
        [self createLabelComannd1And2:fontSizeWith4Commands andWithCenterXCommand1:viewOfPoints.bounds.size.width/8 andWithCenterXCommand2:viewOfPoints.bounds.size.width*3/8 andWithWightLabel:viewOfPoints.bounds.size.width/4];
        [self creatLabelCommand3:fontSizeWith4Commands andWithCenterXCommand3:viewOfPoints.bounds.size.width*5/8 andWithWightLabel:viewOfPoints.bounds.size.width/4];
        [self creatLabelCommand4:fontSizeWith4Commands andWithCenterXCommand4:viewOfPoints.bounds.size.width*7/8 andWithWightLabel:viewOfPoints.bounds.size.width/4];
    }
    if ([self.commandNameArray count] == 5) {
        [self createLabelComannd1And2:fontSizeWith5Commands andWithCenterXCommand1:viewOfPoints.bounds.size.width/10 andWithCenterXCommand2:viewOfPoints.bounds.size.width*3/10 andWithWightLabel:viewOfPoints.bounds.size.width/5];
        [self creatLabelCommand3:fontSizeWith5Commands andWithCenterXCommand3:viewOfPoints.bounds.size.width*5/10 andWithWightLabel:viewOfPoints.bounds.size.width/5];
        [self creatLabelCommand4:fontSizeWith5Commands andWithCenterXCommand4:viewOfPoints.bounds.size.width*7/10 andWithWightLabel:viewOfPoints.bounds.size.width/5];
        [self creatLabelCommand5:fontSizeWith5Commands andWithCenterXCommand5:viewOfPoints.bounds.size.width*9/10 andWithWightLabel:viewOfPoints.bounds.size.width/5];
        
    }
    //

    [pointViewScoreOfCommand1 setText:[NSString stringWithFormat:@"%d",self.pointCommand1]];
    [pointViewScoreOfCommand2 setText:[NSString stringWithFormat:@"%d",self.pointCommand2]];
    [pointViewScoreOfCommand3 setText:[NSString stringWithFormat:@"%d",self.pointCommand3]];
    [pointViewScoreOfCommand4 setText:[NSString stringWithFormat:@"%d",self.pointCommand4]];
    [pointViewScoreOfCommand5 setText:[NSString stringWithFormat:@"%d",self.pointCommand5]];
    
    [self.view addSubview:viewOfPoints];
    
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        if ([self.commandNameArray count] == 2) {
            
            pointViewOfCommand1.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/2 - 20, self.pointCommand1*2);
            pointViewOfCommand1.center = CGPointMake(viewOfPoints.bounds.size.width/4, viewOfPoints.bounds.size.height*2/3 - self.pointCommand1*2/2);
            pointViewScoreOfCommand1.center = CGPointMake(pointViewOfCommand1.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand1*2/2 - 100);
            
            pointViewOfCommand2.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/2 - 20, self.pointCommand2*2);
            pointViewOfCommand2.center = CGPointMake(viewOfPoints.bounds.size.width*3/4, viewOfPoints.bounds.size.height*2/3 - self.pointCommand2*2/2);
            pointViewScoreOfCommand2.center = CGPointMake(pointViewOfCommand2.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand2*2/2 - 100);
        }
        if ([self.commandNameArray count] == 3) {
            
            pointViewOfCommand1.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/3 - 20, self.pointCommand1*2);
            pointViewOfCommand1.center = CGPointMake(viewOfPoints.bounds.size.width/6, viewOfPoints.bounds.size.height*2/3 - self.pointCommand1*2/2);
            pointViewScoreOfCommand1.center = CGPointMake(pointViewOfCommand1.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand1*2/2 - 100);
            
            pointViewOfCommand2.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/3 - 20, self.pointCommand2*2);
            pointViewOfCommand2.center = CGPointMake(viewOfPoints.bounds.size.width*3/6, viewOfPoints.bounds.size.height*2/3 - self.pointCommand2*2/2);
            pointViewScoreOfCommand2.center = CGPointMake(pointViewOfCommand2.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand2*2/2 - 100);
            
            pointViewOfCommand3.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/3 - 20, self.pointCommand3*2);
            pointViewOfCommand3.center = CGPointMake(viewOfPoints.bounds.size.width*5/6, viewOfPoints.bounds.size.height*2/3 - self.pointCommand3*2/2);
            pointViewScoreOfCommand3.center = CGPointMake(pointViewOfCommand3.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand3*2/2 - 100);
            
        }
        if ([self.commandNameArray count] == 4) {
            
            pointViewOfCommand1.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/4 - 20, self.pointCommand1*2);
            pointViewOfCommand1.center = CGPointMake(viewOfPoints.bounds.size.width/8, viewOfPoints.bounds.size.height*2/3 - self.pointCommand1*2/2);
            pointViewScoreOfCommand1.center = CGPointMake(pointViewOfCommand1.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand1*2/2 - 100);
            
            pointViewOfCommand2.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/4 - 20, self.pointCommand2*2);
            pointViewOfCommand2.center = CGPointMake(viewOfPoints.bounds.size.width*3/8, viewOfPoints.bounds.size.height*2/3 - self.pointCommand2*2/2);
            pointViewScoreOfCommand2.center = CGPointMake(pointViewOfCommand2.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand2*2/2 - 100);
            
            pointViewOfCommand3.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/4 - 20, self.pointCommand3*2);
            pointViewOfCommand3.center = CGPointMake(viewOfPoints.bounds.size.width*5/8, viewOfPoints.bounds.size.height*2/3 - self.pointCommand3*2/2);
            pointViewScoreOfCommand3.center = CGPointMake(pointViewOfCommand3.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand3*2/2 - 100);
            
            pointViewOfCommand4.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/4 - 20, self.pointCommand4*2);
            pointViewOfCommand4.center = CGPointMake(viewOfPoints.bounds.size.width*7/8, viewOfPoints.bounds.size.height*2/3 - self.pointCommand4*2/2);
            pointViewScoreOfCommand4.center = CGPointMake(pointViewOfCommand4.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand4*2/2 - 100);
        }
        if ([self.commandNameArray count] == 5) {
            
            pointViewOfCommand1.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/5 - 10, self.pointCommand1*2);
            pointViewOfCommand1.center = CGPointMake(viewOfPoints.bounds.size.width/10, viewOfPoints.bounds.size.height*2/3 - self.pointCommand1*2/2);
            pointViewScoreOfCommand1.center = CGPointMake(pointViewOfCommand1.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand1*2/2 - 100);
            
            pointViewOfCommand2.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/5 - 10, self.pointCommand2*2);
            pointViewOfCommand2.center = CGPointMake(viewOfPoints.bounds.size.width*3/10, viewOfPoints.bounds.size.height*2/3 - self.pointCommand2*2/2);
            pointViewScoreOfCommand2.center = CGPointMake(pointViewOfCommand2.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand2*2/2 - 100);
            
            pointViewOfCommand3.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/5 - 10, self.pointCommand3*2);
            pointViewOfCommand3.center = CGPointMake(viewOfPoints.bounds.size.width*5/10, viewOfPoints.bounds.size.height*2/3 - self.pointCommand3*2/2);
            pointViewScoreOfCommand3.center = CGPointMake(pointViewOfCommand3.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand3*2/2 - 100);
            
            pointViewOfCommand4.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/5 - 10, self.pointCommand4*2);
            pointViewOfCommand4.center = CGPointMake(viewOfPoints.bounds.size.width*7/10, viewOfPoints.bounds.size.height*2/3 - self.pointCommand4*2/2);
            pointViewScoreOfCommand4.center = CGPointMake(pointViewOfCommand4.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand4*2/2 - 100);
            
            pointViewOfCommand5.frame = CGRectMake(0, viewOfPoints.bounds.size.height*2/3, viewOfPoints.bounds.size.width/5 - 10, self.pointCommand5*2);
            pointViewOfCommand5.center = CGPointMake(viewOfPoints.bounds.size.width*9/10, viewOfPoints.bounds.size.height*2/3 - self.pointCommand5*2/2);
            pointViewScoreOfCommand5.center = CGPointMake(pointViewOfCommand5.center.x, viewOfPoints.bounds.size.height*2/3 - self.pointCommand5*2/2 - 100);
            
        }

    } completion:^(BOOL finished) {
        NSLog(@"DONE");
        okOk.enabled = YES;
        okOk.hidden = NO;
        if (okOk == nil) {
            okOk = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            okOk.frame = CGRectMake(0, 0, viewOfPoints.bounds.size.width/1.5, viewOfPoints.bounds.size.height/15);
            okOk.center = CGPointMake(viewOfPoints.bounds.size.height/2, viewOfPoints.bounds.size.height- 100);
            [okOk.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [okOk setTitle:[NSString stringWithFormat:@"OK"] forState:UIControlStateNormal];
            [okOk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [okOk setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6]];
            
            [okOk.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:30]];
            [okOk addTarget:self action:@selector(okOk:) forControlEvents:UIControlEventTouchUpInside];
            [viewOfPoints addSubview:okOk];
        }
        
        okOk.center = CGPointMake(viewOfPoints.bounds.size.width/2, viewOfPoints.bounds.size.height - 50);
    }];
    
    
    
}

#pragma mark -
#pragma mark - turnFinishedWithOkButtonAction

- (IBAction) okOk:(id)sender {
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        viewOfPoints.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height*1.5);
        
    } completion:^(BOOL finished) {
        NSLog(@"DONE");
        if (self.pointCommand1 >= self.pointsToWin) {
            if (self.pointCommand1 > self.pointCommand2 || self.pointCommand1 > self.pointCommand3 || self.pointCommand1 > self.pointCommand4 || self.pointCommand1 > self.pointCommand5 ) {
                
                [self createWinLabelAndView:self.pointCommand1 andCommandName:[self.commandNameArray objectAtIndex:0]];
                
            }
            else {
                NSLog(@"Ничья");
            }
            self.isThisWin = YES;
        }
        if (self.pointCommand2 >= self.pointsToWin) {
            if (self.pointCommand2 > self.pointCommand1 || self.pointCommand2 > self.pointCommand3 || self.pointCommand2 > self.pointCommand4 || self.pointCommand2 > self.pointCommand5 ) {
                
                [self createWinLabelAndView:self.pointCommand2 andCommandName:[self.commandNameArray objectAtIndex:1]];
                
            }
            else {
                NSLog(@"Ничья");
            }
            self.isThisWin = YES;
        }
        if (self.pointCommand3 >= self.pointsToWin) {
            if (self.pointCommand3 > self.pointCommand2 || self.pointCommand3 > self.pointCommand1 || self.pointCommand3 > self.pointCommand4 || self.pointCommand3 > self.pointCommand5 ) {
                
                [self createWinLabelAndView:self.pointCommand3 andCommandName:[self.commandNameArray objectAtIndex:2]];
                
            }
            else {
                NSLog(@"Ничья");
            }
            self.isThisWin = YES;
        }
        if (self.pointCommand4 >= self.pointsToWin) {
            if (self.pointCommand4 > self.pointCommand2 || self.pointCommand4 > self.pointCommand3 || self.pointCommand4 > self.pointCommand1 || self.pointCommand4 > self.pointCommand5 ) {
                
                [self createWinLabelAndView:self.pointCommand4 andCommandName:[self.commandNameArray objectAtIndex:3]];
                            }
            else {
                NSLog(@"Ничья");
            }
            self.isThisWin = YES;
        }
        if (self.pointCommand5 >= self.pointsToWin) {
            if (self.pointCommand5 > self.pointCommand2 || self.pointCommand5 > self.pointCommand3 || self.pointCommand5 > self.pointCommand4 || self.pointCommand5 > self.pointCommand1 ) {
                
                [self createWinLabelAndView:self.pointCommand5 andCommandName:[self.commandNameArray objectAtIndex:4]];
                
            }
            else {
                NSLog(@"Ничья");
            }
            self.isThisWin = YES;
        }
        else {
            if (self.isThisWin == NO) {
             
                viewOfPoints.hidden = YES;
                okOk.hidden = YES;
                okOk.enabled = NO;
                cardImage.hidden = NO;
                [self viewDidLoad];
            }
        }
    }];
    
   
}

#pragma mark -
#pragma mark - theEndOfTheGameWithWinLabel

- (void) createWinLabelAndView:(int) currectPointCommand andCommandName:(NSString*) commandName {
   
   int fontSizeOfLabel;
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        fontSizeOfLabel = 30;
    }
    if (self.view.frame.size.height == 667) { //IPhone 6
        fontSizeOfLabel = 25;
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        fontSizeOfLabel = 25;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        fontSizeOfLabel = 20;
    }
    newGame.hidden = NO;
    newGame.enabled = YES;
    
    cardImage.hidden = YES;
    startButton.hidden = YES;
    startButton.enabled = NO;
    currentRound.hidden = YES;

    UIView* winView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [winView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    [self.view addSubview:winView];
    UILabel* winLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, winView.bounds.size.width, 50)];
    winLabel1.center = CGPointMake(winView.bounds.size.width/2, winView.bounds.size.height/2 - 50);
    winLabel1.text = [NSString stringWithFormat:@"ПОБЕДИЛА КОМАНДА:"];
    winLabel1.textColor = [UIColor whiteColor];
    winLabel1.font = [UIFont fontWithName:@"Palatino" size:fontSizeOfLabel - 2];
    [winLabel1 setTextAlignment:NSTextAlignmentCenter];
    
    UILabel* winLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, winView.bounds.size.width, 50)];
    winLabel2.center = CGPointMake(winView.bounds.size.width/2, winView.bounds.size.height/2);
    winLabel2.text = [NSString stringWithFormat:@"%@",commandName];
    winLabel2.textColor = [UIColor whiteColor];
    winLabel2.font = [UIFont fontWithName:@"Palatino" size:fontSizeOfLabel];
    [winLabel2 setTextAlignment:NSTextAlignmentCenter];
    
    UILabel* winLabelScore = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, winView.bounds.size.width, 50)];
    winLabelScore.center = CGPointMake(winView.bounds.size.width/2, winView.bounds.size.height/2 + 50);
    winLabelScore.text = [NSString stringWithFormat:@"СО СЧЕТОМ: %d",currectPointCommand];
    winLabelScore.textColor = [UIColor whiteColor];
    winLabelScore.font = [UIFont fontWithName:@"Palatino" size:fontSizeOfLabel - 2];
    [winLabelScore setTextAlignment:NSTextAlignmentCenter];
    
    
    [winView addSubview:winLabelScore];
    [winView addSubview:winLabel1];
    [winView addSubview:winLabel2];
    
    
    newGame.frame = CGRectMake(0, 0, winView.bounds.size.width/1.5, winView.bounds.size.height/15);
    newGame.center = CGPointMake(winView.bounds.size.width/2, winView.bounds.size.height - 100);
    [newGame.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [newGame setTitle:[NSString stringWithFormat:@"Новая игра"] forState:UIControlStateNormal];
    [newGame setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [newGame setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6]];
    
    [newGame.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfLabel]];
    [newGame addTarget:self action:@selector(newGame:) forControlEvents:UIControlEventTouchUpInside];
    
    [winView addSubview:newGame];
    
    

}

- (IBAction) newGame:(id)sender {
    
}

- (void) createLabelComannd1And2:(NSInteger) withSize andWithCenterXCommand1:(int) withCenterX1 andWithCenterXCommand2:(int) withCenterX2 andWithWightLabel:(int) wightLabel {
    
if (pointViewNameOfCommand1 == nil && pointViewOfCommand1 == nil && pointViewScoreOfCommand1 == nil && pointViewNameOfCommand2 == nil && pointViewOfCommand2 == nil && pointViewScoreOfCommand2 == nil) {
    pointViewNameOfCommand1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wightLabel, 40)];
    pointViewNameOfCommand1.center = CGPointMake(withCenterX1, viewOfPoints.bounds.size.height - 150);
    pointViewNameOfCommand1.textAlignment = NSTextAlignmentCenter;
    [pointViewNameOfCommand1 setText:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:0]]];
    pointViewNameOfCommand1.textColor = [UIColor whiteColor];
    [pointViewNameOfCommand1 setFont:[UIFont fontWithName:@"Palatino" size:withSize]];
    [pointViewNameOfCommand1 setBackgroundColor:[UIColor clearColor]];
    
    pointViewOfCommand1 = [[UIView alloc] initWithFrame:CGRectMake(0, viewOfPoints.bounds.size.height*2/3, wightLabel - 20, 0)];
    pointViewOfCommand1.center = CGPointMake(withCenterX1, viewOfPoints.bounds.size.height*2/3);
    pointViewOfCommand1.backgroundColor = [UIColor whiteColor];
    
    pointViewScoreOfCommand1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    pointViewScoreOfCommand1.center = CGPointMake(withCenterX1, viewOfPoints.bounds.size.height - 200);
    pointViewScoreOfCommand1.textAlignment = NSTextAlignmentCenter;
    [pointViewScoreOfCommand1 setText:[NSString stringWithFormat:@"%d",self.pointCommand1]];
    pointViewScoreOfCommand1.textColor = [UIColor grayColor];
    [pointViewScoreOfCommand1 setFont:[UIFont fontWithName:@"Palatino" size:40]];
    [pointViewScoreOfCommand1 setBackgroundColor:[UIColor clearColor]];
    
    [viewOfPoints addSubview:pointViewScoreOfCommand1];
    [viewOfPoints addSubview:pointViewNameOfCommand1];
    [viewOfPoints addSubview:pointViewOfCommand1];
    
    pointViewNameOfCommand2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wightLabel, 40)];
    pointViewNameOfCommand2.center = CGPointMake(withCenterX2, viewOfPoints.bounds.size.height - 150);
    pointViewNameOfCommand2.textAlignment = NSTextAlignmentCenter;
    [pointViewNameOfCommand2 setText:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:1]]];
    pointViewNameOfCommand2.textColor = [UIColor whiteColor];
    [pointViewNameOfCommand2 setFont:[UIFont fontWithName:@"Palatino" size:withSize]];
    [pointViewNameOfCommand2 setBackgroundColor:[UIColor clearColor]];
    
    pointViewOfCommand2 = [[UIView alloc] initWithFrame:CGRectMake(0, viewOfPoints.bounds.size.height*2/3, wightLabel - 20, 0)];
    pointViewOfCommand2.center = CGPointMake(withCenterX2, viewOfPoints.bounds.size.height*2/3);
    pointViewOfCommand2.backgroundColor = [UIColor grayColor];
    
    pointViewScoreOfCommand2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    pointViewScoreOfCommand2.center = CGPointMake(withCenterX2, viewOfPoints.bounds.size.height - 200);
    pointViewScoreOfCommand2.textAlignment = NSTextAlignmentCenter;
    [pointViewScoreOfCommand2 setText:[NSString stringWithFormat:@"%d",self.pointCommand2]];
    pointViewScoreOfCommand2.textColor = [UIColor whiteColor];
    [pointViewScoreOfCommand2 setFont:[UIFont fontWithName:@"Palatino" size:40]];
    [pointViewScoreOfCommand2 setBackgroundColor:[UIColor clearColor]];
    
    [viewOfPoints addSubview:pointViewScoreOfCommand2];
    
    [viewOfPoints addSubview:pointViewNameOfCommand2];
    [viewOfPoints addSubview:pointViewOfCommand2];
    }
}
- (void) creatLabelCommand3: (NSInteger) withSize andWithCenterXCommand3:(int) withCenterX3 andWithWightLabel:(int) wightLabel {
if (pointViewNameOfCommand3 == nil && pointViewOfCommand3 == nil && pointViewScoreOfCommand3 == nil) {
    pointViewNameOfCommand3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wightLabel, 40)];
    pointViewNameOfCommand3.center = CGPointMake(withCenterX3, viewOfPoints.bounds.size.height - 150);
    pointViewNameOfCommand3.textAlignment = NSTextAlignmentCenter;
    [pointViewNameOfCommand3 setText:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:2]]];
    pointViewNameOfCommand3.textColor = [UIColor whiteColor];
    [pointViewNameOfCommand3 setFont:[UIFont fontWithName:@"Palatino" size:withSize]];
    [pointViewNameOfCommand3 setBackgroundColor:[UIColor clearColor]];
    
    pointViewOfCommand3 = [[UIView alloc] initWithFrame:CGRectMake(0, viewOfPoints.bounds.size.height*2/3, wightLabel - 20, 0)];
    pointViewOfCommand3.center = CGPointMake(withCenterX3, viewOfPoints.bounds.size.height*2/3);
    pointViewOfCommand3.backgroundColor = [UIColor whiteColor];
    
    pointViewScoreOfCommand3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    pointViewScoreOfCommand3.center = CGPointMake(withCenterX3, viewOfPoints.bounds.size.height - 200);
    pointViewScoreOfCommand3.textAlignment = NSTextAlignmentCenter;
    [pointViewScoreOfCommand3 setText:[NSString stringWithFormat:@"%d",self.pointCommand3]];
    pointViewScoreOfCommand3.textColor = [UIColor grayColor];
    [pointViewScoreOfCommand3 setFont:[UIFont fontWithName:@"Palatino" size:40]];
    [pointViewScoreOfCommand3 setBackgroundColor:[UIColor clearColor]];
    
    [viewOfPoints addSubview:pointViewScoreOfCommand3];
    [viewOfPoints addSubview:pointViewNameOfCommand3];
    [viewOfPoints addSubview:pointViewOfCommand3];
}
}

- (void) creatLabelCommand4: (NSInteger) withSize andWithCenterXCommand4:(int) withCenterX4 andWithWightLabel:(int) wightLabel {
if (pointViewNameOfCommand4 == nil && pointViewOfCommand4 == nil && pointViewScoreOfCommand4 == nil) {
    pointViewNameOfCommand4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wightLabel, 40)];
    pointViewNameOfCommand4.center = CGPointMake(withCenterX4, viewOfPoints.bounds.size.height - 150);
    pointViewNameOfCommand4.textAlignment = NSTextAlignmentCenter;
    [pointViewNameOfCommand4 setText:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:3]]];
    pointViewNameOfCommand4.textColor = [UIColor whiteColor];
    [pointViewNameOfCommand4 setFont:[UIFont fontWithName:@"Palatino" size:withSize]];
    [pointViewNameOfCommand4 setBackgroundColor:[UIColor clearColor]];
    
    pointViewOfCommand4 = [[UIView alloc] initWithFrame:CGRectMake(0, viewOfPoints.bounds.size.height*2/3, wightLabel - 20, 0)];
    pointViewOfCommand4.center = CGPointMake(withCenterX4, viewOfPoints.bounds.size.height*2/3);
    pointViewOfCommand4.backgroundColor = [UIColor grayColor];
    
    pointViewScoreOfCommand4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    pointViewScoreOfCommand4.center = CGPointMake(withCenterX4, viewOfPoints.bounds.size.height - 200);
    pointViewScoreOfCommand4.textAlignment = NSTextAlignmentCenter;
    [pointViewScoreOfCommand4 setText:[NSString stringWithFormat:@"%d",self.pointCommand4]];
    pointViewScoreOfCommand4.textColor = [UIColor whiteColor];
    [pointViewScoreOfCommand4 setFont:[UIFont fontWithName:@"Palatino" size:40]];
    [pointViewScoreOfCommand4 setBackgroundColor:[UIColor clearColor]];
    
    [viewOfPoints addSubview:pointViewScoreOfCommand4];
    [viewOfPoints addSubview:pointViewNameOfCommand4];
    [viewOfPoints addSubview:pointViewOfCommand4];
}
}
- (void) creatLabelCommand5: (NSInteger) withSize andWithCenterXCommand5:(int) withCenterX5 andWithWightLabel:(int) wightLabel {
if (pointViewNameOfCommand5 == nil && pointViewOfCommand5 == nil && pointViewScoreOfCommand5 == nil) {
    pointViewNameOfCommand5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wightLabel, 40)];
    pointViewNameOfCommand5.center = CGPointMake(withCenterX5, viewOfPoints.bounds.size.height - 150);
    pointViewNameOfCommand5.textAlignment = NSTextAlignmentCenter;
    [pointViewNameOfCommand5 setText:[NSString stringWithFormat:@"%@",[self.commandNameArray objectAtIndex:4]]];
    pointViewNameOfCommand5.textColor = [UIColor whiteColor];
    [pointViewNameOfCommand5 setFont:[UIFont fontWithName:@"Palatino" size:withSize]];
    [pointViewNameOfCommand5 setBackgroundColor:[UIColor clearColor]];
    
    pointViewOfCommand5 = [[UIView alloc] initWithFrame:CGRectMake(0, viewOfPoints.bounds.size.height*2/3, wightLabel - 20, 0)];
    pointViewOfCommand5.center = CGPointMake(withCenterX5, viewOfPoints.bounds.size.height*2/3);
    pointViewOfCommand5.backgroundColor = [UIColor whiteColor];
    
    pointViewScoreOfCommand5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    pointViewScoreOfCommand5.center = CGPointMake(withCenterX5, viewOfPoints.bounds.size.height - 200);
    pointViewScoreOfCommand5.textAlignment = NSTextAlignmentCenter;
    [pointViewScoreOfCommand5 setText:[NSString stringWithFormat:@"%d",self.pointCommand5]];
    pointViewScoreOfCommand5.textColor = [UIColor grayColor];
    [pointViewScoreOfCommand5 setFont:[UIFont fontWithName:@"Palatino" size:40]];
    [pointViewScoreOfCommand5 setBackgroundColor:[UIColor clearColor]];
    
    [viewOfPoints addSubview:pointViewScoreOfCommand5];
    [viewOfPoints addSubview:pointViewNameOfCommand5];
    [viewOfPoints addSubview:pointViewOfCommand5];
}
}

@end

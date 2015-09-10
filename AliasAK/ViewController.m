//
//  ViewController.m
//  AliasAK
//
//  Created by mistmental on 17.08.15.
//  Copyright (c) 2015 mistmental. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) int indexOfLabelCommand;
@property (assign, nonatomic) int p;
@property (assign, nonatomic) int k;

@property (strong, nonatomic) UIButton* gameProperty;
@property (strong, nonatomic) UILabel* comandLabel;

@property (strong, nonatomic) UIButton* deleteButton;

@property (assign, nonatomic) int chosenWordsArray;

@property (assign, nonatomic) BOOL isPropertyButtonEnable;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    startGame.frame = CGRectMake(self.view.center.x - self.view.bounds.size.width/4.626, self.view.bounds.size.height*0.89, self.view.bounds.size.width/1.55 - self.view.bounds.size.width/32, self.view.bounds.size.height/10);
    startGame.backgroundColor = [UIColor clearColor];
    startGame.titleLabel.text = @".";
    [startGame setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    backgroundImage.frame = CGRectMake(0, self.view.frame.size.height*0.05, self.view.frame.size.width*1.5, self.view.frame.size.height*2.12);
    
    self.isEnableOKButton = NO;
    oK.enabled = NO;
    oK.hidden = YES;
    
    
    addButton.hidden = YES;
  
    
    firstCommand.hidden = YES;
    secondCommand.hidden = YES;
    levelHardButton.hidden = YES;
    
    NSLog(@"View width = %i , view height = %i", (int)self.view.frame.size.width, (int)self.view.frame.size.height);
    
    }



- (void) propertyOfController {
   
    self.p = 1;
    self.k = 1;
    self.chosenWordsArray = 1;
    self.isPropertyButtonEnable = NO;
    addButton.hidden = NO;
    oK.hidden = NO;
    oK.frame = CGRectMake(0, 0, self.view.bounds.size.width/2, self.view.frame.size.height/15);
    oK.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*0.902);
    [oK setBackgroundColor:[UIColor clearColor]];
    [oK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oK setBackgroundImage:[UIImage imageNamed:@"background.png"] forState:UIControlStateNormal];
   
    
    levelHardButton.hidden = NO;
    NSString* separation = @"\n";
    
        NSString* hardModeWordsTextFile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"hardModeWords" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSString* mediumModeWordsTextFile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mediumModeWords" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSString* easyModeWordsTextFile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"easyModeWords" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
   
    hardModeWords = [[NSMutableArray alloc]initWithArray:[hardModeWordsTextFile componentsSeparatedByString:separation]];
    mediumModeWords = [[NSMutableArray alloc]initWithArray:[mediumModeWordsTextFile componentsSeparatedByString:separation]];
    easyModeWords = [[NSMutableArray alloc]initWithArray:[easyModeWordsTextFile componentsSeparatedByString:separation]];

    
    chosenCommandNameArray = [[NSMutableArray alloc] init];
    gameModeWords = [[NSMutableArray alloc] init];
    allCommandNameArray = [[NSMutableArray alloc] initWithObjects:@"КРАБЫ",@"ДНАРИ",@"ОВОЩИ",@"ТАРАКАНЫ",@"УШЛЕПКИ",@"ЛОШАРЫ",@"СУКОВА THE BEST",@"КОМАНДА АЛЬФА",@"ДЕРЕВЕНЩИНЫ",@"ЛАНИСТЕРЫ",@"БРАТСТВО КОЛЬЦА", nil];
    
    [self getCommandsNameFromArray];
    
    self.indexOfLabelCommand = 3;
    NSLog(@"H = %d, E = %d, M = %d", [hardModeWords count], [easyModeWords count], [mediumModeWords count]);
    
    


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark - startButtonAction

- (IBAction) startGame:(id)sender {

    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{

        backgroundImage.center = CGPointMake(self.view.bounds.size.width/2.5771, self.view.bounds.size.height/6.0235);
        startGame.enabled = NO;
        
    } completion:^(BOOL finished) {
        NSLog(@"DONE");
        [self propertyOfController];
        }];


}

#pragma mark -
#pragma mark - getCommandLabelsAndOtherButtons

- (void) getCommandsNameFromArray {
    
    int a = arc4random() % ([allCommandNameArray count] - 1);
    
    float addButtonHeightCoefficient;
    int heightCoefficient;
    float secondCommandCenterCoefficient;
    float firstCommandCenterCoefficient;
    float gamePropertyCenterCoefficient;
    float commandLabelCenterCoefficient;
    
    int fontSizeOfButtons;
    int fontSizeOfCommandLabels;
    
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        
        addButtonHeightCoefficient = 0.2929;
        firstCommandCenterCoefficient = 0.166;
        secondCommandCenterCoefficient = 0.229;
        gamePropertyCenterCoefficient = 0.577;
        commandLabelCenterCoefficient = 0.09;
        
        fontSizeOfButtons = 30;
        fontSizeOfCommandLabels = 23;
        
        heightCoefficient = 15;
    }
    
    if (self.view.frame.size.height == 667) { //IPhone 6
        
        addButtonHeightCoefficient = 0.2929;
        firstCommandCenterCoefficient = 0.206;
        secondCommandCenterCoefficient = 0.254;
        gamePropertyCenterCoefficient = 0.577;
        commandLabelCenterCoefficient = 0.13;
        
        fontSizeOfButtons = 20;
        fontSizeOfCommandLabels = 15;
        
        heightCoefficient = 15;
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        addButtonHeightCoefficient = 0.3029;
        firstCommandCenterCoefficient = 0.206;
        secondCommandCenterCoefficient = 0.26;
        gamePropertyCenterCoefficient = 0.577;
        commandLabelCenterCoefficient = 0.12;
        
        fontSizeOfButtons = 20;
        fontSizeOfCommandLabels = 15;
        
        heightCoefficient = 15;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        
        addButtonHeightCoefficient = 0.2929;
        firstCommandCenterCoefficient = 0.206;
        secondCommandCenterCoefficient = 0.260;
        gamePropertyCenterCoefficient = 0.577;
        commandLabelCenterCoefficient = 0.145;
        
        fontSizeOfButtons = 20;
        fontSizeOfCommandLabels = 15;
        
        heightCoefficient = 15;
        
    }
    
    addButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height* addButtonHeightCoefficient);
    
    
    firstCommand.frame = CGRectMake(0,0 , self.view.frame.size.width/1.5, self.view.frame.size.height/ heightCoefficient);
    firstCommand.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height* firstCommandCenterCoefficient);
    [firstCommand setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfCommandLabels]];
    firstCommand.hidden = NO;
    secondCommand.hidden = NO;
    firstCommand.text = [NSString stringWithFormat:@"%@", [allCommandNameArray objectAtIndex:a]];
    
    [chosenCommandNameArray addObject:[allCommandNameArray objectAtIndex:a]];
    [allCommandNameArray removeObject:[allCommandNameArray objectAtIndex:a]];
    
    
    int b = arc4random() % ([allCommandNameArray count] - 1);
    secondCommand.frame = CGRectMake(0,0, self.view.frame.size.width/1.5, self.view.frame.size.height/ heightCoefficient);
    secondCommand.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height* secondCommandCenterCoefficient);
    [secondCommand setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfCommandLabels]];
    secondCommand.text = [NSString stringWithFormat:@"%@", [allCommandNameArray objectAtIndex:b]];
    
    [chosenCommandNameArray addObject:[allCommandNameArray objectAtIndex:b]];
    [allCommandNameArray removeObject:[allCommandNameArray objectAtIndex:b]];
    
    
    
    levelHardButton.frame = CGRectMake(0, 0, self.view.frame.size.width/1.5, self.view.frame.size.height/ heightCoefficient);
    levelHardButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [levelHardButton.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfButtons]];
    [levelHardButton setBackgroundImage:[UIImage imageNamed:@"background.png"] forState:UIControlStateNormal];
    [levelHardButton setTitle:[NSString stringWithFormat:@"Уровень сложности:"] forState:UIControlStateNormal];
    [levelHardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    self.gameProperty = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.gameProperty.frame = CGRectMake(0, 0, self.view.frame.size.width/1.5, self.view.frame.size.height/ heightCoefficient);
    self.gameProperty.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height* gamePropertyCenterCoefficient);
    [self.gameProperty.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:fontSizeOfButtons]];
    [self.gameProperty setTitle:[NSString stringWithFormat:@"Режим игры:"] forState:UIControlStateNormal];
    [self.gameProperty setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.gameProperty addTarget:self action:@selector(gameProperty:) forControlEvents:UIControlEventTouchUpInside];
    [self.gameProperty setBackgroundImage:[UIImage imageNamed:@"background.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.gameProperty];
    
    self.comandLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/1.5, self.view.frame.size.height/ heightCoefficient)];
    self.comandLabel.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height* commandLabelCenterCoefficient);
    self.comandLabel.font = [UIFont fontWithName:@"Palatino" size:fontSizeOfButtons];
    self.comandLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.comandLabel.text = [NSString stringWithFormat:@"Команды:"];
    self.comandLabel.textColor = [UIColor whiteColor];
    [self.comandLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.comandLabel];
    
    NSLog(@"%d",[chosenCommandNameArray count]);

}

#pragma mark -
#pragma mark - addButtonAction

- (IBAction) addCommand:(id)sender{
    
    int i;
    int sizeFont;
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        i = 65;
        sizeFont = 23;
    }
    if (self.view.frame.size.height == 667) { //IPhone 6
        i = 32;
        sizeFont = 15;
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        i = 40;
        sizeFont = 15;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        i = 32;
        sizeFont = 15;
        
    }
    
    if (self.indexOfLabelCommand == 3) {
        
        
        thirdCommand = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/6, 0, self.view.frame.size.width/1.5, self.view.frame.size.height/15)];
        [thirdCommand setFont:[UIFont fontWithName:@"Palatino" size:sizeFont]];
        
        [thirdCommand setTextAlignment:UITextAlignmentCenter];
        
        int a = arc4random() % ([allCommandNameArray count] - 1);
        
        thirdCommand.text = [NSString stringWithFormat:@"%@", [allCommandNameArray objectAtIndex:a]];
        [chosenCommandNameArray addObject:[allCommandNameArray objectAtIndex:a]];
        [allCommandNameArray removeObject:[allCommandNameArray objectAtIndex:a]];
        thirdCommand.textColor = [UIColor blackColor];
        
        [self.view addSubview: thirdCommand];
        
        [UIView animateWithDuration:0.7 animations:^{
            thirdCommand.center = CGPointMake(self.view.frame.size.width/2, secondCommand.center.y + i);
        } completion:^(BOOL finished) {
            
            [self deleteButtonCreate:self.view.bounds.size.width/1.5 andCenterY:secondCommand.center.y + i andRightFromCommandName:(self.view.bounds.size.width*3/4)];
            
          
        }];
        [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            addButton.center = CGPointMake(secondCommand.center.x, secondCommand.center.y + i*2);
        } completion:^(BOOL finished) {
        
        }];
        
    }
    
    if (self.indexOfLabelCommand == 4) {
        
        fourCommand = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/6, 0, self.view.frame.size.width/1.5, self.view.frame.size.height/15)];
        [fourCommand setFont:[UIFont fontWithName:@"Palatino" size:sizeFont]];
         fourCommand.textAlignment = UITextAlignmentCenter;
        int a = arc4random() % ([allCommandNameArray count] - 1);
        fourCommand.text = [NSString stringWithFormat:@"%@", [allCommandNameArray objectAtIndex:a]];
        [chosenCommandNameArray addObject:[allCommandNameArray objectAtIndex:a]];
        [allCommandNameArray removeObject:[allCommandNameArray objectAtIndex:a]];
        fourCommand.textColor = [UIColor blackColor];
        
        [self.view addSubview: fourCommand];
        [UIView animateWithDuration:0.7 animations:^{
            fourCommand.center = CGPointMake((int)secondCommand.center.x, (int)secondCommand.center.y + i*2);
        } completion:^(BOOL finished) {
            
            [self deleteButtonCreate:(int)self.view.bounds.size.width/1.5 andCenterY:secondCommand.center.y + 2*i andRightFromCommandName:(self.view.bounds.size.width*3/4)];
       
        }];
        [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            addButton.center = CGPointMake(secondCommand.center.x, secondCommand.center.y + i*3);
        } completion:^(BOOL finished) {
      
        }];
        
    }
    if (self.indexOfLabelCommand == 5) {
        
        fifthCommand = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/6, 0, self.view.frame.size.width/1.5, self.view.frame.size.height/15)];
        fifthCommand.textAlignment = UITextAlignmentCenter;
        [fifthCommand setFont:[UIFont fontWithName:@"Palatino" size:sizeFont]];
        int a = arc4random() % ([allCommandNameArray count] - 1);
        fifthCommand.text = [NSString stringWithFormat:@"%@", [allCommandNameArray objectAtIndex:a]];
        [chosenCommandNameArray addObject:[allCommandNameArray objectAtIndex:a]];
        [allCommandNameArray removeObject:[allCommandNameArray objectAtIndex:a]];
        fifthCommand.textColor = [UIColor blackColor];
        
        [self.view addSubview: fifthCommand];
        [UIView animateWithDuration:0.7 animations:^{
            fifthCommand.center = CGPointMake(secondCommand.center.x, secondCommand.center.y + i*3);
        } completion:^(BOOL finished) {
            [self deleteButtonCreate:self.view.bounds.size.width/1.5 andCenterY:secondCommand.center.y + 3*i andRightFromCommandName:(self.view.bounds.size.width*3/4)];
     
        }];
        [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            addButton.center = CGPointMake(secondCommand.center.x, secondCommand.center.y + i*4);
        } completion:^(BOOL finished) {
       
            addButton.hidden = YES;
        }];
        
    }
    self.indexOfLabelCommand++;
    
    NSLog(@"%d",[chosenCommandNameArray count]);
}


- (void) deleteButtonCreate: (int) centerX andCenterY:(int) centerY andRightFromCommandName:(int) rightFromCommandName {
    
    if (self.deleteButton == nil) {
         self.deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    }
    int sizeFont;
    
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        sizeFont = 40;
    }
    if (self.view.frame.size.height == 667) { //IPhone 6
        sizeFont = 40;
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        sizeFont = 40;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        sizeFont = 40;
    }
    [self.deleteButton setTitle:@"-" forState:UIControlStateNormal];
    [self.deleteButton.titleLabel setFont:[UIFont fontWithName:@"Palatino" size:sizeFont]];
    [self.deleteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.deleteButton.frame = CGRectMake(0, 0, sizeFont, sizeFont);
    self.deleteButton.center = CGPointMake(centerX, centerY);
    [self.deleteButton addTarget:self action:@selector(deleteCurrentCommand) forControlEvents:UIControlEventTouchUpInside];
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.deleteButton.center = CGPointMake(rightFromCommandName, centerY);
        [self.view addSubview:self.deleteButton];
    } completion:^(BOOL finished) {
 
    }];
    
   
}

- (void) deleteCurrentCommand {
    
    int i;
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        i = 65;
    }
    if (self.view.frame.size.height == 667) { //IPhone 6
        i = 32;
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        i = 40;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        i = 32;
    }
    
    if (self.indexOfLabelCommand == 4) {
    [chosenCommandNameArray removeLastObject];
        [thirdCommand removeFromSuperview];
        [self.deleteButton removeFromSuperview];
        self.indexOfLabelCommand--;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            addButton.center = CGPointMake(secondCommand.center.x, secondCommand.center.y + i);
        } completion:^(BOOL finished) {

        }];
    }
    if (self.indexOfLabelCommand == 5) {
        [chosenCommandNameArray removeLastObject];
        [fourCommand removeFromSuperview];
        [self deleteButtonCreate:self.view.bounds.size.width/1.5 andCenterY:secondCommand.center.y + i andRightFromCommandName:self.view.bounds.size.width*3/4];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            addButton.center = CGPointMake(secondCommand.center.x, secondCommand.center.y + 2*i);
        } completion:^(BOOL finished) {

        }];
        self.indexOfLabelCommand--;
    }
    if (self.indexOfLabelCommand == 6) {
        [chosenCommandNameArray removeLastObject];
        [fifthCommand removeFromSuperview];
        [self deleteButtonCreate:self.view.bounds.size.width/1.5 andCenterY:secondCommand.center.y + 2*i andRightFromCommandName:self.view.bounds.size.width*3/4];
        self.indexOfLabelCommand--;
        addButton.hidden = NO;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            addButton.center = CGPointMake(secondCommand.center.x, secondCommand.center.y + 3*i);
        } completion:^(BOOL finished) {

        }];
    }
    NSLog(@"%d",[chosenCommandNameArray count]);
}


#pragma mark -
#pragma mark - okButtonAction


- (IBAction) oK:(id)sender {
    
    if (self.chosenWordsArray == 1) {

        [gameModeWords addObjectsFromArray:easyModeWords];
    }
    
    if (self.chosenWordsArray == 2) {
        [gameModeWords addObjectsFromArray:mediumModeWords];

    }
    if (self.chosenWordsArray == 3) {

        [gameModeWords addObjectsFromArray:hardModeWords];
    }
    
    [self returnWordsArray];
    [self returnCommandNames];
    [self returnSecondsInRound];
    [self returnPointsToWin];

}

- (NSMutableArray*) returnWordsArray
{
    return gameModeWords;
}

- (NSMutableArray*) returnCommandNames
{
    
    return chosenCommandNameArray;
}
- (int) returnSecondsInRound {


    return secondsInRound;
}
- (int) returnPointsToWin {


    return pointsToWin;
}

#pragma mark -
#pragma mark - levelHardButtonAction

- (IBAction) levelHardButton:(id)sender{
    NSArray* array1;
    if (array1 == nil && levelModeSegmend == nil) {
        NSArray* array1 = [[NSArray alloc] initWithObjects:@"легко",@"нормально",@"сложно", nil];
        levelModeSegmend = [[UISegmentedControl alloc] initWithItems:array1];
        levelModeSegmend.selectedSegmentIndex = 0;
        self.chosenWordsArray = 1;
    }
    int i;
    int distanceFromSegmendToLevelHardButton;
    int distanceFromButtonToButton;
    
    int distanceFromProperyGameButtonToLableSegment1;
    int distanceFromProperyGameButtonToSegment1;
    int distanceFromProperyGameButtonToLableSegment2;
    int distanceFromProperyGameButtonToSegment2;
    
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        i = 55;
        distanceFromSegmendToLevelHardButton = 65;
        distanceFromButtonToButton = 130;
        
        distanceFromProperyGameButtonToLableSegment1 = 65;
        distanceFromProperyGameButtonToSegment1 = 105;
         distanceFromProperyGameButtonToLableSegment2 = 150;
         distanceFromProperyGameButtonToSegment2 = 190;
    }
    if (self.view.frame.size.height == 667) { //IPhone 6
        i = 40;
        distanceFromSegmendToLevelHardButton = 50;
        distanceFromButtonToButton = 100;
        
        distanceFromProperyGameButtonToLableSegment1 = 32;
        distanceFromProperyGameButtonToSegment1 = 60;
        distanceFromProperyGameButtonToLableSegment2 = 85;
        distanceFromProperyGameButtonToSegment2 = 110;
        
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        i = 40;
        distanceFromSegmendToLevelHardButton = 50;
        distanceFromButtonToButton = 100;
        
        distanceFromProperyGameButtonToLableSegment1 = 40;
        distanceFromProperyGameButtonToSegment1 = 65;
        distanceFromProperyGameButtonToLableSegment2 = 100;
        distanceFromProperyGameButtonToSegment2 = 125;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        i = 30;
        distanceFromSegmendToLevelHardButton = 38;
        distanceFromButtonToButton = 75;
        
        distanceFromProperyGameButtonToLableSegment1 = 32;
        distanceFromProperyGameButtonToSegment1 = 55;
        distanceFromProperyGameButtonToLableSegment2 = 80;
        distanceFromProperyGameButtonToSegment2 = 104;
    }
    if (self.p % 2 == 0) { // ЗАКРЫТИЕ
        
        if (self.isPropertyButtonEnable == NO) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            levelModeSegmend.center = CGPointMake(self.view.bounds.size.width/2, levelHardButton.center.y);
            
            self.gameProperty.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y - i);
           
        } completion:^(BOOL finished) {
            
            levelModeSegmend.hidden = YES;
            levelModeSegmend.enabled = NO;
            
            self.gameProperty.enabled = YES;
            self.gameProperty.hidden = NO;
        }];
        }
        if (self.isPropertyButtonEnable == YES) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                levelModeSegmend.center = CGPointMake(self.view.bounds.size.width/2, levelHardButton.center.y);
                
                self.gameProperty.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y - i);
                
                pointsToWinSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y + distanceFromProperyGameButtonToSegment1);
                labelForPointsToWinSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y + distanceFromProperyGameButtonToLableSegment1);
                labelForPointsToWinSegmend.hidden = NO;
                pointsToWinSegmend.hidden = NO;
                pointsToWinSegmend.enabled = YES;
                
                timeSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y + distanceFromProperyGameButtonToSegment2);
                labelForTimeSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y + distanceFromProperyGameButtonToLableSegment2);
                labelForTimeSegmend.hidden = NO;
                timeSegmend.hidden = NO;
                timeSegmend.enabled = YES;

                
            } completion:^(BOOL finished) {
                NSLog(@"DONE!!!");
                
                levelModeSegmend.hidden = YES;
                levelModeSegmend.enabled = NO;
                
                self.gameProperty.enabled = YES;
                self.gameProperty.hidden = NO;
            }];

            
        }
    }
    
    if (self.p %2 == 1) { // ОТКРЫТИЕ
        
        
        levelModeSegmend.backgroundColor = [UIColor clearColor];
        levelModeSegmend.frame = CGRectMake(levelHardButton.bounds.origin.x, levelHardButton.bounds.origin.y, self.view.bounds.size.width/1.5, levelHardButton.bounds.size.height/1.5);
        levelModeSegmend.center = CGPointMake(levelHardButton.center.x, levelHardButton.center.y);
        levelModeSegmend.tintColor = [UIColor blackColor];
        levelModeSegmend.segmentedControlStyle = UISegmentedControlSegmentCenter;
        [levelModeSegmend addTarget:self action:@selector(levelModeSegmendAction:) forControlEvents: UIControlEventValueChanged];
        
        [self.view addSubview:levelModeSegmend];
        
        if (self.isPropertyButtonEnable == NO) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                levelModeSegmend.center = CGPointMake(self.view.bounds.size.width/2, levelHardButton.center.y + distanceFromSegmendToLevelHardButton);
                levelModeSegmend.hidden = NO;
                levelModeSegmend.enabled = YES;
                
                 self.gameProperty.center = CGPointMake(self.view.bounds.size.width/2, levelHardButton.center.y + distanceFromButtonToButton);
                
            } completion:^(BOOL finished) {
                }];
                
        }
        
        if (self.isPropertyButtonEnable == YES) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                levelModeSegmend.center = CGPointMake(self.view.bounds.size.width/2, levelHardButton.center.y + distanceFromSegmendToLevelHardButton);
                levelModeSegmend.hidden = NO;
                levelModeSegmend.enabled = YES;
                
                self.gameProperty.center = CGPointMake(self.view.bounds.size.width/2, levelHardButton.center.y + distanceFromButtonToButton);
                
                pointsToWinSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y + distanceFromProperyGameButtonToSegment1);
                labelForPointsToWinSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y + distanceFromProperyGameButtonToLableSegment1);
                labelForPointsToWinSegmend.hidden = NO;
                pointsToWinSegmend.hidden = NO;
                pointsToWinSegmend.enabled = YES;
                
                timeSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y + distanceFromProperyGameButtonToSegment2);
                labelForTimeSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y + distanceFromProperyGameButtonToLableSegment2);
                labelForTimeSegmend.hidden = NO;
                timeSegmend.hidden = NO;
                timeSegmend.enabled = YES;
                
            } completion:^(BOOL finished) {
                NSLog(@"DONE");
            }];
        }
    }
    
    self.p++;
    
    NSLog(@"%d", self.chosenWordsArray);
}


#pragma mark -
#pragma mark - gamePropertyButtonAction

- (IBAction) gameProperty:(id)sender {
    NSArray* array1;
    NSArray* array2;
    
    if (array1 == nil && array2 == nil && pointsToWinSegmend == nil && timeSegmend == nil && labelForPointsToWinSegmend == nil && labelForTimeSegmend == nil) {
   
         array1 = [[NSArray alloc] initWithObjects:@"50",@"100", nil];
        pointsToWinSegmend = [[UISegmentedControl alloc] initWithItems:array1];
        labelForPointsToWinSegmend = [[UILabel alloc] initWithFrame:CGRectMake(self.gameProperty.bounds.origin.x, self.gameProperty.bounds.origin.y, self.view.bounds.size.width, self.gameProperty.bounds.size.height)];
        pointsToWinSegmend.selectedSegmentIndex = 0;
        
        array2 = [[NSArray alloc] initWithObjects:@"30",@"60",@"120", nil];
        timeSegmend = [[UISegmentedControl alloc] initWithItems:array2];
        labelForTimeSegmend = [[UILabel alloc] initWithFrame:CGRectMake(self.gameProperty.bounds.origin.x, self.gameProperty.bounds.origin.y, self.view.bounds.size.width, self.gameProperty.bounds.size.height)];
        timeSegmend.selectedSegmentIndex = 0;
        
        secondsInRound = 30;
        pointsToWin = 50;
    }

    int sizeFont;
    
    int distanceFromProperyGameButtonToLableSegment1;
    int distanceFromProperyGameButtonToSegment1;
    int distanceFromProperyGameButtonToLableSegment2;
    int distanceFromProperyGameButtonToSegment2;
    
    if (self.view.frame.size.height == 1024) { //IPad Air && IPad Retina && IPad 2
        sizeFont = 23;
        
        distanceFromProperyGameButtonToLableSegment1 = 65;
        distanceFromProperyGameButtonToSegment1 = 105;
        distanceFromProperyGameButtonToLableSegment2 = 150;
        distanceFromProperyGameButtonToSegment2 = 190;
    }
    if (self.view.frame.size.height == 667) { //IPhone 6
        sizeFont = 15;
        
        distanceFromProperyGameButtonToLableSegment1 = 32;
        distanceFromProperyGameButtonToSegment1 = 60;
        distanceFromProperyGameButtonToLableSegment2 = 85;
        distanceFromProperyGameButtonToSegment2 = 110;
        
    }
    if (self.view.frame.size.height == 736) { //IPhone 6Plus
        sizeFont = 15;
        
        distanceFromProperyGameButtonToLableSegment1 = 40;
        distanceFromProperyGameButtonToSegment1 = 65;
        distanceFromProperyGameButtonToLableSegment2 = 100;
        distanceFromProperyGameButtonToSegment2 = 125;
    }
    if (self.view.frame.size.height == 568) { //IPhone 5 && IPhone 5S
        sizeFont = 15;
        
        distanceFromProperyGameButtonToLableSegment1 = 32;
        distanceFromProperyGameButtonToSegment1 = 55;
        distanceFromProperyGameButtonToLableSegment2 = 80;
        distanceFromProperyGameButtonToSegment2 = 104;
    }

    if (self.k%2 == 1) {
        
        self.isPropertyButtonEnable = YES;
        
        pointsToWinSegmend.frame = CGRectMake(self.gameProperty.bounds.origin.x, self.gameProperty.bounds.origin.y, self.view.bounds.size.width/1.5, self.gameProperty.bounds.size.height/1.5);
        pointsToWinSegmend.center = CGPointMake(self.gameProperty.center.x, self.gameProperty.center.y);
        pointsToWinSegmend.backgroundColor = [UIColor clearColor];
        pointsToWinSegmend.tintColor = [UIColor blackColor];
        pointsToWinSegmend.segmentedControlStyle = UISegmentedControlSegmentCenter;
        [pointsToWinSegmend addTarget:self action:@selector(PointsToWinSegmendAction:) forControlEvents: UIControlEventValueChanged];
       
        [self.view addSubview:pointsToWinSegmend];
        
        
        [labelForPointsToWinSegmend setText:@"Количество очков для победы:"];
        labelForPointsToWinSegmend.center = CGPointMake(self.gameProperty.center.x, self.gameProperty.center.y);
        [labelForPointsToWinSegmend setFont:[UIFont fontWithName:@"Palatino" size:sizeFont]];
        labelForPointsToWinSegmend.textColor = [UIColor blackColor];
        labelForPointsToWinSegmend.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:labelForPointsToWinSegmend];
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            pointsToWinSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y + distanceFromProperyGameButtonToSegment1);
            labelForPointsToWinSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y + distanceFromProperyGameButtonToLableSegment1);
            labelForPointsToWinSegmend.hidden = NO;
            pointsToWinSegmend.hidden = NO;
            pointsToWinSegmend.enabled = YES;
            
        } completion:^(BOOL finished) {
            NSLog(@"DONE!!!");
            
        }];
        timeSegmend.frame = CGRectMake(self.gameProperty.bounds.origin.x, self.gameProperty.bounds.origin.y, self.view.bounds.size.width/1.5, self.gameProperty.bounds.size.height/1.5);
        timeSegmend.center = CGPointMake(self.gameProperty.center.x, self.gameProperty.center.y);
        timeSegmend.backgroundColor = [UIColor clearColor];
        timeSegmend.tintColor = [UIColor blackColor];
        
        timeSegmend.segmentedControlStyle = UISegmentedControlSegmentCenter;
        [timeSegmend addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];

        [self.view addSubview:timeSegmend];
        
        
        [labelForTimeSegmend setText:@"Количество секунд в раунде:"];
         labelForTimeSegmend.center = CGPointMake(self.gameProperty.center.x, self.gameProperty.center.y);
        [labelForTimeSegmend setFont:[UIFont fontWithName:@"Palatino" size:sizeFont]];
        labelForTimeSegmend.textColor = [UIColor blackColor];
        labelForTimeSegmend.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:labelForTimeSegmend];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            timeSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y + distanceFromProperyGameButtonToSegment2);
            labelForTimeSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y + distanceFromProperyGameButtonToLableSegment2);
            labelForTimeSegmend.hidden = NO;
            timeSegmend.hidden = NO;
            timeSegmend.enabled = YES;
            
        } completion:^(BOOL finished) {
            NSLog(@"DONE!!!");
            
        }];
        
       
    }
    else {
    
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            pointsToWinSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y);
            labelForPointsToWinSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y);
        } completion:^(BOOL finished) {
            NSLog(@"DONE!!!");
            labelForPointsToWinSegmend.hidden = YES;
            pointsToWinSegmend.hidden = YES;
            pointsToWinSegmend.enabled = NO;
            
            self.isPropertyButtonEnable = NO;
        }];
        
      [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            timeSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y);
          labelForTimeSegmend.center = CGPointMake(self.view.bounds.size.width/2, self.gameProperty.center.y);
            
        } completion:^(BOOL finished) {
            NSLog(@"DONE!!!");
            labelForTimeSegmend.hidden  = YES;
            timeSegmend.hidden = YES;
            timeSegmend.enabled = NO;
        }];
     

    }
    self.k++;


    NSLog(@"%d", secondsInRound);
    NSLog(@"%d", pointsToWin);
    if (pointsToWinSegmend.selectedSegmentIndex >= 0) {
        oK.enabled = YES;
        self.isEnableOKButton = YES;
    }

}

#pragma mark -
#pragma mark - segmentsAction

- (IBAction) MySegmentControlAction:(id)sender {

    switch (timeSegmend.selectedSegmentIndex) {
        case 0:{
            secondsInRound = 30;
            break;
        }
        case 1:{
            secondsInRound = 60;
            break;
        }
        case 2:{
            secondsInRound = 120;
            break;
        }
            
    }

    NSLog(@"Seconds = %d", secondsInRound);


}

- (IBAction) PointsToWinSegmendAction:(id)sender {

    switch (pointsToWinSegmend.selectedSegmentIndex) {
        case 0:{
            pointsToWin = 50;
            break;
        }
        case 1: {
            pointsToWin = 100;
            break;
        
        }
      
    }
    
    if (pointsToWinSegmend.selectedSegmentIndex >= 0) {
        oK.enabled = YES;
        self.isEnableOKButton = YES;
    }

    NSLog(@"%d", pointsToWin);
}

- (IBAction) levelModeSegmendAction:(id)sender{
    switch (levelModeSegmend.selectedSegmentIndex) {
        case 0: {
            
            self.chosenWordsArray = 1;
            break;
        }
        case 1: {
            
            self.chosenWordsArray = 2;
            break;
            
        }
        case 2: {
            
            self.chosenWordsArray = 3;
            break;
        }
            
            
    }
    
    NSLog(@"%d", self.chosenWordsArray);
    if (secondsInRound > 0 && pointsToWin > 0) {
        oK.enabled = YES;
        self.isEnableOKButton = YES;
    }
    
 
}




@end

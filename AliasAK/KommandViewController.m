//
//  KommandViewController.m
//  AliasAK
//
//  Created by mistmental on 17.08.15.
//  Copyright (c) 2015 mistmental. All rights reserved.
//

#import "KommandViewController.h"

@interface KommandViewController()

@property (assign, nonatomic) int indexOfLabelCommand;

@end

@implementation KommandViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    backgroundImage.frame = CGRectMake(0, 50, (int)self.view.frame.size.width*1.5, (int)self.view.frame.size.height*2);

    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
       // backgroundImage.frame = CGRectMake((int)self.view.frame.size.width*1.5, (int)self.view.frame.size.height*1.5, (int)self.view.frame.size.width*1.5, (int)self.view.frame.size.height*1.5);
        
        backgroundImage.center = CGPointMake(200, 300);

    } completion:^(BOOL finished) {
        NSLog(@"DONE");
       // backgroundImage.frame = CGRectMake(0, 50, (int)self.view.frame.size.width*1.5, (int)self.view.frame.size.height*1.5);
    //}];
        self.isEnableOKButton = NO;
        oK.enabled = NO;
        addButton.hidden = NO;
        
        hardLevel.frame = CGRectMake(0, (int)self.view.bounds.size.height/2, (int)self.view.bounds.size.width, (int)self.view.bounds.size.height/17);
        hardLevel.backgroundColor = [UIColor blackColor];
        hardLevel.textColor = [UIColor whiteColor];
        
        comands.frame = CGRectMake(0, (int)self.view.bounds.size.height/17, (int)self.view.bounds.size.width, (int)self.view.bounds.size.height/17);
        comands.backgroundColor = [UIColor blackColor];
        comands.textColor = [UIColor whiteColor];
        
        hardModeWords = [[NSMutableArray alloc] initWithObjects:@"латентность",@"алочность",@"абстракция",@"индекс",@"проэкция",@"терапия",@"амфитамин",@"витрина",@"омут",@"коллос",@"пестрость",@"контузия",@"конвульсия", nil];
        mediumModeWords = [[NSMutableArray alloc] initWithObjects: @"титева",@"экспонента",@"абордаж",@"курага", @"штиль", nil];
        easyModeWords = [[NSMutableArray alloc] initWithObjects:@"черепаха",@"флот",@"дракон",@"кровь",@"клавиатура", nil];
        
        
        chosenCommandNameArray = [[NSMutableArray alloc] init];
        allCommandNameArray = [[NSMutableArray alloc] initWithObjects:@"КРАБЫ",@"ДНАРИ",@"ОВОЩИ",@"ТАРАКАНЫ",@"УШЛЕПКИ",@"ЛОШАРЫ",@"СУКОВА THE BEST",@"КОМАНДА АЛЬФА",@"ДЕРЕВЕНЩИНЫ",@"ЛАНИСТЕРЫ",@"БРАТСТВО КОЛЬЦА", nil];
        
        [self getCommandsNameFromArray];
        
        self.indexOfLabelCommand = 3;
        NSLog(@"H = %d, E = %d, M = %d", [hardModeWords count], [easyModeWords count], [mediumModeWords count]);
        
        addButton.center = CGPointMake((int)secondCommand.center.x, (int)secondCommand.center.y + 65);

        
    }];
    
    
    }



- (void) getCommandsNameFromArray {

    int a = arc4random() % ([allCommandNameArray count] - 1);
    
    firstCommand.text = [NSString stringWithFormat:@"%@", [allCommandNameArray objectAtIndex:a]];
    [chosenCommandNameArray addObject:[allCommandNameArray objectAtIndex:a]];
    [allCommandNameArray removeObject:[allCommandNameArray objectAtIndex:a]];
    
    
    int b = arc4random() % ([allCommandNameArray count] - 1);
    secondCommand.text = [NSString stringWithFormat:@"%@", [allCommandNameArray objectAtIndex:b]];
    [chosenCommandNameArray addObject:[allCommandNameArray objectAtIndex:b]];
    [allCommandNameArray removeObject:[allCommandNameArray objectAtIndex:b]];

    NSLog(@"OKKKK");
}



- (IBAction) addCommand:(id)sender{
    
    int i = 65;

    if (self.indexOfLabelCommand == 3) {
    
      
        
    thirdCommand = [[UILabel alloc] initWithFrame:CGRectMake(i, 0, (int)secondCommand.bounds.size.width, (int)secondCommand.bounds.size.height)];
        
        thirdCommand.textAlignment = UITextAlignmentCenter;
  
        [thirdCommand setFont:[UIFont fontWithName:@"Palatino" size:23]];
        
        int a = arc4random() % ([allCommandNameArray count] - 1);
        thirdCommand.text = [NSString stringWithFormat:@"%@", [allCommandNameArray objectAtIndex:a]];
        [chosenCommandNameArray addObject:[allCommandNameArray objectAtIndex:a]];
        [allCommandNameArray removeObject:[allCommandNameArray objectAtIndex:a]];
    thirdCommand.textColor = [UIColor blackColor];
   
    [self.view addSubview: thirdCommand];
        
        [UIView animateWithDuration:0.7 animations:^{
            thirdCommand.center = CGPointMake((int)secondCommand.center.x, (int)secondCommand.center.y + i);
        } completion:^(BOOL finished) {
            NSLog(@"DONE");
        }];
        [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            addButton.center = CGPointMake((int)secondCommand.center.x, (int)secondCommand.center.y + i*2);
        } completion:^(BOOL finished) {
            NSLog(@"DONE");
        }];
    
    }
   
    if (self.indexOfLabelCommand == 4) {
        
        UILabel* fourCommand = [[UILabel alloc] initWithFrame:CGRectMake(i, 0, (int)secondCommand.bounds.size.width, (int)secondCommand.bounds.size.height)];
        
        fourCommand.textAlignment = UITextAlignmentCenter;
        [fourCommand setFont:[UIFont fontWithName:@"Palatino" size:23]];
        int a = arc4random() % ([allCommandNameArray count] - 1);
        fourCommand.text = [NSString stringWithFormat:@"%@", [allCommandNameArray objectAtIndex:a]];
        [chosenCommandNameArray addObject:[allCommandNameArray objectAtIndex:a]];
        [allCommandNameArray removeObject:[allCommandNameArray objectAtIndex:a]];
        fourCommand.textColor = [UIColor blackColor];
        
        [self.view addSubview: fourCommand];
        [UIView animateWithDuration:0.7 animations:^{
            fourCommand.center = CGPointMake((int)secondCommand.center.x, (int)secondCommand.center.y + i*2);
        } completion:^(BOOL finished) {
            NSLog(@"DONE");
        }];
        [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            addButton.center = CGPointMake((int)secondCommand.center.x, (int)secondCommand.center.y + i*3);
        } completion:^(BOOL finished) {
            NSLog(@"DONE");
        }];
        
    }
    if (self.indexOfLabelCommand == 5) {
        
        UILabel* fiveCommand = [[UILabel alloc] initWithFrame:CGRectMake(i, 0, (int)secondCommand.bounds.size.width, (int)secondCommand.bounds.size.height)];
       
        fiveCommand.textAlignment = UITextAlignmentCenter;
       [fiveCommand setFont:[UIFont fontWithName:@"Palatino" size:23]];
        int a = arc4random() % ([allCommandNameArray count] - 1);
        fiveCommand.text = [NSString stringWithFormat:@"%@", [allCommandNameArray objectAtIndex:a]];
        [chosenCommandNameArray addObject:[allCommandNameArray objectAtIndex:a]];
        [allCommandNameArray removeObject:[allCommandNameArray objectAtIndex:a]];
        fiveCommand.textColor = [UIColor blackColor];
        
        [self.view addSubview: fiveCommand];
        [UIView animateWithDuration:0.7 animations:^{
            fiveCommand.center = CGPointMake((int)secondCommand.center.x, (int)secondCommand.center.y + i*3);
        } completion:^(BOOL finished) {
            NSLog(@"DONE");
        }];
        [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            addButton.center = CGPointMake((int)secondCommand.center.x, (int)secondCommand.center.y + i*4);
        } completion:^(BOOL finished) {
            NSLog(@"DONE");
            addButton.hidden = YES;
        }];
        
    }
    self.indexOfLabelCommand++;

}

- (IBAction) hardMode:(id)sender {
    
    gameModeWords = [[NSMutableArray alloc] initWithArray:hardModeWords];
    [mediumModeWords removeAllObjects];
    [easyModeWords removeAllObjects];
    //hardMode.enabled = NO;
    [hardMode setTintColor:[UIColor blackColor]];
//  easyMode.hidden = YES;
  //  mediumMode.hidden = YES;
    easyMode.enabled = NO;
    mediumMode.enabled = NO;
    oK.enabled = YES;
    
    self.isEnableOKButton = YES;
    
   
}
- (IBAction) easyMode:(id)sender {
    gameModeWords = [[NSMutableArray alloc] initWithArray:easyModeWords];
    [mediumModeWords removeAllObjects];
    [hardModeWords removeAllObjects];
   // easyMode.enabled = NO;
   // hardMode.hidden = YES;
   // mediumMode.hidden = YES;
    [easyMode setTintColor:[UIColor blackColor]];
    hardMode.enabled = NO;
    mediumMode.enabled = NO;
    oK.enabled = YES;
    self.isEnableOKButton = YES;
 
}
- (IBAction) mediumMode:(id)sender {
    gameModeWords = [[NSMutableArray alloc] initWithArray:mediumModeWords];
    [easyModeWords removeAllObjects];
    [hardModeWords removeAllObjects];
   // mediumMode.enabled = NO;
   // hardMode.hidden = YES;
   // easyMode.hidden = YES;
    [mediumMode setTintColor:[UIColor blackColor]];
    
    hardMode.enabled = NO;
    easyMode.enabled = NO;
    oK.enabled = YES;
    self.isEnableOKButton = YES;
    
}


- (IBAction) oK:(id)sender {
    
    NSLog(@"PEREHOD NACHALSYA");
    
    
//  / [self presentViewController:vv animated:YES completion:nil];
    
    [self returnWordsArray];
    [self returnCommandNames];
    NSLog(@"PEREHOD ZAKONCHILSYA");
}

- (NSMutableArray*) returnWordsArray
{
        return gameModeWords;
}

- (NSMutableArray*) returnCommandNames
{
    
    return chosenCommandNameArray;
}

/*
NSLog(@"%@", self.chosenCommandNameArray);
NSLog(@"%@", self.gameModeWords);

NSLog(@"%@", self.chosenCommandNameArray);
NSLog(@"%@", self.gameModeWords);
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 if (sender.tag == 100) //  проверка та ли кнопка нажата
 {
 SecondViewController *svc = [segue destinationViewController]; // получение ссылки на второй класс
 svc.array = [NSArray initWithArray: arrayOfPassword]; // инициализация массива во втором классе вашим изначальным массивом
 svc.string = [NSString initWithString:dbPathString];
 }
 }

NSLog(@"%@", commandNameArray);
NSLog(@"%@", gameModeWordsArray);
*/
@end

//
//  ViewController.h
//  FirstGame
//
//  Created by Jack Lapin on 30.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#define BallSpeed CGPointMake(8.0f, 8.0f)
#define BotSpeed 4
#define endScore 5

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *botImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ballImageView;
@property (weak, nonatomic) IBOutlet UIImageView *stickImageView;
@property (strong, nonatomic) NSTimer * timer;
-(IBAction) startTimer;
-(IBAction) stopTimer;
- (IBAction)startButtonPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UILabel *autoBot;
@property (weak, nonatomic) IBOutlet UILabel *botGol;
@property (weak, nonatomic) IBOutlet UILabel *playerGol;
@property (weak, nonatomic) IBOutlet UILabel *winner;

@end


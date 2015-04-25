//
//  TimerVC.h
//  Students
//
//  Created by Jack Lapin on 22.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerVC : UIViewController 


-(IBAction) startTimer;
-(IBAction) stopTimer;

@property (weak, nonatomic) IBOutlet UISlider *mySlider1;
@property (weak, nonatomic) IBOutlet UISlider *mySlider2;
@property (weak, nonatomic) IBOutlet UISlider *mySlider3;
@property (weak, nonatomic) IBOutlet UISlider *mySlider4;
@property (weak, nonatomic) IBOutlet UISlider *mySlider5;

@property (nonatomic) NSTimer *myTimer;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)stertButtonPress:(id)sender;

- (IBAction)moveBack:(id)sender;
@end

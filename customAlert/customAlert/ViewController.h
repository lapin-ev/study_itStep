//
//  ViewController.h
//  customAlert
//
//  Created by Jack Lapin on 06.06.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAlertView.h"

@interface ViewController : UIViewController

@property MyAlertView *myAlert;

@property (strong, nonatomic) IBOutlet UILabel *labelEnteredText;
- (IBAction)forwardButtonPress:(UIBarButtonItem *)sender;

- (IBAction)showAlert:(UIButton *)sender;

@end


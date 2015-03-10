//
//  ViewController.h
//  SWAplication
//
//  Created by Jack Lapin on 05.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic, readwrite) IBOutlet UILabel *myLabel;

@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) IBOutlet UITextField *enteredText;

- (IBAction)tochUpInside:(id)sender;
- (IBAction)finishEntering:(id)sender;
- (IBAction)startEditing:(id)sender;
- (IBAction)ValueChanged:(id)sender;

@end


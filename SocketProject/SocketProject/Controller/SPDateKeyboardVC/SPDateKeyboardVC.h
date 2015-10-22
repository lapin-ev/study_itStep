//
//  JCDateKeyboardController.h
//  Join2City
//
//  Created by Anton on 31.08.14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPDateKeyboardVC : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property BOOL dateKeyboardHidden;

- (void)initWithView:(UIView *)view;

- (void)hiddenPicker;
- (void)showPicker;

@end

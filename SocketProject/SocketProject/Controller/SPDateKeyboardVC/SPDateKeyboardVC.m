//
//  JCDateKeyboardController.m
//  Join2City
//
//  Created by Anton on 31.08.14.
//  Copyright (c) 2014 Anton. All rights reserved.
//

#import "SPDateKeyboardVC.h"

@interface SPDateKeyboardVC ()

@end

@implementation SPDateKeyboardVC

- (void)initWithView:(UIView *)view {
    [view addSubview:self.view];
    
    CGRect dateFrame = self.view.frame;
    dateFrame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
    self.view.frame = dateFrame;
    self.dateKeyboardHidden = YES;

    self.datePicker.maximumDate = [NSDate date];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    CGRect frame = self.view.frame;
//    frame.size = CGSizeMake(320, 265);
//    self.view.frame = frame;
//}

- (void)hiddenPicker {
    CGRect frameRect = self.view.superview.frame;
    frameRect.origin = CGPointMake(0, frameRect.origin.y + frameRect.size.height);
    frameRect.size.height = 200;

    [UIView animateWithDuration:0.25f animations:^{
        self.view.frame = frameRect;
    } completion:^(BOOL finished) {
        self.dateKeyboardHidden = YES;
    }];
}

- (void)showPicker {
    CGRect frameRect = self.view.superview.frame;
    frameRect.origin = CGPointMake(0, frameRect.size.height - 200);
    frameRect.size.height = 200;
    
    NSDate *minDate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitYear value: - 16 toDate:[NSDate date] options:0];
    minDate = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value: - 1 toDate:minDate options:0];

    self.datePicker.date = minDate;
//    self.datePicker.maximumDate = minDate;
    
    [UIView animateWithDuration:0.25f animations:^{
        self.view.frame = frameRect;
    } completion:^(BOOL finished) {
        self.dateKeyboardHidden = NO;
    }];
}

@end

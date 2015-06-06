//
//  ViewController.h
//  ProcessingTouches
//
//  Created by Jack Lapin on 30.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *square;
@property (strong, nonatomic) IBOutlet UILabel *touchesBeganX;
@property (strong, nonatomic) IBOutlet UILabel *touchesBeganY;
@property (strong, nonatomic) IBOutlet UILabel *touchesMovedX;
@property (strong, nonatomic) IBOutlet UILabel *touchesMovedY;
@property (strong, nonatomic) IBOutlet UILabel *touchesEndedX;
@property (strong, nonatomic) IBOutlet UILabel *touchesEndedY;
@property (strong, nonatomic) IBOutlet UILabel *contactCount;
@property (strong, nonatomic) IBOutlet UILabel *touchesCount;

@property (strong, nonatomic) IBOutlet UILabel *swipeInfo;

- (CGFloat)angleBetweenLinesInRadians:(CGPoint)line1Start
                             line1End:(CGPoint)line1End
                           line2Start:(CGPoint)line2Start
                             line2End:(CGPoint)line2End;

@end


//
//  ViewController.m
//  ProcessingTouches
//
//  Created by Jack Lapin on 30.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize square;
@synthesize touchesBeganX;
@synthesize touchesBeganY;
@synthesize touchesMovedX;
@synthesize touchesMovedY;
@synthesize touchesEndedX;
@synthesize touchesEndedY;
@synthesize contactCount;
@synthesize touchesCount;
@synthesize swipeInfo;

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.square = nil;
    self.touchesBeganX = nil;
    self.touchesBeganY = nil;
    self.touchesMovedX = nil;
    self.touchesMovedY = nil;
    self.touchesEndedX = nil;
    self.touchesEndedY = nil;
    self.contactCount = nil;
    self.touchesCount = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    square.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(didSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(didSwipe:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(didSwipe:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

-(void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        swipeInfo.text = @"Left";
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        swipeInfo.text = @"Right";
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        swipeInfo.text = @"Up";
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        swipeInfo.text = @"Down";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    contactCount.text = [NSString stringWithFormat:@"%lu", (unsigned long)allTouches.count];
    
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    touchesCount.text = [NSString stringWithFormat:@"%lu", (unsigned long)touch.tapCount];
    
    CGPoint touchLocation = [touch locationInView:self.view];
    
    touchesBeganX.text = [NSString stringWithFormat:@"%.0f", touchLocation.x];
    touchesBeganY.text = [NSString stringWithFormat:@"%.0f", touchLocation.y];
    
    if (touch.view == square) {
        square.center = touchLocation;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    touchesMovedX.text = [NSString stringWithFormat:@"%.0f", touchLocation.x];
    touchesMovedY.text = [NSString stringWithFormat:@"%.0f", touchLocation.y];


    if (allTouches.count == 1 && touch.view == square) {
        
        square.center = touchLocation;

        
    } else if (allTouches.count == 2) {
        NSArray *twoTouches = [allTouches allObjects];
        UITouch *first = [twoTouches objectAtIndex:0];
        UITouch *second = [twoTouches objectAtIndex:1];
        
        CGFloat currentAngle = [self angleBetweenLinesInRadians:[first previousLocationInView:self.view]
                                                       line1End:[second previousLocationInView:self.view]
                                                     line2Start:[first locationInView:self.view]
                                                       line2End:[second locationInView:self.view]];
        
        square.transform = CGAffineTransformRotate(square.transform, currentAngle);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    touchesEndedX.text = [NSString stringWithFormat:@"%.0f", touchLocation.x];
    touchesEndedY.text = [NSString stringWithFormat:@"%.0f", touchLocation.y];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
}

- (CGFloat)angleBetweenLinesInRadians:(CGPoint)line1Start
                             line1End:(CGPoint)line1End
                           line2Start:(CGPoint)line2Start
                             line2End:(CGPoint)line2End
{
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    
    CGFloat line1Slope = (line1End.y - line1Start.y) / (line1End.x - line1Start.x);
    CGFloat line2Slope = (line2End.y - line2Start.y) / (line2End.x - line2Start.x);
    
    CGFloat degs = acosf(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
    
    
    return (line2Slope > line1Slope) ? degs : -degs;
}

@end

//
//  ViewController.m
//  FirstGame
//
//  Created by Jack Lapin on 30.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

{
    float allWidth;
    float allHeight;
    CGPoint ballS;
    CGPoint startPos;
    int playerGols;
    int botGols;
}

@end



@implementation ViewController

@synthesize ballImageView;
@synthesize botImageView;
@synthesize stickImageView;
@synthesize timer;


- (void)viewDidLoad {
    [super viewDidLoad];
    playerGols = 0;
    botGols = 0;
    allHeight = self.view.bounds.size.height;
    allWidth = self.view.bounds.size.width;
    ballS = BallSpeed;
    startPos = ballImageView.center;
    stickImageView.userInteractionEnabled = YES;
    self.playerGol.text = [NSString stringWithFormat:@"%d",0];
    self.botGol.text = [NSString stringWithFormat:@"%d",0];
    self.winner.hidden = YES;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02f
                                                  target:self
                                                selector:@selector(tick)
                                                userInfo:nil
                                                 repeats:YES];
}

- (IBAction)stopTimer {
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
}

- (IBAction)startButtonPressed:(UIButton *)sender {
    
    [self startTimer];
    self.startButton.hidden = TRUE;
    self.winner.hidden = YES;
    self.playerGol.text = [NSString stringWithFormat:@"%d",0];
    self.botGol.text = [NSString stringWithFormat:@"%d",0];
}

- (void)tick {
    BOOL directionDown;
    
    ballImageView.center = CGPointMake(ballImageView.center.x + ballS.x, ballImageView.center.y + ballS.y);
    
    if ((ballImageView.center.x + ballImageView.bounds.size.width/2) >= allWidth || (ballImageView.center.x - ballImageView.bounds.size.width/2) <=0 ) {
        ballS.x = -ballS.x;
    }
    
    if ((ballImageView.center.y + ballImageView.bounds.size.width/2) >= (stickImageView.center.y - stickImageView.bounds.size.height/2)
        &&
        (ballImageView.center.x + ballImageView.bounds.size.width/2) <= (stickImageView.center.x + stickImageView.bounds.size.width/2)
        &&
        (ballImageView.center.x + ballImageView.bounds.size.width/2) >= (stickImageView.center.x - stickImageView.bounds.size.width/2)
        )
        
    {
        ballS.y = -ballS.y;
    }
    
    if ((ballImageView.center.y - ballImageView.bounds.size.width/2) <= (botImageView.center.y + botImageView.bounds.size.height/2)
        &&
        (ballImageView.center.x + ballImageView.bounds.size.width/2) <= (botImageView.center.x + botImageView.bounds.size.width/2)
        &&
        (ballImageView.center.x + ballImageView.bounds.size.width/2) >= (botImageView.center.x - botImageView.bounds.size.width/2)
        )
        
    {
        ballS.y = -ballS.y;
    }
    
    if (ballS.y > 0){
        directionDown = TRUE;
    }
    else {
        directionDown = FALSE;
    }
    
    
    if(ballImageView.center.y <= self.view.center.y) {
        if(ballImageView.center.x < botImageView.center.x) {
            if (botImageView.center.x - botImageView.frame.size.width/2 >= 0) {
                CGPoint compLocation = CGPointMake(botImageView.center.x - BotSpeed, botImageView.center.y);
                botImageView.center = compLocation;
            }
        }
        
        if(ballImageView.center.x > botImageView.center.x) {
            if (botImageView.center.x + botImageView.frame.size.width/2 + BotSpeed <= allWidth) {
                CGPoint compLocation = CGPointMake(botImageView.center.x + BotSpeed, botImageView.center.y);
                botImageView.center = compLocation;
            }
        }
    }
    
    if (!directionDown && ballImageView.center.y <= allHeight/2)  {
        self.autoBot.hidden = NO;
    }
    else {
        self.autoBot.hidden = YES;
    }
    
    
    if (ballImageView.center.y > allHeight){
        botGols++;
        ballImageView.center = startPos;
        self.botGol.text = [NSString stringWithFormat:@"%d",botGols];
    }
    if ( ballImageView.center.y < 0){
        ballImageView.center = startPos;
        playerGols++;
        self.playerGol.text = [NSString stringWithFormat:@"%d",playerGols];
    }
    
    if (botGols ==endScore || playerGols == endScore) {
        [self stopTimer];
        self.startButton.hidden = false;
        if (botGols == endScore) { self.winner.hidden = NO; self.winner.text = @"BOT WINS!!";}
        if (playerGols == endScore) { self.winner.hidden = NO; self.winner.text = @"YOU WIN!!";}
        botGols = 0;
        playerGols = 0;
        
    }
    
}

//- (CGPoint) setpos :(UIImageView*) imgView : center (CGPoint) center{
//    CGPoint pos = CGPointMake(0, 0);
//    return pos;
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self.view];
    if (touch.view == stickImageView) {
        //  stickImageView.center = CGPointMake(touchLocation.x, stickImageView.center.y);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self.view];
    //&& touch.view == stickImageView
    if (allTouches.count == 1 ) {
        if (touchLocation.x - stickImageView.frame.size.width/2 - 0.5  > 0  &&  touchLocation.x + stickImageView.frame.size.width/2  < allWidth) {
            stickImageView.center = CGPointMake(touchLocation.x, stickImageView.center.y);
            
        }
        
    }
}
@end

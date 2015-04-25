//
//  TimerVC.m
//  Students
//
//  Created by Jack Lapin on 22.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "TimerVC.h"


@interface TimerVC ()



@end

@implementation TimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startTimer];
    
    // Do any additional setup after loading the view.
}

- (IBAction)startTimer {
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                    target:self
                                                  selector:@selector(animateSlider)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (IBAction)stopTimer {
    if ([self.myTimer isValid]) {
        [self.myTimer invalidate];
    }
}

- (void)tick {
    NSLog(@"Time tick");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void) animateSlider{
    [self.mySlider1 setMaximumValue:100];
    int rand = arc4random() % 100;
    [UIView animateWithDuration:3 animations:^{
        [self.mySlider1 setValue:rand animated:YES];
    } completion:^(BOOL finished) {
        
    }];

    [self.mySlider2 setMaximumValue:60];
    rand = arc4random() % 60;
    [UIView animateWithDuration:3 animations:^{
        [self.mySlider2 setValue:rand animated:YES];
    } completion:^(BOOL finished) {
        
    }];
    
    [self.mySlider3 setMaximumValue:30];
    rand = arc4random() % 30;
    [UIView animateWithDuration:3 animations:^{
        [self.mySlider3 setValue:rand animated:YES];
    } completion:^(BOOL finished) {
        
    }];

 
    [self.mySlider4 setMaximumValue:20];
    rand = arc4random() % 20;
    [UIView animateWithDuration:3 animations:^{
        [self.mySlider4 setValue:rand animated:YES];
    } completion:^(BOOL finished) {
        
    }];
    
    [self.mySlider5 setMaximumValue:40];
    rand = arc4random() % 40;
    [UIView animateWithDuration:3 animations:^{
        [self.mySlider5 setValue:rand animated:YES];
    } completion:^(BOOL finished) {
        
    }];


}
- (IBAction)stertButtonPress:(id)sender {
    if ([self.myTimer isValid])
    {
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self stopTimer];
    }
    else
    {
        [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self startTimer];
    }
}

- (IBAction)moveBack:(id)sender {
    [self stopTimer];
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end

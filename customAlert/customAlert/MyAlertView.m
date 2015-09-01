//
//  MyAlertView.m
//
//
//  Created by Jack Lapin on 06.06.15.
//
//

#import "MyAlertView.h"

@implementation MyAlertView

+ (MyAlertView *)initWithXib : (UIView*) view {
    
    
    MyAlertView *alert = [MyAlertView new];
    alert = [[[NSBundle mainBundle] loadNibNamed:@"alert" owner:self options:nil] objectAtIndex:0];
    [alert setFrame:view.frame];
    alert.alertBackround.layer.masksToBounds = YES;
    alert.alertBackround.layer.cornerRadius = 10;
    
    return alert;
}


-(void)smoothAlpha:(float) alpha delay: (float)secs option:(UIViewAnimationOptions)option {
    
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.alpha =alpha;
                     }
                     completion:nil];
}

- (IBAction)doCancelAlert:(UIButton *)sender {
    [self close];
}

- (IBAction)doOkButton:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getEnteredText" object:self];
    [self close];
}

- (void)close {
    [self smoothAlpha:0 delay:0.5 option:0];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

//
//  MyAlertView.m
//  
//
//  Created by Jack Lapin on 06.06.15.
//
//

#import "MyAlertView.h"

@implementation MyAlertView

+ (MyAlertView *)initWithXib {
    MyAlertView *alert = [[[NSBundle mainBundle] loadNibNamed:@"alert" owner:self options:nil] objectAtIndex:0];
    
    return alert;
}

/* 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

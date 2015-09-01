//
//  MyAlertView.h
//  
//
//  Created by Jack Lapin on 06.06.15.
//
//

#import <UIKit/UIKit.h>

@interface MyAlertView : UIView

@property (weak)  IBOutlet UILabel * title;
@property (weak)  IBOutlet UIButton * buttonOk;
@property (weak)  IBOutlet UIButton * buttonCancel;
@property (weak)  IBOutlet UITextField * text;
@property (weak, nonatomic) IBOutlet UIView *alertBackround;


+ (MyAlertView *)initWithXib : (UIView*) view;

-(void)smoothAlpha:(float) alpha delay: (float)secs option:(UIViewAnimationOptions)option;

- (IBAction)doCancelAlert:(UIButton *)sender;
- (IBAction)doOkButton:(UIButton *)sender;

@end

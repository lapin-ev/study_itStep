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


+ (MyAlertView *)initWithXib;

@end

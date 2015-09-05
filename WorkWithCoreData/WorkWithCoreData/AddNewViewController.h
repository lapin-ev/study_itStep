//
//  AddNewViewController.h
//  WorkWithCoreData
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UISwitch *genderType;
@property (weak, nonatomic) IBOutlet UITextField *dtofBirthtextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIToolbar *accessoryToolBar;
@property (weak, nonatomic) IBOutlet UILabel *GenderDescription;
- (IBAction)datePickerValueChange:(id)sender;

- (IBAction)donePressed:(UIBarButtonItem *)sender;

- (IBAction)changeGender:(id)sender;
- (IBAction)editingDidFinished:(id)sender;
@end

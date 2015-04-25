//
//  ViewController2.h
//  Students
//
//  Created by Jack Lapin on 14.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEStudent.h"

@protocol VC2Delegate
 
- (void) changeObjectAtIndex : (NSInteger)index andArrayType :(BOOL) arayType andObject:(LEStudent*) stu;
- (void) addObjectInArray : (LEStudent*)stu andArrayType :(BOOL) arayType;
- (void) changedSex : (NSInteger) index isMale:(BOOL) isMale object :(LEStudent*)stu;


@end

@interface ViewController2 : UIViewController <UITextFieldDelegate>

@property (nonatomic) LEStudent * stu;
@property (weak, nonatomic) IBOutlet UITextField *stuName;
@property (weak, nonatomic) IBOutlet UITextField *stuLastName;
@property (weak, nonatomic) IBOutlet UITextField *stuSex;
@property (weak, nonatomic) IBOutlet UITextField *stuAge;
@property (weak, nonatomic) IBOutlet UITextField *stuInterests;
@property (weak, nonatomic) IBOutlet UIImageView *stuPhoto;
@property (weak, nonatomic) IBOutlet UIPickerView *yearOfBirthPicker;

@property (nonatomic, weak) id <VC2Delegate> myDelegate;
@property (weak, nonatomic) IBOutlet UISwitch *isMaleSwitch;

@property NSInteger index;

@property BOOL isMale;
@property BOOL isAdd;
@property BOOL isSexChanged;


@property (nonatomic) IBOutlet UIButton *saveButton;


- (IBAction)touchFunnySlidersButton:(id)sender;

- (IBAction)isMaleSwitchChanged:(id)sender;

- (IBAction)Done:(UIBarButtonItem *)sender;
- (IBAction)TouchRandomItems:(id)sender;


- (IBAction)saveStudent:(id)sender;



@end

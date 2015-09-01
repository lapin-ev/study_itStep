//
//  AddContactControllerViewController.h
//  CamApp
//
//  Created by Jack Lapin on 28.08.15.
//  Copyright © 2015 student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddContactViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *surname;
@property (weak, nonatomic) IBOutlet UITextField *email;


@property (weak, nonatomic) IBOutlet UITextField *phoneNumberMobile;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberWork;
@end

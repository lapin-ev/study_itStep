//
//  SPRegistrationVC.m
//  SocketProject
//
//  Created by Genrih Korenujenko on 07.10.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import "SPRegistrationVC.h"

@interface SPRegistrationVC () <UITextFieldDelegate>

@end

@implementation SPRegistrationVC {
    IBOutlet UITextField *nameTF, *emailTF, *passwordTF, *birthdayTF;
    
    SPDateKeyboardVC *dateKeyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dateKeyboard = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SPDateKeyboardVC class])];
    [dateKeyboard initWithView:self.view];
    
    [dateKeyboard.doneButton addTarget:self action:@selector(dateSelected) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)backButtonPress:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)createAccountButtonPress:(UIButton *)sender {
    [self hideDatePicker];
    [self.view endEditing:YES];
    
    NSString *text = [self isValidEmail:emailTF.text] ? [self isValidEmail:emailTF.text] : [self isValidPassword:passwordTF.text];
    if (!text) {
        text = [self isValidPassword:passwordTF.text];
    }
    if (text) {
        [self showAlertWithText:text];
    } else {
        [self createAccount];
    }
}

- (void)createAccount {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *language = @"1";
    NSString *user_token = getDeviceToken;
    NSString *user_birthday = [NSString stringWithFormat:@"%lli", (long long int)[dateKeyboard.datePicker.date timeIntervalSince1970]];
    
    NSDictionary *params = @{@"user_name" : nameTF.text, @"user_email" : emailTF.text, @"user_password" : passwordTF.text, @"user_token" : user_token, @"user_birthday": user_birthday, @"language" : language};
    
    [manager POST:[NSString stringWithFormat:@"%@%@", urlServer, registrationPath] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        PARSINGANSWER(operation.responseData, @"message");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *errorText = GETTEXTERROR(operation.responseData);
        [self showAlertWithText:errorText];
    }];
}

- (void)showAlertWithText:(NSString *)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Внимание!" message:text delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles: nil];
    [alert show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:birthdayTF]) {
        [self.view endEditing:YES];
        [self showDateKeyboard];
        return NO;
    } else {
        [self hideDatePicker];
        return YES;
    }
}

- (void)dateSelected {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd.MM.yyyy";
    NSString *dateString = [dateFormatter stringFromDate:dateKeyboard.datePicker.date];
    birthdayTF.text = dateString;
    [self hideDatePicker];
}

- (void)hideDatePicker {
    if (!dateKeyboard.dateKeyboardHidden) {
        [dateKeyboard hiddenPicker];
    }
}

- (void)showDateKeyboard {
    if (dateKeyboard.dateKeyboardHidden) {
        [dateKeyboard showPicker];
    }
}

@end

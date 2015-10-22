//
//  SPLoginVC.m
//  SocketProject
//
//  Created by Genrih Korenujenko on 07.10.15.
//  Copyright © 2015 Genrih Korenujenko. All rights reserved.
//

#import "SPLoginVC.h"

@interface SPLoginVC () <UITextFieldDelegate>

@end

@implementation SPLoginVC {
    IBOutlet UITextField *emailTF, *passwordTF;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)showAlertWithText:(NSString *)text {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Внимание!" message:text delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)loginButtonPress:(UIButton *)sender {
    NSString *text = [self isValidEmail:emailTF.text] ? [self isValidEmail:emailTF.text] : [self isValidPassword:passwordTF.text];
    if (!text) {
        text = [self isValidPassword:passwordTF.text];
    }
    if (text) {
        [self showAlertWithText:text];
    } else {
        [self login];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)login {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *user_token = getDeviceToken;
    
    NSDictionary *params = @{@"user_email" : emailTF.text, @"user_password" : passwordTF.text, @"user_token" : user_token};
    
    [manager POST:[NSString stringWithFormat:@"%@%@", urlServer, loginPath] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        PARSINGANSWER(operation.responseData, @"message");
        
        NSString *user_id = [responseObject valueForKey:@"user_id"];
        NSString *user_session_hash = [responseObject valueForKey:@"user_session_hash"];
        
        if (user_id && user_session_hash) {
            [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:keyUser_id];
            [[NSUserDefaults standardUserDefaults] setObject:user_session_hash forKey:keyUser_session_hash];
        }
        emailTF.text = @"";
        passwordTF.text = @"";
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *errorText = GETTEXTERROR(operation.responseData);
        [self showAlertWithText:errorText];
    }];
}

@end

//
//  DDAddCharacterController.m
//  Cartoons
//
//  Created by Dmitriy Demchenko on 8/24/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "DDAddCharacterController.h"
#import "DDCharacterFactory.h"
#import "DDDataManager.h"
#import "NSString+Validations.h"

@interface DDAddCharacterController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end


@implementation DDAddCharacterController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"";
    
    CAGradientLayer *gradient = [DDSerialConstructor gradientForFrame:self.view.frame fromColor:[DDSerialConstructor appYellowColor] toColor:[UIColor whiteColor]];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    self.textField.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Private methods

-(void)dismissKeyboard {
    [self.textField resignFirstResponder];
}

#pragma mark - Actions

- (IBAction)saveItemAction:(id)sender {
    
    NSError *error = NULL;
    
    if ([self.textField.text isValidModelWithError:&error]) {
        
        NSString *name = ([self.textField.text isEqualToString:@"New Character"]) ? [NSString stringWithFormat: @"%@ (%@)", self.textField.text, [NSString stringWithDate:[NSDate date]]]  : self.textField.text;
        
        [DDDataManager addCharacter:[DDCharacterFactory modelWithName:name]];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
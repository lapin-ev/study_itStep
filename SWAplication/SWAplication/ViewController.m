//
//  ViewController.m
//  SWAplication
//
//  Created by Jack Lapin on 05.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"

//static int count = 0;

@interface ViewController () <UITextFieldDelegate>
{
    NSArray * myArray;

}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.enteredText.delegate = self;
    
    self.myLabel.text = @"My test text";
    
    [self.myButton setTitle:@"Search" forState:UIControlStateDisabled];
    self.myButton.enabled = FALSE;
    
    myArray = [NSArray arrayWithObjects:@"one", @"two", @"three", @"four", @"five" , nil];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.enteredText resignFirstResponder];
    [self tochUpInside:self];
    return YES;
}

- (IBAction)tochUpInside:(id)sender
{
//    if (count == myArray.count)
//    {
//        count = 0;
//    }
//    self.myLabel.text = myArray[count];
//    count++;
    
    NSString * serchText = self.enteredText.text;
    if ([serchText isEqualToString:@""])
    {
        self.myLabel.text = @"Enter text";
        return;
    }
    for (int i = 0; i<myArray.count; i++)
    {
        if ([ serchText isEqualToString:myArray[i]])
        {
            self.myLabel.text = @"Got found!";
            return;
        }
        else
        {
            self.myLabel.text = @"Not found ((";
        }
    }
    
    
    
}

- (IBAction)finishEntering:(id)sender {
    
}

- (IBAction)startEditing:(id)sender {
    
}

- (IBAction)ValueChanged:(id)sender {
 
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *newString = [textField.text mutableCopy];
    [newString appendString:string];
    
    if (string.length == 0 && newString.length ==1)
    {
        self.myButton.enabled = FALSE;
        return YES;
   
    }
    else
    {
        self.myButton.enabled = YES;
    }
    
    return YES;
}

@end

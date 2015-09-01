//
//  ViewController.m
//  customAlert
//
//  Created by Jack Lapin on 06.06.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#import "VC2.h"
#import "MyAlertView.h"

@interface ViewController () <UINavigationControllerDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getEnteredText)
                                                 name:@"getEnteredText"
                                               object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forwardButtonPress:(UIBarButtonItem *)sender {
   VC2 *detailObject = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2"];
   [self.navigationController pushViewController:detailObject animated:YES];
}

- (IBAction)showAlert:(UIButton *)sender {
    
    if (!self.myAlert) {
        self.myAlert = [MyAlertView initWithXib : self.view];
        
        [self.navigationController.view addSubview:self.myAlert];
        [self.myAlert smoothAlpha:1 delay:0.5 option:0];


    } else {
        [self.myAlert smoothAlpha:1 delay:1 option:0];
    }
}

-(void) getEnteredText {
 
    
    self.labelEnteredText.text = self.myAlert.text.text;
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getEnteredText" object:nil];
}

@end

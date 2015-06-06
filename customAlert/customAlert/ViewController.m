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

@property MyAlertView *myAlert;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forwardButtonPress:(UIBarButtonItem *)sender {
    
   VC2 *detailObject = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2"];
//    
//    detailObject.albumName = [[tableView cellForRowAtIndexPath:indexPath] textLabel].text;
//    //    [self presentViewController:detailObject animated:YES completion:nil];
   [self.navigationController pushViewController:detailObject animated:YES];
}

- (IBAction)showAlert:(UIButton *)sender {
    self.myAlert = [MyAlertView initWithXib];
    [self.view addSubview:self.myAlert];
}
@end

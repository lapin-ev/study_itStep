//
//  VCWithRandomItems.m
//  Students
//
//  Created by Jack Lapin on 24.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "VCWithRandomItems.h"

@interface VCWithRandomItems ()

@end

@implementation VCWithRandomItems

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel* myLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 110, self.view.frame.size.height - 60, 100, 50)];
    myLabel.text = @"Cool!";
    myLabel.textColor = [UIColor greenColor];
    [self.view addSubview:myLabel];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

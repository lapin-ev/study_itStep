//
//  ViewController.m
//  Students
//
//  Created by Jack Lapin on 10.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#import "LEStudent.h"

@interface ViewController ()

{

 NSMutableArray* arrayOfStudents;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    arrayOfStudents = [[NSMutableArray alloc] init];
    
    for (int i=0; i<5; i++)
    {
        // name = @"Name"
        LEStudent* stud1 = [LEStudent initWith:([NSString stringWithFormat:@"Name%i",i]) andSurname:[NSString stringWithFormat:@"Surname%i",i]];
        [stud1 setAge:[NSNumber numberWithInt:(24+i)]];
        NSString * interest = [NSString stringWithFormat:@"Interest%i",i];
        [stud1 setInterests:interest];
        [arrayOfStudents addObject:stud1];
    }
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

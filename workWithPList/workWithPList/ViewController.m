//
//  ViewController.m
//  workWithPList
//
//  Created by Jack Lapin on 29.08.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#import "myObject.h"
#import <objc/runtime.h>
#import "NSObject+myMethods.h" 


@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
   myObject * obj = [myObject new];
//    obj.stu = @"Checking faces";
//    
//    
//    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"myPrepertyList.plist" ofType:nil];
    
    NSMutableDictionary * propDict = [NSDictionary dictionaryWithContentsOfFile:path].mutableCopy;
    NSMutableDictionary * myClassPropDict = [[propDict objectForKey:@"myObject"] mutableCopy];
    
    
//
//    NSMutableArray * arrOfTrees = [[propDict valueForKey:@"trees"] mutableCopy];
//    
//    [arrOfTrees addObject:@"pine"];
//    
//    [propDict setValue:arrOfTrees forKey:@"trees"];
//    [propDict setValue:obj forKey:@"stu"];
//    
//    NSData *propData = [NSKeyedArchiver archivedDataWithRootObject:propDict];
//    
//    
//    
    
    // NSString * desktopPath = @"/Users/Athey/Desktop/";
    
  //  NSString * s = [NSString stringWithFormat:@"%@/myPrepertyList.plist", [self applicationDocumentsDirectory]];
  //  NSDictionary *d = [NSKeyedUnarchiver unarchiveObjectWithFile:s];
    
    
    
    
    [obj setObjectWithDictionary:myClassPropDict];

    
//    NSDictionary *d = [[NSDictionary alloc] in]
//  
//    [propData writeToFile:s atomically:YES];
//    
    
    NSLog(@"%@",[obj description]);
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSLog(@"%@", s);
}

- (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = paths.firstObject;
    return basePath;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

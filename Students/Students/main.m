//
//  main.m
//  Students
//
//  Created by Jack Lapin on 10.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {

        
//        NSDictionary * myDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Student1",@"stu1",@"Student2",@"stu2", nil];
        
//        NSLog(@"%@", myDictionary);
//        
//        NSLog(@"%@", [myDictionary valueForKey:@"stu1"]);
        
        NSMutableDictionary * myMutDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Student1",@"stu1",@"Student2",@"stu2",nil];
        
        [myMutDict setObject:@"Student3" forKey:@"stu3"];
        
//        NSLog(@"%@", myMutDict);

//        NSArray *girls = [NSArray arrayWithObjects:@"Amanda", @"Ira", @"Natali", nil];
//        NSArray *boys = [NSArray arrayWithObjects:@"Sergei", @"Vova", @"Ivan", nil];
//        NSDictionary *children = [NSDictionary dictionaryWithObjectsAndKeys:girls, @"girls",
//                                  boys, @"boys", nil];
//
//        NSLog(@"girls: %@", [children objectForKey:@"girls"]);
//        NSLog(@"boys: %@", [children objectForKey:@"boys"]);
//
//        NSArray * allKeys = [myMutDict allKeys];
//        NSLog(@"%@",allKeys);
//        
//        for (NSString * key in allKeys)
//        {
//            NSLog(@"%@", [myMutDict valueForKey:key]);
//        }
//        
//        NSDictionary * d1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Zorro",@"name",nil];
//        NSDictionary * d2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Igor",@"name",nil];
//        
//        NSArray * dd12 = [NSArray arrayWithObjects:d1,d2, nil];
//        
//        NSLog(@"%@",dd12);
//        
//        NSSortDescriptor * sortDisctiptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:true];
//        
//        NSArray * sortedArray = [dd12 sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDisctiptor]];
//        NSLog(@"%@",sortedArray);
//        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    
    
}

//
//  main.m
//  CollectionView
//
//  Created by Jack Lapin on 16.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
 
    NSArray *stringsArray = [NSArray arrayWithObjects:
                             @"1",
                             @"3",
                             @"f",
                             @"a",
                             @"9", nil];
    
    NSComparator finderSortBlock = ^(id string1, id string2) {
        return [string1 compare:string2];
    };
    
    NSArray *finderSortArray = [stringsArray sortedArrayUsingComparator:finderSortBlock];
    NSLog(@"finderSortArray: %@", finderSortArray);
    

    int multiplier = 7;
    NSString * (^myBlock)(NSString*, int, NSData*) = ^(NSString * num, int num2, NSData* data) {
        return [NSString stringWithFormat:@"%i", num.intValue * multiplier];
    };
    
    NSLog(@"%@", myBlock(@"3",0,nil));
    
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        
    }
}

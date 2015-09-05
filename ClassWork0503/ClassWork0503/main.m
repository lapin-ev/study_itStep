//
//  main.m
//  ClassWork0503
//
//  Created by Jack Lapin on 05.03.15.
//  Copyright (c) 2015 JackLapin. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char *argv[])
{
    NSMutableArray *myArray = [[NSMutableArray alloc] init];

    for (int i = 0; i < 10; i++)
    {
        NSString *myString;
        myString = [NSString stringWithFormat:@"%d", i];
        [myArray addObject:myString];

    }
    NSLog(@"Object %@", myArray);
    return 0;
}
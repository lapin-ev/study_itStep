//
//  main.m
//  TestMeeting_with_new_teacher
//
//  Created by Jack Lapin on 22.01.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScaleConvert.h"
#import "SayNumbers.h"


int main(int argc, const char *argv[])
{
    @autoreleasepool
    {
        int scale = 16;
        int inputDecNum = 590;

        NSString * finalString;

        ScaleConvert *myConvertor = [[ScaleConvert alloc] init];
        SayNumbers * mySay = [[SayNumbers alloc]init];

        [myConvertor decimalToScale:scale fromValue:inputDecNum];

        finalString = [myConvertor convertedWithType];

        NSLog(@"%@", finalString);

        finalString = [mySay replaceNumWithWords:finalString];


        NSLog(@"%@", finalString);

    }

    return 0;
}

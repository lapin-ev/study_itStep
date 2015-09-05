//
//  main.m
//  convert_number
//
//  Created by Gregory Tkach on 1/22/15.
//  Copyright (c) 2015 Gregory Tkach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConverterBase.h"
#import "ConverterDecimalToBin.h"

int main(int argc, const char *argv[])
{
    ConverterBase *converter = [[ConverterDecimalToBin alloc] init];

    NSString *humanReadable = [converter toHumanReadable:ERT_2 value:123];

    NSLog(@"%@", humanReadable);

    @autoreleasepool
    {
        // insert code here...
    }

    return 0;
}
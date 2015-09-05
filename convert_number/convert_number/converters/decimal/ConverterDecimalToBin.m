//
// Created by Gregory Tkach on 1/22/15.
// Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "ConverterDecimalToBin.h"


@implementation ConverterDecimalToBin
{

}
- (EConverterType)getType
{
    return ECT_DECIMAL;
}


- (NSString *)toHumanReadable:(EResultType)resultType value:(int)value
{
    NSString *result = @"";

    switch (resultType)
    {
        case ERT_2:
        {
            result = [self toBin:value];

            result = [self reverseString:result];

            break;
        };
        default:
        {
            NSAssert(false, @"please override");
            break;
        }
    }

    result = [self numberStringToHumanString:result];

    return result;
}

- (NSString *)numberStringToHumanString:(NSString *)value
{
    NSString *result = nil;

    NSMutableArray *array = [NSMutableArray array];

    for (NSUInteger i = 0; i < [value length]; i++)
    {
        NSString *currentChar = [value substringWithRange:NSMakeRange(i, 1)];

        NSString *word = [self fromNumberToWord:currentChar];

        [array addObject:word];
    }

    result = [array componentsJoinedByString:@" "];

    return result;
}


- (NSString *)toBin:(int)value
{
    NSString *result = nil;

    if (value == 0)
    {
        //the end
        result = @"0";
    }
    else if (value == 1)
    {
        result = @"1";
    }
    else
    {
        result = [NSString stringWithFormat:@"%d", value % 2];

        int restValue = value / 2;

        NSString *restValueString = [self toBin:restValue];

        result = [result stringByAppendingString:restValueString];
    }


    return result;
}


@end
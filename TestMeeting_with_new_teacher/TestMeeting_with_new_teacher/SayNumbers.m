//
// Created by Jack Lapin on 24.01.15.
// Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "SayNumbers.h"


@implementation SayNumbers


+ (NSString *)toText:(NSString *)symbol
{
    NSString *result;

    if ([symbol isEqualToString:@"1"])
    {
        result = @"one ";
    }
    else if ([symbol isEqualToString:@"2"])
    {
        result = @"two ";
    }
    else if ([symbol isEqualToString:@"3"])
    {
        result = @"tree ";
    }
    else if ([symbol isEqualToString:@"4"])
    {
        result = @"four ";
    }
    else if ([symbol isEqualToString:@"5"])
    {
        result = @"five ";
    }
    else if ([symbol isEqualToString:@"6"])
    {
        result = @"six ";
    }
    else if ([symbol isEqualToString:@"7"])
    {
        result = @"seven ";
    }
    else if ([symbol isEqualToString:@"8"])
    {
        result = @"eight ";
    }
    else if ([symbol isEqualToString:@"9"])
    {
        result = @"nine ";
    }
    else if ([symbol isEqualToString:@"0"])
    {
        result = @"zero ";
    }
    else if ([symbol isEqualToString:@"a"])
    {
        result = @"A ";
    }
    else if ([symbol isEqualToString:@"b"])
    {
        result = @"B ";
    }
    else if ([symbol isEqualToString:@"c"])
    {
        result = @"C ";
    }
    else if ([symbol isEqualToString:@"d"])
    {
        result = @"D ";
    }
    else if ([symbol isEqualToString:@"e"])
    {
        result = @"E ";
    }
    else
    {
        result = symbol;
    }
    return result;
}

- (NSString *)replaceNumWithWords:(NSString *)str
{
    NSString *result = @"";

    NSInteger l = [str length];
    NSString *stIn = @"";

    for (NSUInteger i = 0; i < l; i++)
    {
        stIn = [str substringWithRange:NSMakeRange(i, 1)];
        result = [result stringByAppendingString:[SayNumbers toText:stIn]];
    }

    return result;
}

@end
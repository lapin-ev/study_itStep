//
// Created by Gregory Tkach on 1/22/15.
// Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "ConverterBase.h"


@implementation ConverterBase
{

}

/*
 * Properties
 */

- (EConverterType)getType
{
    NSAssert(false, @"please override");
    return ECT_DECIMAL;
}

/*
 * Methods
 */


//! Default initializer
- (id)init
{
    self = [super init];

    if (self)
    {

    }

    return self;
}

- (NSString *)toHumanReadable:(EResultType)resultType value:(int)value
{
    NSAssert(false, @"please override");
    return nil;
}


- (NSString *)reverseString:(NSString *)value
{
    NSAssert(value != nil, @"value can't be nil");

    NSMutableString *result = [NSMutableString string];

    NSUInteger charIndex = [value length];

    while (charIndex > 0)
    {
        charIndex--;
        NSRange subRange = NSMakeRange(charIndex, 1);
        [result appendString:[value substringWithRange:subRange]];

    }

    return result;
}

- (NSString *)fromNumberToWord:(NSString*)value
{
    NSString *result = nil;

    if([value isEqual:@"0"])
    {
        result = @"zero";
    }
    else if([value isEqual:@"1"])
    {
        result = @"one";
    }
    else
    {
        NSAssert(false, @"unknown value");
    }

    return result;
}


@end
//
// Created by Jack Lapin on 24.01.15.
// Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ScaleConvert.h"

// todo: Make other type of scale convertion (ten + to 32) with maybe :  static  NSString * alphabet = @"ABCDEFG";

@implementation ScaleConvert
{
    NSString *_convertedWithType;
}

- (NSString *)convertedWithType
{
    return _convertedWithType;
}


- (NSString *) decimalToScale:(int)toScale fromValue:(int)fromValue
{
    NSString *result = @"";
    NSString *typeOfScale = @"";

    if (toScale < 10 && toScale > 1)
    {
        NSString *symbolFromNum = @"";

        int restOfDivision = 0;
        int resultOfDiv = 0;

        resultOfDiv = fromValue;

        while (resultOfDiv != 0)
        {
            restOfDivision = resultOfDiv % toScale;
            resultOfDiv = resultOfDiv / toScale;
            symbolFromNum = [NSString stringWithFormat:@"%d", restOfDivision];
            result = [symbolFromNum stringByAppendingString:result];
        }

        if (toScale == 2)
        {
            typeOfScale = @"BIN ";
        }
        else if (toScale == 8)
        {
            typeOfScale = @"OCT ";
        }
        else if (toScale == 10)
        {
            typeOfScale = @"DEC ";
        }
        else
        {
            typeOfScale = [NSString stringWithFormat:@"%d", toScale];
            typeOfScale = [typeOfScale stringByAppendingString:@"-X "];
        }
    }
    else if (toScale > 10 && toScale < 17)
    {
        if (toScale == 16)
        {
            result = [NSString stringWithFormat:@"%x", fromValue];
            typeOfScale = @"HEX ";
        }
        else
        {
            result = [NSString stringWithFormat:@"Convertion of %d scale is in developing", toScale];
            typeOfScale = @"UNT ";
        }
    }
    else
    {
        result = @"Parametr 'scale' can be only between 2 and 16";
    }

    result = [typeOfScale stringByAppendingString:result];

    _convertedWithType = result;

    return result;
}

@end
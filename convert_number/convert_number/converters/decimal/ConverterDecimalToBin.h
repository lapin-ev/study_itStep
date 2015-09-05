//
// Created by Gregory Tkach on 1/22/15.
// Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConverterBase.h"


@interface ConverterDecimalToBin : ConverterBase


/*
 * Properties
 */
- (EConverterType)getType;

/*
 * Methods
 */

- (NSString *)toHumanReadable:(EResultType)resultType value:(int)value;

@end
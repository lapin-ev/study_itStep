//
// Created by Gregory Tkach on 1/22/15.
// Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EConverterType.h"
#import "EResultType.h"


@interface ConverterBase : NSObject

/*
 * Properties
 */

- (EConverterType)getType;

/*
 * Events
 */

/*
 * Methods
 */

//! Default initializer
- (id)init;

- (NSString *)toHumanReadable:(EResultType)resultType value:(int)value;

/*
 * Internal methods
 */


//! Internal. Please do not use.
- (NSString *)reverseString:(NSString *)value;

//! Internal. Please do not use.
- (NSString *)fromNumberToWord:(NSString*)value;

@end
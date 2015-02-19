//
// Created by Jack Lapin on 24.01.15.
// Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SayNumbers : NSObject

+(NSString *)toText:(NSString * ) symbol;
-(NSString *) replaceNumWithWords:(NSString *) str;

@end
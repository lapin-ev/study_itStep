//
// Created by Jack Lapin on 24.01.15.
// Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScaleConvert : NSObject
{

}

-(NSString*)convertedWithType;

- (NSString *)decimalToScale:(int)toScale fromValue:(int)fromValue;

@end
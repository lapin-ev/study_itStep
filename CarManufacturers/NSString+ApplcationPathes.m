//
//  NSString+ApplcationPathes.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "NSString+ApplcationPathes.h"

@implementation NSString (ApplcationPathes)

+ (NSString *)resourcesFolderPath {
    return [[NSBundle mainBundle] pathForResource:@"CarManufacturers" ofType:@"plist"];
}

+ (NSString *)documentsFolderPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *resourceNameWithExtention = [[@"CarManufacturers" stringByAppendingString:@"."] stringByAppendingString:@"plist"];
    return [documentsDirectory stringByAppendingPathComponent:resourceNameWithExtention];
}

@end

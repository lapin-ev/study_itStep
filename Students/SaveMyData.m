//
//  SaveMyData.m
//  Students
//
//  Created by Jack Lapin on 19.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "SaveMyData.h"
#import "LEStudent.h"


@implementation SaveMyData

+ (void) saveMyArray : (NSMutableArray *) withArr forKey:(NSString*)key {
    NSData* userData = [NSKeyedArchiver archivedDataWithRootObject:withArr];
    
    [[NSUserDefaults standardUserDefaults]setObject:userData forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

+ (NSMutableArray *)loadMyArray:(NSString *)key{
    
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData* userData = [userDefault objectForKey:key];
    NSMutableArray* result = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    return result;
}

@end

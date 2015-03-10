//
//  LEStudent.m
//  Students
//
//  Created by Jack Lapin on 10.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "LEStudent.h"

@implementation LEStudent

-(void)setInterests:(NSString *)interests
{
    _interests = interests;
}
-(void) setAge:(NSNumber *)age
{
    _age = age;
    
}

+(LEStudent*) initWith : (NSString*) name andSurname : (NSString*)surname {
    
    LEStudent* newStudent = [[LEStudent alloc ]init];
    
    newStudent.name = name;
    newStudent.surname = surname;
    
    return newStudent;
}

@end

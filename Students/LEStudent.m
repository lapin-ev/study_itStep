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

-(void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.surname forKey:@"surname"];
    [encoder encodeObject:self.age forKey:@"age"];
    [encoder encodeObject:self.sex forKey:@"sex"];
    [encoder encodeObject:self.interests forKey:@"interests"];
    NSData * imageData =  UIImageJPEGRepresentation (self.photo, 100.0);
    [encoder encodeObject:imageData forKey:@"photo"];
    
}

-(id)initWithCoder:(NSCoder *)coder{
    if (self = [super init])
    {
        self.name = [coder decodeObjectForKey:@"name"];
        self.surname = [coder decodeObjectForKey:@"surname"];
        self.age = [coder decodeObjectForKey:@"age"];
        self.sex = [coder decodeObjectForKey:@"sex"];
        self.interests = [coder decodeObjectForKey:@"interests"];
        NSData * dataFromPhoto = [coder decodeObjectForKey:@"photo"];
        if (dataFromPhoto) {
            self.photo = [UIImage imageWithData:dataFromPhoto];
        }
        
    }
    
    return self;
}

+(LEStudent*) initWith : (NSString*) name andSurname : (NSString*)surname {
    
    LEStudent* newStudent = [[LEStudent alloc ]init];
    
    newStudent.name = name;
    newStudent.surname = surname;
    
    return newStudent;
}

@end

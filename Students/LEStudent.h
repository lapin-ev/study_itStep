//
//  LEStudent.h
//  Students
//
//  Created by Jack Lapin on 10.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    H_MALE ,
    H_FEMALE
    
} HumanSexType;

@interface LEStudent : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* surname;
@property (strong, nonatomic) NSString* interests;
@property (strong, nonatomic) NSNumber* age;

@property (nonatomic) NSNumber* sex;

@property (nonatomic) UIImage *photo;

+(LEStudent*) initWith : (NSString*) name andSurname : (NSString*)surname;

-(void) setAge:(NSNumber *)age;
-(void) setInterests:(NSString *)interests;

//-(void) encodedWithCoder:(NSCoder*)encoder;
//-(id) initWithCoder :(NSCoder*) coder;


@end

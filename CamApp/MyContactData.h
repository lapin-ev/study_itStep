//
//  MyContactData.h
//  CamApp
//
//  Created by student on 22.08.15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyContactData : NSObject

@property (weak, nonatomic) NSString *firstName;
@property (weak, nonatomic) NSString *LastName;
@property (weak, nonatomic) NSString *eMail;
@property (weak, nonatomic) NSString *phoneNumber;
@property  UIImage *ContactPhoto;


@end

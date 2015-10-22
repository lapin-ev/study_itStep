//
//  MClass.h
//  GetAllProperty
//
//  Created by Genrih Korenujenko on 03.08.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface MClass : NSObject

@property (nonatomic, readwrite) NSString *string1;
@property (nonatomic, readwrite) NSString *string2;

@property (nonatomic, readwrite) UILabel *label1;

@property (nonatomic, readwrite) UIImage *image1;

@property int i;

//+ (MClass *)sharedWithDic:(NSDictionary *)dictionary;

//- (void)setObjectsWithDicationary:(NSDictionary *)dictionary;



@end

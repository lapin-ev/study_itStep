//
//  LEWeatherInfo.h
//  JSONandMaps
//
//  Created by Jack Lapin on 26.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEWeatherInfo : NSObject

@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, assign) float temperature;
@property (nonatomic, strong) NSString * iconID;
@property (nonatomic, strong) NSString * itemDescription;
@property (nonatomic, assign) float windSpeed;

- (LEWeatherInfo *) initWithDictionary :(NSDictionary *) dictionary;

@end

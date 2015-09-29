//
//  LEWeatherInfo.m
//  JSONandMaps
//
//  Created by Jack Lapin on 26.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LEWeatherInfo.h"


@interface LEWeatherInfo (NSObject)

@end

@implementation LEWeatherInfo

- (LEWeatherInfo *) initWithDictionary :(NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.cityName = [dictionary objectForKey:@"name"];
        self.temperature = [[dictionary valueForKeyPath:@"main.temp"] floatValue];
        self.iconID = [dictionary valueForKeyPath:@"weather.icon"];
        self.itemDescription = [dictionary valueForKeyPath:@"weather.description"];
        self.windSpeed = [[dictionary valueForKeyPath:@"wind.speed"] floatValue];
    }
    return self;
}

@end

//
//  LECMFactory.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMFactory.h"
#import "CMconstants.h"

@implementation LECMFactory

+(LECMFactory*) modelFromDictionary : (NSDictionary*) dictionary {
    LECMFactory * model = [LECMFactory new];
    model.name = [dictionary objectForKey:kNameKey];
    model.imageName = [dictionary objectForKey:kImageNameKey];
    return model;
}


@end
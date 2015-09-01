//
//  LESong.h
//  workWithAudio
//
//  Created by Jack Lapin on 29.08.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LESong : NSObject

@property (nonatomic, readwrite) NSString *path;

@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *artist;
@property (nonatomic, readwrite) NSString *albumName;
@property BOOL image;

@end

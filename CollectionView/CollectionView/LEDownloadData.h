//
//  LEDownloadData.h
//  CollectionView
//
//  Created by Jack Lapin on 23.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LEDownloadDataDelegate

-(void) dowloadProgress : (float) loadedByte;
-(void) image:(UIImage*) img;

@end

@interface LEDownloadData : NSObject

@property (nonatomic, readwrite) id <LEDownloadDataDelegate> delegate;
@property NSMutableData * imageData;

-(void) dowloadImageWithURL : (NSURL * ) url;

@end

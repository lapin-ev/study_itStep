//
//  LEDownloadData.m
//  CollectionView
//
//  Created by Jack Lapin on 23.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "LEDownloadData.h"

@interface LEDownloadData ()  {
     

}

@end

@implementation LEDownloadData

- (void)dowloadImageWithURL:(NSURL *)url {
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest:theRequest delegate:self];
    
    if (theConnection) {
        self.imageData = [NSMutableData data];
    } else {
        NSLog(@"Connection failed");
    }

}

//-(void)loadImageInBackground:(NSURL*)url {
//    NSData *imageData = [NSData dataWithContentsOfURL:url];
//    UIImage *downloadedImage = [UIImage imageWithData:imageData];
//    
//    
//    [self.imageData performSelectorOnMainThread:@selector(setImage:)
//                                     withObject:downloadedImage
//                                  waitUntilDone:YES];
//}

@end

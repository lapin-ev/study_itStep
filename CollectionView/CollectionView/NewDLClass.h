//
//  NewDLClass.h
//  CollectionView
//
//  Created by Jack Lapin on 23.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "LEDownloadData.h"

@interface NewDLClass : LEDownloadData

 typedef void (^receivedBlock)(NSData *received);

- (void)downloadWithURL:(NSURL *)url withComplition:(receivedBlock)block;

@end

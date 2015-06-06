//
//  ViewControllerForDowloadingData.h
//  CollectionView
//
//  Created by Jack Lapin on 16.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerForDowloadingData : UIViewController

@property NSMutableData *imageData;
@property IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgress;

@end

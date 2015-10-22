//
//  DVGTableViewController.h
//  instagramClient
//
//  Created by Dmitry Volevodz on 26.03.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNMBottomPullToRefreshManager.h"
#import "MNMPullToRefreshManager.h"
@class DVGNewsLoader;


@interface DVGTableViewController : UITableViewController <MNMBottomPullToRefreshManagerClient, MNMPullToRefreshManagerClient>

@property (strong, nonatomic) DVGNewsLoader *loader;
@property (strong, nonatomic) NSCache *cache;
@property (strong, nonatomic) UIImage *tempImage;
@property (strong, nonatomic) MNMBottomPullToRefreshManager *manager;
@property (strong, nonatomic) MNMPullToRefreshManager *managerTop;
@end

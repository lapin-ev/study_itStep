//
//  DVGNewsLoader.h
//  instagramClient
//
//  Created by Dmitry Volevodz on 26.03.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "JSONKit.h"
#import "DVGTableViewController.h"


@interface DVGNewsLoader : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSDictionary *userData;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSDictionary *dataDict;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UITableViewController *myTableVC;
@property (strong, nonatomic) NSMutableArray *parsedData;
@property (strong, nonatomic) NSString *nextUrl;
@property (strong, nonatomic) NSCache *sharedCache;
@property int detailViewTag;
@property int flag;

+ (id) newsLoader;
- (void) getToken;
- (void) setLiked:(NSString*) idd andValue: (BOOL) value;
- (void) getMoreData;
- (void) getData;
@end

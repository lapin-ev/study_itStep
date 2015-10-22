//
//  DVGDetailViewController.h
//  MyGram
//
//  Created by Dmitry Volevodz on 30.03.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DVGNewsLoader;

@interface DVGDetailViewController : UIViewController

{
    int _number;
}

@property (strong, nonatomic) UIImageView* avatarView;
@property (strong, nonatomic) UIImageView* mainImageView;
@property (strong, nonatomic) UILabel* myLabel;
@property (strong, nonatomic) UILabel* myLabel2;
@property (strong, nonatomic) DVGNewsLoader *loader;


- (id) initWithNumber: (NSInteger) number;
- (void) loadAvatar;
@end

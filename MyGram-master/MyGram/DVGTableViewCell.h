//
//  DVGTableViewCell.h
//  MyGram
//
//  Created by Dmitry Volevodz on 30.03.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DVGNewsLoader;

@interface DVGTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *imageCustom;
@property (strong, nonatomic) UIImageView *imageLike;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) DVGNewsLoader *loader;

- (IBAction)like;

@end

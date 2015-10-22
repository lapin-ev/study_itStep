//
//  UITableView+Additions.h
//  GetAllProperty
//
//  Created by Genrih Korenujenko on 20.08.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Additions)

@property(nonatomic, strong) UILabel *placeholderLabel;

@property(nonatomic, readwrite) NSString *text;

@end

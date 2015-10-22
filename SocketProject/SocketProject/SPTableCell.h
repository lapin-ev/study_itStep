//
//  SPTableCell.h
//  SocketProject
//
//  Created by Genrih Korenujenko on 06.10.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPMessage.h"
#import "SPBubbleView.h"


static NSInteger SPTableCellIndent = 15;
static NSInteger SPTableCellIndentLabel = 8;
static NSInteger SPTableCellX = 6;

@interface SPTableCell : UITableViewCell

@property (nonatomic, readwrite) IBOutlet UILabel *labelText;
@property (nonatomic, readwrite) IBOutlet SPBubbleView *shadowLabel;

@property IBOutlet NSLayoutConstraint *leftX, *rightX;

- (void)loadWithMessage:(SPMessage *)message;

- (CGSize)heightCellWith:(SPMessage *)message;

@end

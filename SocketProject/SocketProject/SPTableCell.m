//
//  SPTableCell.m
//  SocketProject
//
//  Created by Genrih Korenujenko on 06.10.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import "SPTableCell.h"

@implementation SPTableCell {
    NSInteger labelTextWidth;
    NSInteger labelTextShadowView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    labelTextWidth = self.labelText.frame.size.width;
    labelTextShadowView = self.shadowLabel.frame.size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)loadWithMessage:(SPMessage *)message {
    self.labelText.text = message.message_text;

    [self cellWidthMessage:message];
}

- (void)cellWidthMessage:(SPMessage *)message {
    NSString *user_id = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];
    
    BOOL user = message.user_id.integerValue == user_id.integerValue? YES : NO;
    
    CGSize size = [self heightCellWith:message];
    
    [self setNeedsUpdateConstraints];
    if (size.height > 25) {
        self.leftX.constant = SPTableCellX;
        self.labelText.textAlignment = NSTextAlignmentLeft;
    } else {
        self.labelText.textAlignment = NSTextAlignmentCenter;
        if (user) {
            self.leftX.constant = labelTextShadowView - (size.width + (self.labelText.frame.origin.x * 2));
            self.rightX.constant = SPTableCellX;
        } else {
            self.rightX.constant = labelTextShadowView - (size.width + (self.labelText.frame.origin.x * 2));
            self.leftX.constant = SPTableCellX;
        }
    }
    [self layoutIfNeeded];
    
    [self.shadowLabel optional:user];
}

- (CGSize)heightCellWith:(SPMessage *)message {
    NSString *text = (message.message_text && message.message_text.length > 0) ? message.message_text : @"some text";
    NSDictionary *attributes = @{NSFontAttributeName: self.labelText.font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(labelTextWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

@end

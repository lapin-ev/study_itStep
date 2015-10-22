//
//  UITableView+Additions.m
//  GetAllProperty
//
//  Created by Genrih Korenujenko on 20.08.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import "UITableView+Additions.h"
#import <objc/runtime.h>

static char key;
static char keyText;

@implementation UITableView (Additions)

- (void)setText:(NSString *)text {
    objc_setAssociatedObject(self, &keyText, text, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    objc_setAssociatedObject(self, &key, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)placeholderLabel {
    return objc_getAssociatedObject(self, &key);
}

-(NSString *)text {
    return objc_getAssociatedObject(self, &keyText);
}

+ (void)load {
    Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
    Method newReloadData = class_getInstanceMethod(self, @selector(newReloadData));
    method_exchangeImplementations(reloadData, newReloadData);
}

- (void)newReloadData {
    [self newReloadData];
    
    NSInteger rowCount = [self numberOfRowsInSection:0];
    
    if (rowCount == 0) {
        self.placeholderLabel = [[UILabel alloc] initWithFrame:self.frame];
        self.placeholderLabel.textAlignment = NSTextAlignmentCenter;
        self.placeholderLabel.text = self.text ? self.text : @"Таблица пуста";
        [self.placeholderLabel setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.placeholderLabel];
    } else {
        [self.placeholderLabel removeFromSuperview];
        self.placeholderLabel = nil;
    }
}

@end

//
//  SPBubbleView.m
//  SocketProject
//
//  Created by Genrih Korenujenko on 07.10.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import "SPBubbleView.h"

@implementation SPBubbleView

- (UIColor *)grayColor {
    return [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:231.0f/255.0f alpha:1];
}

- (UIColor *)greenColor {
    return [UIColor colorWithRed:2.0f/255.0f green:228.0f/255.0f blue:17.0f/255.0f alpha:1];
}

- (void)optional:(BOOL)user {
    if (user) {
        self.backgroundColor = [self greenColor];
    } else {
        self.backgroundColor = [self grayColor];
    }
    
    CGFloat height = 10.0f;

    UIGraphicsBeginImageContext(CGSizeMake(height, height));
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Pick colors
    CGContextSetFillColorWithColor(context, [[self backgroundColor] CGColor]);
    
//    CGFloat xOne = self.frame.size.width;
//    CGFloat yOne = self.bounds.size.height - height;
    CGFloat xOne = user ? 0 : 10;
    CGFloat yOne = 0;
    
    CGContextMoveToPoint(context, xOne, yOne);
    
    CGFloat xTwo = user ? xOne + height - 2 : 2;
    CGFloat yTwo = yOne + height / 2;
    
    CGContextAddLineToPoint(context, xTwo, yTwo);
    
    CGFloat xThree = xOne;
    CGFloat yThree = 10;
    
    CGContextAddLineToPoint(context, xThree, yThree);
    
    // Finalize and draw using path
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    UIImage *bubble = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGRect f = CGRectMake(user ? self.frame.origin.x + self.frame.size.width - 3 : self.frame.origin.x - 8, self.frame.origin.y + self.frame.size.height - height, height, height);
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:f];
    imgV.image = bubble;
    
    [self.superview addSubview:imgV];
    
    NSString *filePath = @"/Users/genrihkorenujenko/Desktop/image.png";
    
    [UIImagePNGRepresentation(bubble) writeToFile:filePath atomically:YES];
}

@end

//
//  DVGTableViewCell.m
//  MyGram
//
//  Created by Dmitry Volevodz on 30.03.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import "DVGTableViewCell.h"
#import "DVGNewsLoader.h"

@implementation DVGTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.loader = [DVGNewsLoader newsLoader];
        self.imageCustom = [[UIImageView alloc] initWithFrame:CGRectMake(7, 12, 306, 306)];
        self.imageCustom.image = [UIImage imageNamed:@"empty.jpg"];
        [self addSubview:self.imageCustom];
        
        self.imageLike = [[UIImageView alloc] initWithFrame:CGRectMake(150, 330, 50, 50)];
        self.imageLike.image = [UIImage imageNamed:@"heart.jpg"];
        [self.imageLike setHidden:YES];
        [self addSubview:self.imageLike];

        
        UIButton *likeButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        likeButton.frame=CGRectMake(210, 330, 100, 50);
        [likeButton setTitle:@"Like" forState:UIControlStateNormal];
        [likeButton addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: likeButton];
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)like
{
    //NSLog(@"%@", self.loader.parsedData[self.tag]);
    
    if ([[self.loader.parsedData[self.tag] objectForKey:@"liked"] intValue])
    {
        [self.loader setLiked:[self.loader.parsedData[self.tag] objectForKey:@"id"] andValue:NO];
        self.imageLike.hidden = YES;
    }
    
    else
    {
        [self.loader setLiked:[self.loader.parsedData[self.tag] objectForKey:@"id"] andValue:YES];
        self.imageLike.hidden = NO;
    }
    
}






@end

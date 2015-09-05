//
//  DDCharacterCollectionCell.m
//  Cartoons
//
//  Created by Dmitriy Demchenko on 8/22/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "DDCharacterCollectionCell.h"

@interface DDCharacterCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *characterImage;

@end


@implementation DDCharacterCollectionCell

- (void)configWithCartoons:(NSDictionary *)model {
    self.backgroundColor = [UIColor randomColor];
    self.characterImage.image = [UIImage imageNamed:model[kImageName]];
}

@end
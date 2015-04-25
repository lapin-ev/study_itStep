//
//  MyCollectionViewCell.h
//  Students
//
//  Created by Jack Lapin on 02.04.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property IBOutlet UIImageView * photoInCell;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;

@end

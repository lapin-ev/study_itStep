//
//  MyTableViewCell.h
//  NewTable
//
//  Created by Jack Lapin on 25.04.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel *headerOfNew;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UILabel *duplicateLabel;

@end

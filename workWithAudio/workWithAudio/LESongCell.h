//
//  LESongCell.h
//  workWithAudio
//
//  Created by Jack Lapin on 29.08.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LESongCell : UITableViewCell

@property (nonatomic, readwrite) IBOutlet UILabel *title;
@property (nonatomic, readwrite) IBOutlet UILabel *artist;
@property (nonatomic, readwrite) IBOutlet UILabel *albumName;
@property (nonatomic, readwrite) IBOutlet UIImageView *image;


@end

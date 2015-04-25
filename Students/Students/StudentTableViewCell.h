//
//  StudentTableViewCell.h
//  Students
//
//  Created by Jack Lapin on 19.03.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *LName;
@property (weak, nonatomic) IBOutlet UILabel *LSurname;
@property (weak, nonatomic) IBOutlet UILabel *LAge;
@property (weak, nonatomic) IBOutlet UILabel *LSex;
@property (weak, nonatomic) IBOutlet UILabel *LInterests;
@property (weak, nonatomic) IBOutlet UIImageView *LPhoto;

@end

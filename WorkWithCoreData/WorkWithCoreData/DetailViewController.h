//
//  DetailViewController.h
//  WorkWithCoreData
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Users;


@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *nameDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dtOfBirthDescriptionLabel;
@property (strong, nonatomic) Users *detailUser;

@end


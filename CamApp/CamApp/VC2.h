//
//  VC2.h
//  CamApp
//
//  Created by student on 22.08.15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "MyContactData.h"
#import "ContactCell.h"

@interface VC2 : UIViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *contactList;

@end

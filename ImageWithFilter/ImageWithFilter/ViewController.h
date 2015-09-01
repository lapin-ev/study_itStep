//
//  ViewController.h
//  ImageWithFilter
//
//  Created by Jack Lapin on 23.07.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *applyFilterButton;

- (CGImageRef) setImageRefWithFilterNumber : (int) value;

- (IBAction)loadImageFromLibrary:(id)sender;

- (IBAction)applyFilter:(id)sender;

- (IBAction)saveImage:(id)sender;


@end


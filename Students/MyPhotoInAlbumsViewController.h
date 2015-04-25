//
//  MyPhotoInAlbumsViewController.h
//  Students
//
//  Created by Jack Lapin on 07.04.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VCSelectPhotoDelegate <NSObject>

- (void) changePhoto : (UIImage*) newPhoto;

@end

@interface MyPhotoInAlbumsViewController : UIViewController

@property (nonatomic, strong) NSString * albumName;

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic, strong) UIImage * selectedImage;

@property (nonatomic, weak) id <VCSelectPhotoDelegate> myDelegate;

@property (weak, nonatomic) IBOutlet UIButton *saveCheckedImagesButton;
- (IBAction)saveCheckedImages:(UIButton *)sender;
- (IBAction)returnWithSaveImage:(UIButton *)sender;

@end

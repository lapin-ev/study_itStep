//
//  MyPhotoInAlbumsViewController.m
//  Students
//
//  Created by Jack Lapin on 07.04.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "MyPhotoInAlbumsViewController.h"
#import "MyCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define kDOC [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@interface MyPhotoInAlbumsViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

{
    NSMutableArray * arrOfPhotosinAlbums;
    
}

@end

@implementation MyPhotoInAlbumsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"%@", kDOC);
    if (!arrOfPhotosinAlbums) {
        arrOfPhotosinAlbums = [NSMutableArray new];
    }
    ALAssetsLibrary *albumInfo = [[ALAssetsLibrary alloc] init];
    [albumInfo enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
            if (asset && [[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:self.albumName]) {
                NSDictionary *dic = @{@"image": [UIImage imageWithCGImage:[asset thumbnail]], @"name": [[asset defaultRepresentation] filename], @"url": [[asset defaultRepresentation] url], @"checked": @"0"};
                
                [arrOfPhotosinAlbums addObject:dic];
            }
            if (arrOfPhotosinAlbums.count == group.numberOfAssets) {
                [_myCollectionView reloadData];
            }
            
        }];
    } failureBlock:^(NSError *error) {
        NSLog(@"Дозвольте J2C доступ до альбомів");
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    [cell.photoInCell setImage:[[arrOfPhotosinAlbums objectAtIndex:indexPath.row] valueForKey:@"image"]];
    
    BOOL isCheck = [[[arrOfPhotosinAlbums objectAtIndex:indexPath.row] valueForKey:@"checked"] boolValue];
    
    if (isCheck)
    {
        [cell.checkImageView setImage:[UIImage imageNamed:@"bright-green-check-mark-md.png"]];
        
    }
    else{
        [cell.checkImageView setImage:nil];
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return arrOfPhotosinAlbums.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * selectedCell =(MyCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    self.selectedImage = selectedCell.photoInCell.image;
    
    BOOL isCheck = [[[arrOfPhotosinAlbums objectAtIndex:indexPath.row] valueForKey:@"checked"] boolValue];
    
    isCheck = !isCheck;
    NSMutableDictionary* checkedPhoto = [[arrOfPhotosinAlbums objectAtIndex:indexPath.row] mutableCopy];
    
    [checkedPhoto setObject: [NSString stringWithFormat:@"%i", (int)isCheck] forKey:@"checked"];
    
    [arrOfPhotosinAlbums replaceObjectAtIndex:indexPath.row withObject:checkedPhoto];
    
    [ UIView setAnimationsEnabled:NO];
    
//    [collectionView performBatchUpdates:^{
//        [collectionView reloadItemsAtIndexPaths:indexPaths];
//    } completion:^(BOOL finished) {
//        [UIView setAnimationsEnabled:YES];
//    }];
    
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
  

    
    
}

- (IBAction)saveCheckedImages:(UIButton *)sender {

    NSError * error = nil;
    NSArray * filePathArray = [[NSFileManager defaultManager ] subpathsOfDirectoryAtPath:kDOC error:&error];

    NSString * path = [kDOC stringByAppendingPathComponent:[filePathArray objectAtIndex:0 ]];

    for (int i = 0; i<arrOfPhotosinAlbums.count; i++)
    {
        BOOL isChecked = [[[arrOfPhotosinAlbums objectAtIndex:i] valueForKey:@"checked"] boolValue];
     
        if (isChecked) {
            UIImage * img = [[arrOfPhotosinAlbums objectAtIndex:i]valueForKey:@"image"];
            NSData * data = UIImageJPEGRepresentation(img,1.0f);
            NSString *nameIMG = [path stringByAppendingPathComponent:[[arrOfPhotosinAlbums objectAtIndex:i] valueForKey:@"name"]];
                               
//                               [[arrOfPhotosinAlbums objectAtIndex:i] valueForKey:@"name"]];
            [data writeToFile:nameIMG atomically:YES];
        }
    }
    filePathArray = [[NSFileManager defaultManager ] subpathsOfDirectoryAtPath:path error:&error];


    
 //   NSString * folderName = [kDOC stringByAppendingPathComponent:@"imgFolder"];
 //   [[NSFileManager defaultManager] createDirectoryAtPath:folderName withIntermediateDirectories:NO attributes:nil error:nil];
 //   filePathArray = [[NSFileManager defaultManager ] subpathsOfDirectoryAtPath:kDOC error:&error];
    NSLog(@"%@",filePathArray);
    
}

- (IBAction)returnWithSaveImage:(UIButton *)sender {
    for (int i = 0; i<arrOfPhotosinAlbums.count; i++)
    {
        BOOL isChecked = [[[arrOfPhotosinAlbums objectAtIndex:i] valueForKey:@"checked"] boolValue];
        if (isChecked) {
           self.selectedImage =[[arrOfPhotosinAlbums objectAtIndex:i] valueForKey:@"image"];
        }
    }
    [[NSNotificationCenter defaultCenter ] postNotificationName:@"changePhoto" object:self.selectedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
//    [self.myDelegate changePhoto:self.selectedImage];
}
@end

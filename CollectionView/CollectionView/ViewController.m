//
//  ViewController.m
//  CollectionView
//
//  Created by Jack Lapin on 16.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#import "MyNewCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "LEDownloadData.h"

@interface ViewController () <UICollectionViewDataSource , UICollectionViewDelegate>



@end

NSArray * dataArr;

@implementation ViewController
@synthesize pullToRefresh;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    dataArr  = @[@{@"text" : @"text 1", @"imageurl" : @"http://upload.wikimedia.org/wikipedia/commons/9/91/Adium.png"}, @{@"text" : @"text 2", @"imageurl" : @"http://www.imagenspng.com.br/wp-content/uploads/2015/02/yoshi-super-mario-02.png"}, @{@"text" : @"text 3", @"imageurl" : @"http://www.personal.psu.edu/sdh5174/Mario_png.png"}, @{@"text" : @"text 4", @"imageurl" : @"http://pngimg.com/upload/jewelry_PNG6803.png"}];

    self.refControl = [UIRefreshControl new];
    [self.refControl setTintColor:[UIColor whiteColor]];
    [self.collectionView addSubview:self.refControl];
    self.collectionView.alwaysBounceVertical = YES;
    [self.refControl addTarget:self action:@selector(refreshCollection:) forControlEvents:UIControlEventValueChanged];
//    self.pullToRefresh = [UIPanGestureRecognizer new];
//    [self.pullToRefresh addTarget:self action:@selector(moveCollection:)];
    //    self.collectionView.frame.size.height =
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyNewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CVCell" forIndexPath:indexPath];
    
    cell.discrOfPhoto.text = [dataArr objectAtIndex:indexPath.row][@"text"];
//    [cell.photoInCell setImage:[UIImage imageNamed:@"no_image.jpg"]];
    
    [cell.photoInCell setImageWithURL:[NSURL URLWithString:[dataArr objectAtIndex:indexPath.row][@"imageurl"]] placeholderImage:[UIImage imageNamed:@"no_image.jpg"]];

    
  //  [cell.actIndicator startAnimating];
      //  cell.actIndicator.hidden = NO;
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSURL * url = [NSURL URLWithString:[dataArr objectAtIndex:indexPath.row][@"imageurl"]];
//        __block    NSData * imgData = [NSData dataWithContentsOfURL:url];
//
//        [cell.photoInCell setImageWithURL:[NSURL URLWithString:[dataArr objectAtIndex:indexPath.row][@"imageurl"]]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            if (imgData) {
//                [cell.photoInCell setImage:[UIImage imageWithData:imgData]];
//            }
//            else {
//                [cell.photoInCell setImage:[UIImage imageNamed:@"no_image.jpg"]];
//            }
//            [cell.actIndicator stopAnimating];
//                 //       cell.actIndicator.hidden = YES;
//            imgData = nil;
//        });
//        
//    });
    
    
    //    [cell.photoInCell setImage:[UIImage imageNamed:@"img.jpg"][@"imageurl"]];
    
    
    BOOL isCheck = 1;
    
    if (isCheck)
    {
    }
    else{
        [cell.photoInCell setImage:nil];
    }
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pullToRefreshGesture:(id)sender {
    
}

-(void) refreshCollection : (UIRefreshControl*) control {
    
    
    [self.collectionView reloadData];
    [control endRefreshing];
}

@end

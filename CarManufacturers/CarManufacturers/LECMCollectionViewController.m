//
//  LECMCollectionViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "LECMCollectionViewController.h"
#import "LECMContainerViewController.h"
#import "LECMCollectionViewController.h"
#import "LECMTableViewController.h"
#import "LECMAddNewViewController.h"
#import "LEDataSource.h"
#import "LECMCollectionCell.h"

@interface LECMCollectionViewController () <CMDataSourceDelegate>

@property (strong, nonatomic) LEDataSource *dataSource;

@end

@implementation LECMCollectionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.dataSource = [[LEDataSource alloc] initWithDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat mainScreen = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat cellSize = (mainScreen / 100 < 4) ? (mainScreen - 20.f) / 3 : (mainScreen - 25.f) / 4;
    return CGSizeMake(cellSize, cellSize);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource countModels];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LECMCollectionCell *cell = (LECMCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LECMCollectionCell class]) forIndexPath:indexPath];
    [cell configWithModel:[self.dataSource modelForIndex:indexPath.row]];
    
    return cell;
}

- (void)dataWasChanged:(LEDataSource *)dataSource {
    [self.collectionView reloadData];
}


@end

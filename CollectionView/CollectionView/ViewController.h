//
//  ViewController.h
//  CollectionView
//
//  Created by Jack Lapin on 16.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *pullToRefresh;

@property UIRefreshControl * refControl;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)pullToRefreshGesture:(id)sender;

@end


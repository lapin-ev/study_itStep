//
//  LECMContainerViewController.m
//  CarManufacturers
//
//  Created by Jack Lapin on 05.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "constants.h"
#import "LECMContainerViewController.h"
#import "LECMContainerViewController.h"
#import "LECMCollectionViewController.h"
#import "LECMTableViewController.h"



@interface LECMContainerViewController ()

@property (strong, nonatomic) LECMTableViewController *tableController;
@property (strong, nonatomic) LECMCollectionViewController *collectionController;
@property (strong, nonatomic) UIViewController *currentViewController;
@property (assign, nonatomic) BOOL isChange;

@end

@implementation LECMContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isChange = NO;
    
    self.tableController = [self.storyboard instantiateViewControllerWithIdentifier:TableControllerID];
    self.collectionController = [self.storyboard instantiateViewControllerWithIdentifier:CollectionControllerID];
    
    [self presentController:self.tableController];
}

#pragma mark - ContainerViewController methods

- (void)presentController:(UIViewController *)controller {
    if (self.currentViewController) {
        [self removeCurrentViewController];
    }
    [self addChildViewController:controller];
    controller.view.frame = [self frameForCharacterController];
    [self.view addSubview:controller.view];
    self.currentViewController = controller;
    [controller didMoveToParentViewController:self];
}

- (void)removeCurrentViewController {
    [self.currentViewController willMoveToParentViewController:nil];
    [self.currentViewController.view removeFromSuperview];
    [self.currentViewController removeFromParentViewController];
}

- (void)swapCurrentControllerWith:(UIViewController *)controller {
    
    __block CGRect tempRect;
    tempRect.origin.x = 0.f;
    tempRect.origin.y = 2000.f;
    tempRect.size = CGSizeMake(CGRectGetWidth(controller.view.frame), CGRectGetHeight(controller.view.frame));
    
    [self.currentViewController willMoveToParentViewController:nil];
    [self addChildViewController:controller];
    controller.view.frame = tempRect;
    [self.view addSubview:controller.view];
    
    [UIView animateWithDuration:1.3f animations:^{
        
        controller.view.frame = self.currentViewController.view.frame;
        tempRect.origin.y = -2000.f;
        self.currentViewController.view.frame = tempRect;
        
    } completion:^(BOOL finished) {
        
        [self.currentViewController.view removeFromSuperview];
        [self.currentViewController removeFromParentViewController];
        self.currentViewController = controller;
        [self.currentViewController didMoveToParentViewController:self];
    }];
}

- (CGRect)frameForCharacterController {
    return self.view.bounds;
}

#pragma mark - Actions

- (void)swapViewControllers:(UINavigationItem *)navigationItem {
    if (!self.isChange) {
        [self swapCurrentControllerWith:self.collectionController];
        [navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"TableViewIcon"]];
        self.isChange = YES;
    } else {
        [self swapCurrentControllerWith:self.tableController];
        [navigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"CollectionViewIcon"]];
        self.isChange = NO;
    }
}

@end

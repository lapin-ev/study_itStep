//
//  ViewControllerForDowloadingData.m
//  CollectionView
//
//  Created by Jack Lapin on 16.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "ViewControllerForDowloadingData.h"
#import "NewDLClass.h"

#define kURLImageMario @"http://pngimg.com/upload/jewelry_PNG6803.png"

@interface ViewControllerForDowloadingData () <NSURLConnectionDataDelegate, LEDownloadDataDelegate >  {
    long long download;
    
    NewDLClass *leDowloadC;
}

@end

@implementation ViewControllerForDowloadingData

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    leDowloadC = [NewDLClass new];
    
    leDowloadC.delegate = self;
    
    NSURL *url = [NSURL URLWithString:kURLImageMario];
    
    [leDowloadC downloadWithURL:url withComplition:^(NSData *received) {
        NSLog(@"%lu", (unsigned long)received.length);
        
        
    [self.imgView performSelectorOnMainThread:@selector(setImage:) withObject:[UIImage imageWithData:received] waitUntilDone:YES];
        
    }];
    
//    [leDowloadC dowloadImageWithURL:[NSURL URLWithString:kURLImageMario]];
    
    
    
}


- (void) dowloadProgress:(float)loadedByte {
    self.downloadProgress.progress = loadedByte;
}

-(void) image:(UIImage *)img {
    [self.imgView setImage : img ];
    self.downloadProgress.hidden= YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

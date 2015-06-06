//
//  NewDLClass.m
//  CollectionView
//
//  Created by Jack Lapin on 23.05.15.
//  Copyright (c) 2015 Jack Lapin. All rights reserved.
//

#import "NewDLClass.h"
@interface NewDLClass() <NSURLConnectionDataDelegate> {
    
    long long download;
    
    
}
@property (nonatomic, copy) receivedBlock complitionBlock;
@end

@implementation NewDLClass
@synthesize imageData;

- (void)downloadWithURL:(NSURL *)url withComplition:(receivedBlock)block {
    self.complitionBlock = block;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse* response, NSData* data, NSError *errorServer) {
        NSLog(@"response: %@", response);
        self.complitionBlock(data);
    }];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [imageData appendData:data];
    
    float prog = (float)[imageData length] / (float)download;
    
    [self.delegate dowloadProgress:prog];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [self.delegate image:[UIImage imageWithData:imageData]];
}

-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    download = [response expectedContentLength];
}


@end

//
//  DVGDetailViewController.m
//  MyGram
//
//  Created by Dmitry Volevodz on 30.03.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import "DVGDetailViewController.h"
#import "DVGNewsLoader.h"


@interface DVGDetailViewController ()

@end

@implementation DVGDetailViewController


- (id) initWithNumber:(NSInteger)number
{
    self = [super init];
    if (self) {
        _number = number;
        self.loader = [DVGNewsLoader newsLoader];
        self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 82, 306, 306)];
        self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 12, 50, 50)];
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(64, 4, 300, 30)];
        self.myLabel.text = [self.loader.parsedData[_number] objectForKey:@"userName"];
        self.myLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(64, 34, 300, 30)];
        NSNumber *likes = [self.loader.parsedData[_number] objectForKey:@"numberOfLikes"];
        NSNumber *comments = [self.loader.parsedData[_number] objectForKey:@"comments"];
        self.myLabel2.text = [NSString stringWithFormat:@"Likes: %@, Comments: %@", likes, comments];
        
        self.mainImageView.image = [UIImage imageWithData: [self.loader.sharedCache objectForKey:[self.loader.parsedData[number] objectForKey:@"imageLR"]]];
        
        self.view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.mainImageView];
        [self.view addSubview:self.avatarView];
        [self.view addSubview:self.myLabel];
        [self.view addSubview:self.myLabel2];
        
        [self loadAvatar];
        
        
    }
    return self;
}

- (void) loadAvatar
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        
        NSString *url = [self.loader.parsedData[_number] objectForKey:@"userAvatar"];
        NSData *imageData = nil;
        if ([self.loader.sharedCache objectForKey:url] != nil)
        {
            imageData = [self.loader.sharedCache objectForKey:url];
        }
        
        else
        {
            imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            [self.loader.sharedCache setObject:imageData forKey:[self.loader.parsedData[_number] objectForKey:@"userAvatar"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            self.avatarView.image = image;
        });
    });

}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

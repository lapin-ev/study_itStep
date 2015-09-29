//
//  FirstViewController.m
//  JSONandMaps
//
//  Created by Jack Lapin on 26.09.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (nonatomic, strong) LEWeatherInfo *  wetherInfo;
@property (weak, nonatomic) IBOutlet UILabel *temperatureValue;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSURL* getWeatherURL = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?q=Kiev&units=metric"];
    
    NSURLSessionDataTask * dataTask = [session dataTaskWithURL:getWeatherURL
                                             completionHandler:^(NSData * _Nullable data,
                                                                 NSURLResponse * _Nullable response,
                                                                 NSError * _Nullable error) {
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     NSDictionary * weatherInfoDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                      options:NSJSONReadingAllowFragments
                                                                                                                        error:NULL];
                                                     self.wetherInfo = [[LEWeatherInfo alloc] initWithDictionary:weatherInfoDict];
                                                     self.temperatureValue.text =[NSString stringWithFormat:@"%f◦",self.wetherInfo.temperature ];
                                                     
                                                 });
                                                 
                                             }];
    [dataTask resume];
    
}


@end

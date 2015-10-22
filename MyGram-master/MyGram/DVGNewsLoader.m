//
//  DVGNewsLoader.m
//  instagramClient
//
//  Created by Dmitry Volevodz on 26.03.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import "DVGNewsLoader.h"
#import "JSONKit.h"

@implementation DVGNewsLoader


// Небезопасная инициализация синглтона

+ (id) newsLoader
{
    const static DVGNewsLoader *loader = nil;
    if (nil == loader)
    {
        loader = [[DVGNewsLoader alloc] init];
        loader.sharedCache = [[NSCache alloc] init];
        
    }
    return loader;
}


// Метод запрашивает access_token на основании полученного урл, после получения его вызывает метод по обработке полученных данных

- (void) getToken
{
    
    AFHTTPClient *aClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.instagram.com/oauth/access_token"]];
    [aClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [aClient requestWithMethod:@"POST"
                                                            path:@"https://api.instagram.com/oauth/access_token"
                                                   parameters:@{@"client_id" : @"26b5f5babdea4c788158b2e892094435",
                                    @"client_secret":@"5d8c265251f0435cb910e1b74745840e",
                                    @"grant_type":@"authorization_code", @"redirect_uri":@"tinyInstaFeedObserver://",@"scope":@"basic+likes", @"code":self.code}];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [aClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *temp = [responseObject objectFromJSONData];
        self.token = [temp objectForKey:@"access_token"];
        [self getData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
    

}


// Запрашивает последние данные из ленты авторизованного пользователя

- (void) getData
{ 
    AFHTTPClient *aClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.instagram.com/v1/tags/automotive/media/recent?"]];
    [aClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [aClient requestWithMethod:@"GET"
                                                         path:@"https://api.instagram.com/v1/tags/figureskating/media/recent?"
                                                   parameters:@{@"access_token": self.token}];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [aClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       NSDictionary *temp = [responseObject objectFromJSONData];

        self.dataDict = temp;
        [self parseData];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
   
    
}

// Скидывает данные в массив для дальнейшей обработки

- (void) parseData
{
    
    NSArray *tempArray = [self.dataDict objectForKey:@"data"];
    self.dataArray = tempArray;
    
    if (self.parsedData == nil)
    {
        self.parsedData = [[NSMutableArray alloc] init];
        
    }
    
    self.nextUrl = [[self.dataDict objectForKey:@"pagination"] objectForKey:@"next_url"];
    
    for (int i = 0; i < [self.dataArray count]; i++)
    {
        NSString *idString = [self.dataArray[i] objectForKey:@"id"];
        self.flag = 0;
        
        for (int j = 0; j < [self.parsedData count]; j++) {
            if ([idString isEqualToString:[self.parsedData[j] objectForKey:@"id"]])
            {
                self.flag = 1;
            }
        }
        
        if (self.flag != 1)
        {
        
            NSString *imageLR = [[[self.dataArray[i] objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"];
            NSString *userName = [[self.dataArray[i] objectForKey:@"user"] objectForKey:@"full_name"];
            NSString *userAvatar = [[self.dataArray[i] objectForKey:@"user"] objectForKey:@"profile_picture"];
            NSString *imageSR = [[[self.dataArray[i] objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
            NSNumber *liked = [self.dataArray[i] objectForKey:@"user_has_liked"];
            NSNumber *comments = [[self.dataArray[i] objectForKey:@"comments"] objectForKey:@"count"];
            NSNumber *numberOfLikes = [[self.dataArray[i] objectForKey:@"likes"] objectForKey:@"count"];
            NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
            [temp setObject:idString forKey:@"id"];
            [temp setObject:imageLR forKey:@"imageLR"];
            [temp setObject:imageSR forKey:@"imageSR"];
            [temp setObject:liked forKey:@"liked"];
            [temp setObject:userName forKey:@"userName"];
            [temp setObject:userAvatar forKey:@"userAvatar"];
            [temp setObject:comments forKey:@"comments"];
            [temp setObject:numberOfLikes forKey:@"numberOfLikes"];
            [self.parsedData addObject:temp];
        }
        self.flag = 0;
    }
 
    [self.myTableVC.tableView reloadData];

}

- (void) getMoreData
{
    AFHTTPClient *aClient = [[AFHTTPClient alloc] init];
    [aClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [aClient requestWithMethod:@"GET"
                                                         path:self.nextUrl
                                                   parameters:@{@"access_token": self.token}];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [aClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *temp = [responseObject objectFromJSONData];
        
        self.dataDict = temp;
        [self parseData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
}







- (void) setLiked:(NSString*) idd andValue: (BOOL) value

{
    if (value)
    {
        
        AFHTTPClient *aClient = [[AFHTTPClient alloc] init];
        [aClient setParameterEncoding:AFFormURLParameterEncoding];
        
        NSString *tempUrl = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/%@/likes", idd];
        
        NSMutableURLRequest *request = [aClient requestWithMethod:@"POST"
                                                             path:tempUrl
                                                       parameters:@{@"access_token": self.token}];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [aClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            for (int i = 0; i < [self.parsedData count]; i++) {
                if ([[self.parsedData[i] objectForKey:@"id"] isEqual:idd])
                {
                    [self.parsedData[i] setObject:@1 forKey:@"liked"];
                }
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        [operation start];

        
    }
    
    else
    {
        AFHTTPClient *aClient = [[AFHTTPClient alloc] init];
        [aClient setParameterEncoding:AFFormURLParameterEncoding];
        
        NSString *tempUrl = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/%@/likes", idd];
        
        NSMutableURLRequest *request = [aClient requestWithMethod:@"DELETE"
                                                             path:tempUrl
                                                       parameters:@{@"access_token": self.token}];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [aClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            for (int i = 0; i < [self.parsedData count]; i++) {
                if ([[self.parsedData[i] objectForKey:@"id"] isEqual:idd])
                {
                    [self.parsedData[i] setObject:@0 forKey:@"liked"];
                    
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        [operation start];

        
        
    }
    
    
}










@end

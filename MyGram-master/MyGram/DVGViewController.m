//
//  DVGViewController.m
//  MyGram
//
//  Created by Dmitry Volevodz on 26.03.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import "DVGViewController.h"

static NSString *const redirectUri = @"tinyInstaFeedObserver://";
static NSString *const clientID = @"26b5f5babdea4c788158b2e892094435";

@interface DVGViewController ()

@end

@implementation DVGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/* Кнопка вызывает Сафари с сформированным урлом для авторизации пользователя, по возвращении пользователь вернется в метод 
 - (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
    в апп DVGAppdelegate.m
*/

- (IBAction)loginAction:(id)sender {
    
    
    NSString *fullAuthUrlString = [[NSString alloc]
                                   initWithFormat:@"https://api.instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=code&scope=basic+likes",
                                   clientID,
                                   redirectUri];
    NSURL *authUrl = [NSURL URLWithString:fullAuthUrlString];
    
    [[UIApplication sharedApplication] openURL:authUrl];
}

- (IBAction)logoutAction:(id)sender
{
    // У инстаграма нет метода апи для логаута, поэтому используется грязный хак.   
    NSString *logoutString = [[NSString alloc]
                                   initWithFormat:@"https://instagram.com/accounts/logout/"];
    NSURL *logoutUrl = [NSURL URLWithString:logoutString];
    
    [[UIApplication sharedApplication] openURL:logoutUrl];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  SPLaunchVC.m
//  SocketProject
//
//  Created by Genrih Korenujenko on 07.10.15.
//  Copyright © 2015 Genrih Korenujenko. All rights reserved.
//

#import "SPLaunchVC.h"

@interface SPLaunchVC ()

@end

@implementation SPLaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = [[[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil] objectAtIndex:0];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];    
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager.requestSerializer setValue:getUser_id forHTTPHeaderField:headerUserID];
    [manager.requestSerializer setValue:getUser_session_hash forHTTPHeaderField:headerSessionHash];
    
    [manager GET:STRINGFORMATING(urlServer, userProfilePath) parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        PARSINGANSWER(operation.responseData, @"user_info");
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        PARSINGANSWER(operation.responseData, @"errors");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

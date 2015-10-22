//
//  ViewController.m
//  createPods
//
//  Created by Genrih Korenujenko on 06.10.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import "SPMessagesVC.h"
#import "SPMessage.h"
#import "SPTableCell.h"

#import <SRWebSocket.h>
#import <MediaToolbox/MediaToolbox.h>

static NSString *urlChat = @"ws://91.239.234.74:5241";

static NSString *user_id = @"2";
static NSString *recipient_id = @"1";
static NSString *name = @"Genrih";
static NSString *lastName = @"Korenujenko";

@interface SPMessagesVC () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, SRWebSocketDelegate> {
    SRWebSocket *socketChat;
    
    NSMutableArray *arrayMessages;
    
    IBOutlet UITableView *tableViewMessage;
    
    IBOutlet UITextField *textFieldMessage;
}

@end

@implementation SPMessagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"user_id"];
    
    arrayMessages = [NSMutableArray new];
    
    socketChat = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlChat]];
    socketChat.delegate = self;
    [socketChat open];
}

- (IBAction)press:(id)sender {
    
//    @"\"message\": \"1\",\"message_text\":\"test\",\"message_photo\":\"\",\"recipient_id\":\"6\",\"recipient_new_messages\":\"17\",\"user_id\":\"65\",\"user_name\":\"test\",\"user_lastname\":\"tst\",\"user_avatar\":""
    
    NSString *messageString = [NSString stringWithFormat:@"{\"message\":true,\"message_text\":\"%@\",\"recipient_id\":\"%@\",\"user_id\":%@,\"user_name\":\"%@\",\"user_lastname\":\"%@\"}", textFieldMessage.text, recipient_id, user_id, name, lastName];
    
    [socketChat send:messageString];
    
    textFieldMessage.text = @"";
}

- (void)dealloc {
    socketChat.delegate = nil;
    [socketChat close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if (json) {
        [self reloadTableViewWithDicationary:json];
    }
}

- (void)reloadTableViewWithDicationary:(NSDictionary *)dictionary {
    if ([[dictionary valueForKey:@"message"] boolValue]) {
        SPMessage *newMessage = [SPMessage new];
        [newMessage messageWithDictionary:dictionary];
        
        [arrayMessages insertObject:newMessage atIndex:0];
        
        [tableViewMessage reloadData];
        
        if (newMessage.user_id.integerValue == user_id.integerValue) {
            AudioServicesPlaySystemSound(1004);
        } else {
            AudioServicesPlaySystemSound(1003);
        }
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"close");
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"open");
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
    NSLog(@"pong");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayMessages.count;
}

- (SPTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SPTableCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(SPTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell loadWithMessage:arrayMessages[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SPTableCell class])];
    
    CGFloat height = [cell heightCellWith:arrayMessages[indexPath.row]].height + SPTableCellIndent + SPTableCellIndentLabel;
    
    return height;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end

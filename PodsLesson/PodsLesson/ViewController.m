//
//  ViewController.m
//  PodsLesson
//
//  Created by Jack Lapin on 10.10.15.
//  Copyright © 2015 Jack Lapin. All rights reserved.
//

#import "ViewController.h"
#import <SRWebSocket.h>
#import <AFNetworking.h>
#import <MediaToolbox/MediaToolbox.h>

static NSString *urlChat = @"ws://91.239.234.74:5241";

static NSString *user_id = @"3";
static NSString *recipient_id = @"7";
static NSString *name = @"Jack";
static NSString *lastName = @"Lapin";

@interface ViewController () <SRWebSocketDelegate>

@property NSMutableArray *arrayOfMessages;
@property SRWebSocket * webSocket;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)send:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textFieldConctraitnt;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayOfMessages = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlChat]];
    
    self.webSocket.delegate = self;
    [_webSocket open];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void) textFieldDidChange: (UITextField *)sender {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int position = (scrollView.contentOffset.y);
    //  NSLog(@"%i",position);
}

- (void) keyboardWillShow :(NSNotification*)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    self.textFieldConctraitnt.constant = keyboardFrameBeginRect.size.height + 10;
    [self.view layoutIfNeeded];
}

- (void) keyboardWillHide :(NSNotification*)notification {
    self.textFieldConctraitnt.constant = 10;
    [self.view layoutIfNeeded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *newString = [textField.text mutableCopy];
    [newString appendString:string];
    
    if (string.length == 0 && newString.length ==1) {
        self.sendButton.enabled = false;
    }
    else   {
        self.sendButton.enabled = true;
    }
    return YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"messageCell";
    
    //Поиск ячейки
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Если ячейка не найдена
    if (cell == nil) {
        //Создание ячейки
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.backgroundColor = [UIColor greenColor];
    cell.layer.cornerRadius = 25;
    cell.textLabel.text = [self.arrayOfMessages objectAtIndex:indexPath.row];
    return cell;
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"port open");
}

-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if (json) {
        
        if ([[json valueForKey:@"recipient_id"] integerValue] == user_id.integerValue || [[json valueForKey:@"user_id"] integerValue] == user_id.integerValue){
            [self.arrayOfMessages insertObject:[json valueForKey:@"message_text"] atIndex:0];
            [self.tableView reloadData];
            NSLog(@"%@",json);
        }
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfMessages.count;
}

- (IBAction)send:(id)sender {
    NSString *messageString = [NSString stringWithFormat:@"{\"message\":true,\"message_text\":\"%@\",\"recipient_id\":\"%@\",\"user_id\":%@,\"user_name\":\"%@\",\"user_lastname\":\"%@\"}", self.textField.text, recipient_id, user_id, name, lastName];
    
    [_webSocket send:messageString];
    
    _textField.text = @"";
    AudioServicesPlaySystemSound(1004);
    //  [self.tableView reloadData];
}

-(void)dealloc {
    _webSocket.delegate = nil;
    [_webSocket close];
}

@end

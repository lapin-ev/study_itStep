//
//  SPMessage.h
//  SocketProject
//
//  Created by Genrih Korenujenko on 06.10.15.
//  Copyright (c) 2015 Genrih Korenujenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPMessage : NSObject

@property (nonatomic, readwrite) NSString *user_name;
@property (nonatomic, readwrite) NSString *user_lastname;
@property (nonatomic, readwrite) NSString *user_id;
@property (nonatomic, readwrite) NSString *recipient_id;
@property (nonatomic, readwrite) NSString *message_text;

- (void)messageWithDictionary:(NSDictionary *)dictionary;

@end

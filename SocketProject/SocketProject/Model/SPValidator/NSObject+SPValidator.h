//
//  NSObject+SPValidator.h
//  SocketProject
//
//  Created by Genrih Korenujenko on 07.10.15.
//  Copyright © 2015 Genrih Korenujenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SPValidator)

- (NSString *)isValidPassword:(NSString *)password;
- (NSString *)isValidEmail:(NSString *)email;

@end

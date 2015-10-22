//
//  NSObject+SPValidator.m
//  SocketProject
//
//  Created by Genrih Korenujenko on 07.10.15.
//  Copyright © 2015 Genrih Korenujenko. All rights reserved.
//

#import "NSObject+SPValidator.h"

@implementation NSObject (SPValidator)

- (NSString *)isValidPassword:(NSString *)password {
    if (password.length > 20 || password.length < 6)
        return @"Пароль должен быть не меньше 6 и не больше 20 символов";
    return nil;
}

- (NSString *)isValidEmail:(NSString *)email {
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email] ? nil : @"email введен некорректно";
}

@end

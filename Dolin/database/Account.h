//
//  Account.h
//  Dolin
//
//  Created by gestalt on 2018/11/3.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    ACCOUNT_NORMAL = 0,
    ACCOUNT_ADMIN,
    ACCOUNT_PROGRAMMER
} AccountType;

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSObject
+ (id)sharedAccount;
- (BOOL)login:(AccountType)accountType password:(NSString *)password;
- (void)logout;
- (BOOL)isPermitted;
- (BOOL)isProgrammer;
- (BOOL)changePassword:(NSString *)password type:(AccountType)type;
@end

NS_ASSUME_NONNULL_END

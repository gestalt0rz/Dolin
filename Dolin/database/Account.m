//
//  Account.m
//  Dolin
//
//  Created by gestalt on 2018/11/3.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import "Account.h"
#import "DBManager.h"
#import <FMDB/FMDB.h>

// for MD5
#include <stdio.h>
#include <string.h>

#include <CommonCrypto/CommonDigest.h>

static NSString * const normalName = @"杜林紙草";
static NSString * const adminName = @"管理員";
static NSString * const programmerName = @"程式管理員";

static NSString * const normalImage = @"dolin";
static NSString * const adminImage = @"dolin";
static NSString * const programmerImage = @"gestalt_1700x1700";

/** Query for the select rows. */
static NSString * const kSQLSelect = @""
"SELECT "
"password "
"FROM "
"account;"
"WHERE "
"type =?;";

/** Query for the update row. */
static NSString * const kSQLUpdate = @""
"UPDATE "
"account "
"SET "
"password=? "
"WHERE "
"type = ?;";

@interface Account ()
@property (nonatomic) AccountType accountType;
@end

@implementation Account

+ (id)sharedAccount {
    static Account *sharedMyAccount = nil;
    @synchronized(self) {
        if (sharedMyAccount == nil)
            sharedMyAccount = [[self alloc] init];
    }
    return sharedMyAccount;
}

- (BOOL)login:(AccountType)accountType password:(NSString *)password {
    NSString* dbPassword = [(FMResultSet *)[[DBManager sharedManager] executeQuery:kSQLSelect, accountType] stringForColumnIndex:0];
    NSString* checkPasswrod = [Account md5SignWithString:password];
    
    if([dbPassword isEqualToString:checkPasswrod]){
        self.accountType = accountType;
        return YES;
    }else return NO;
}

- (void)logout {
    self.accountType = ACCOUNT_NORMAL;
}

- (BOOL)isPermitted {
    if(self.accountType == ACCOUNT_ADMIN || self.accountType == ACCOUNT_PROGRAMMER) return YES;
    else return NO;
}

- (BOOL)isProgrammer {
    if(self.accountType == ACCOUNT_PROGRAMMER) return YES;
    else return NO;
}

- (BOOL)changePassword:(NSString *)password type:(AccountType)type {
    if(self.accountType >= type) {
        return [[DBManager sharedManager] executeUpdate:kSQLUpdate,
                [Account md5SignWithString:password],
                [NSNumber numberWithInteger:type]];
    }
    return NO;
}

- (NSString *)getCurrentAccountName {
    NSString *name = nil;
    switch (self.accountType) {
        case ACCOUNT_NORMAL:
            name = normalName;
            break;
        case ACCOUNT_ADMIN:
            name = adminName;
            break;
        case ACCOUNT_PROGRAMMER:
            name = programmerName;
            break;
    }
    return name;
}

- (NSString *)getCurrentAccountImage {
    NSString *name = nil;
    switch (self.accountType) {
        case ACCOUNT_NORMAL:
            name = normalImage;
            break;
        case ACCOUNT_ADMIN:
            name = adminImage;
            break;
        case ACCOUNT_PROGRAMMER:
            name = programmerImage;
            break;
    }
    return name;
}

#pragma mark - Private

- (instancetype)init {
    self = [super init];
    if (self) {
        self.accountType = ACCOUNT_NORMAL;
    }
    
    return  self;
}

+ (NSString *)md5SignWithString:(NSString *)string
{
    const char *object = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(object,(CC_LONG)strlen(object),result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i ++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

@end

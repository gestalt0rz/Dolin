//
//  WeddingDressDAO.m
//  Dolin
//
//  Created by gestalt on 2018/10/31.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import "WeddingDressDAO.h"
#import "DBManager.h"
#import "WeddingDress.h"
#import <FMDB/FMDB.h>

/** Query for the create table. */
static NSString * const kSQLCreate = @""
"CREATE TABLE IF NOT EXISTS weddingDress ("
"id INTEGER PRIMARY KEY AUTOINCREMENT, "
"sn VARCHAR(255) NOT NULL UNIQUE, "
"title VARCHAR(255), "
"rent INT DEFAULT 0, "
"status INT DEFAULT 0, "
"handling_vender_id INT DEFAULT 0, "
"purchase_date DATE, "
"purchase_price INT, "
"purchase_vender_id INT "
");";

/** Query for the select rows. */
static NSString * const kSQLSelect = @""
"SELECT "
"id, sn, title, rent, status, handling_vender_id "
"FROM "
"weddingDress;"
"ORDER BY "
"id;";

/** Query for the select rows. */
static NSString * const kPermittedSQLSelect = @""
"SELECT "
"id, sn, title, rent, status, handling_vender_id, purchase_date, purchase_price, purchase_vender_id "
"FROM "
"weddingDress;"
"ORDER BY "
"id;";

/** Query for the inssert row. */
static NSString * const kSQLInsert = @""
"INSERT INTO "
"weddingDress (sn, title, rent, purchase_date, purchase_price, purchase_vender_id) "
"VALUES "
"(?, ?, ?, ?, ?, ?);";

/** Query for the update row. */
static NSString * const kSQLUpdate = @""
"UPDATE "
"weddingDress "
"SET "
"sn = ?, title = ?, rent = ?, status=?, handling_vender_id=? "
"WHERE "
"id = ?;";

/** Query for the update row. */
static NSString * const kPermittedSQLUpdate = @""
"UPDATE "
"weddingDress "
"SET "
"sn = ?, title = ?, rent = ?, status=?, handling_vender_id=?, purchase_date=?, purchase_price=?, purchase_vender_id=? "
"WHERE "
"id = ?;";

/** Query for the delete row. */
static NSString * const kSQLDelete = @""
"DELETE FROM weddingDress WHERE id = ?;";

@interface WeddingDressDAO ()
@property (nonatomic) DBManager *dm;
@end

@implementation WeddingDressDAO

/**
 * Initialize the instance.
 *
 *
 * @return Instance.
 */
- (instancetype)init {
    self = [super init];
    
    self.dm = [DBManager sharedManager];
    
    return self;
}

/**
 * Create the table.
 *
 *
 * @return YES if successful.
 */
- (BOOL)create {
    return [self.dm executeUpdate:kSQLCreate];
}

- (WeddingDress *)add:(NSString *)sn title:(NSString *)title rent:(NSInteger)rent purchase_date:(NSDate *)purchase_date purchase_price:(NSInteger)purchase_price vender_id:(NSInteger)vender_id {
    WeddingDress *wd = nil;
    if ([self.dm executeUpdate:kSQLInsert, sn, title, [NSNumber numberWithInteger:rent], purchase_date, [NSNumber numberWithInteger:purchase_price], [NSNumber numberWithInteger:vender_id]]) {
        NSInteger weddingDressId = [[self.dm db] lastInsertRowId];
        wd = [WeddingDress weddingDressWithId:weddingDressId sn:sn title:title rent:rent status:WD_STOCK handlingVender:vDefaultVender];
        [wd setPurchase_date:nil purchase_price:vDefaultPrice vender_id:vDefaultVender];//TODO permitted
    }
    
    return wd;
}

- (NSArray *)find {
    NSMutableArray *WeddingDresses = [NSMutableArray arrayWithCapacity:0];
    FMResultSet    *results = [self.dm executeQuery:kSQLSelect];
    
    while ([results next]) {
        WeddingDress* wd = [WeddingDress weddingDressWithId:[results intForColumnIndex:0] sn:[results stringForColumnIndex:1] title:[results stringForColumnIndex:2] rent:[results intForColumnIndex:3] status:[results intForColumnIndex:4] handlingVender:[results intForColumnIndex:5]];
        [wd setPurchase_date:nil purchase_price:vDefaultPrice vender_id:vDefaultVender];//TODO permitted
        [WeddingDresses addObject:wd];
    }
    
    return WeddingDresses;
}

- (BOOL)remove:(NSInteger)weddingDressId {
    return [self.dm executeUpdate:kSQLDelete, [NSNumber numberWithInteger:weddingDressId]];
}

- (BOOL)update:(WeddingDress *)weddingDress {
    return [self.dm executeUpdate:kSQLUpdate,
            weddingDress.sn,
            weddingDress.title,
            [NSNumber numberWithInteger:weddingDress.rent],
            [NSNumber numberWithInteger:weddingDress.status],
            [NSNumber numberWithInteger:weddingDress.handling_vender_id],
            [NSNumber numberWithInteger:weddingDress.weddingDressId]];
}


@end

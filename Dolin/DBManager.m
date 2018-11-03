//
//  DBManager.m
//  Dolin
//
//  Created by gestalt on 2018/10/22.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import "DBManager.h"
#import <FMDB/FMDB.h>

static NSString * const kDBFileName = @"dolin.db";

@interface DBManager ()
@property (nonatomic) NSString *dbFilePath;
@end

@implementation DBManager

+ (id)sharedManager {
    static DBManager *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

/**
 * Initialize the instance.
 *
 * @return Instance.
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        self.dbFilePath = [self databaseFilePath];
        
        // For debug
        NSLog(@"%@", self.dbFilePath);
        
        self.db = [self connection];
    }
    
    return  self;
}

/**
 * Initialize the instance.
 *
 * @param path Path of the database file.
 *
 * @return Instance.
 */
- (instancetype)initWithDBFilePath:(NSString *)path {
    self = [super init];
    if (self) {
        self.dbFilePath = path;
        
        // For debug
        NSLog(@"%@", self.dbFilePath);
        
        self.db = [self connection];
    }
    
    return self;
}

- (FMResultSet *)executeQuery:(NSString *)sqlString, ...{
    va_list args;
    va_start(args, sqlString);
    NSString *sql = [[NSString alloc] initWithFormat:sqlString arguments:args];
    va_end(args);
    
    return [self.db executeQuery:sql];
}

- (BOOL)executeUpdate:(NSString *)sqlString, ...{
    va_list args;
    va_start(args, sqlString);
    NSString *sql = [[NSString alloc] initWithFormat:sqlString arguments:args];
    va_end(args);
    
    return [self.db executeUpdate:sql];
}

#pragma mark - Private

/**
 * Get the database connection.
 *
 * @return Connection.
 */
- (FMDatabase *)connection {
    FMDatabase* db = [FMDatabase databaseWithPath:self.dbFilePath];
    return ([db open] ? db : nil);
}

/**
 * Get the path of database file.
 *
 * @return file path.
 */
- (NSString *)databaseFilePath {
    NSArray*  paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* dir   = [paths objectAtIndex:0];
    
    return [dir stringByAppendingPathComponent:kDBFileName];
}

@end

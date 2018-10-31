//
//  DBManager.h
//  Dolin
//
//  Created by gestalt on 2018/10/22.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject

+ (id)sharedManager;
- (instancetype)initWithDBFilePath:(NSString *)path;
- (FMResultSet *)executeQuery:(NSString *)sqlString, ...;
- (BOOL)executeUpdate:(NSString *)sqlString, ...;
@end

NS_ASSUME_NONNULL_END

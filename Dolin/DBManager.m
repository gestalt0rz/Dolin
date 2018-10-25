//
//  DBManager.m
//  Dolin
//
//  Created by gestalt on 2018/10/22.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

+ (id)sharedManager {
    static DBManager *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

@end

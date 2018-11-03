//
//  WeddingDressDAO.h
//  Dolin
//
//  Created by gestalt on 2018/10/31.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeddingDress;

NS_ASSUME_NONNULL_BEGIN

@interface WeddingDressDAO : NSObject
- (BOOL)create;
- (WeddingDress *)add:(NSString *)sn title:(NSString *)title rent:(NSInteger)rent purchase_date:(NSDate *)purchase_date purchase_price:(NSInteger)purchase_price vender_id:(NSInteger)vender_id;
- (NSArray *)find;
- (BOOL)remove:(NSInteger)weddingDressId;
- (BOOL)update:(WeddingDress *)weddingDress;
@end

NS_ASSUME_NONNULL_END

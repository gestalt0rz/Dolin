//
//  WeddingDress.h
//  Dolin
//
//  Created by gestalt on 2018/10/31.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, WeddingDressStatus){
    WD_STOCK = 0,
    WD_WASHING,
    WD_ALTERING,
    WD_RENTING
};

extern NSInteger const vDefaultVender;
extern NSInteger const vDefaultPrice;

//NS_ASSUME_NONNULL_BEGIN

@interface WeddingDress : NSObject

@property (nonatomic, readonly) NSInteger weddingDressId;
@property (nonatomic, readonly) NSString *sn;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSInteger rent;
@property (nonatomic, readonly) WeddingDressStatus status;
@property (nonatomic, readonly) NSInteger handling_vender_id;
@property (nonatomic, readonly) NSDate *purchase_date;
@property (nonatomic, readonly) NSInteger purchase_price;
@property (nonatomic, readonly) NSInteger purchase_vender_id;

+ (instancetype)weddingDressWithId:(NSInteger)weddingDressId sn:(NSString *)sn title:(NSString *)title rent:(NSInteger)rent status:(WeddingDressStatus)status handlingVender:(NSInteger)handlingVender;
- (void)setPurchase_date:(NSDate *)purchase_date purchase_price:(NSInteger)purchase_price vender_id:(NSInteger)vender_id;
@end

//NS_ASSUME_NONNULL_END

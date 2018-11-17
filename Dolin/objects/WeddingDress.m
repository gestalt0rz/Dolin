//
//  WeddingDress.m
//  Dolin
//
//  Created by gestalt on 2018/10/31.
//  Copyright © 2018年 gestalt. All rights reserved.
//

#import "WeddingDress.h"

NSInteger const vDefaultVender = 0;
NSInteger const vDefaultPrice = 0;

@interface WeddingDress ()

@property (nonatomic, readwrite) NSInteger weddingDressId;
@property (nonatomic, readwrite) NSString *sn;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSInteger rent;
@property (nonatomic, readwrite) WeddingDressStatus status;
@property (nonatomic, readwrite) NSInteger handling_vender_id;
@property (nonatomic, readwrite) NSDate *purchase_date;
@property (nonatomic, readwrite) NSInteger purchase_price;
@property (nonatomic, readwrite) NSInteger purchase_vender_id;

@end

@implementation WeddingDress

+ (instancetype)weddingDressWithId:(NSInteger)weddingDressId sn:(NSString *)sn title:(NSString *)title rent:(NSInteger)rent status:(WeddingDressStatus)status handlingVender:(NSInteger)handlingVender {
    return [[WeddingDress alloc] init:weddingDressId sn:sn title:title rent:rent status:status handlingVender:handlingVender];
}

- (void)setPurchase_date:(NSDate *)purchase_date purchase_price:(NSInteger)purchase_price vender_id:(NSInteger)vender_id {
    [self setPurchase_date:purchase_date];
    [self setPurchase_price:purchase_price];
    [self setPurchase_vender_id:vender_id];
}

#pragma mark - Private

- (instancetype)init:(NSInteger)weddingDressId sn:(NSString *)sn title:(NSString *)title rent:(NSInteger)rent status:(WeddingDressStatus)status handlingVender:(NSInteger)handlingVender {
    self = [super init];
    if (self) {
        self.weddingDressId     = weddingDressId;
        self.sn                 = sn;
        self.title              = title;
        self.rent               = rent;
        self.status             = status;
        self.handling_vender_id = handlingVender;
    }
    
    return self;
}

@end

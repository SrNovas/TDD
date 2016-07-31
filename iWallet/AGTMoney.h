//
//  AGTMoney.h
//  iWallet
//
//  Created by Adrian Perez Lopez on 20/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AGTMoney;
@class AGTBroker;

@protocol AGTMoney <NSObject>

-(id)initWithAmount:(NSInteger) amount
           currency: (NSString *) currency;

-(id<AGTMoney>) times:(NSInteger) multiplier;

-(id<AGTMoney>) plus:(AGTMoney *) other;

-(id<AGTMoney>) reduceToCurrency:(NSString*) currency withBroker:(AGTBroker*) broker;

@end

@interface AGTMoney : NSObject<AGTMoney>

@property (nonatomic, strong, readonly) NSMutableDictionary *rates;
@property (nonatomic, readonly) NSString *currency;
@property (nonatomic, strong) NSNumber *amount;

+(id) euroWithAmount:(NSInteger) amount;
+(id) dollarWithAmount:(NSInteger) amount;

@end

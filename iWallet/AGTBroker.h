//
//  AGTBroker.h
//  iWallet
//
//  Created by Adrian Perez Lopez on 25/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGTMoney.h"

@class AGTMoney;
@interface AGTBroker : NSObject

@property (nonatomic, strong) NSMutableDictionary *rates;

-(AGTMoney *) reduce:(id<AGTMoney>) money toCurrency:(NSString *) currency;

-(void) addRate:(NSInteger) rate
   fromCurrency:(NSString*)fromCurrency
     toCurrency:(NSString*)toCurrency;

-(NSString *) keyFromCurrency:(NSString*) fromCurrency
                   toCurrency:(NSString*) toCurrency;

-(void) parseJSONRates: (NSData *) json;

@end

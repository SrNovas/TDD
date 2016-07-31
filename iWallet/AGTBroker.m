//
//  AGTBroker.m
//  iWallet
//
//  Created by Adrian Perez Lopez on 25/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import "AGTBroker.h"
#import "AGTMoney.h"

@interface AGTBroker()

@end

@implementation AGTBroker

-(id) init{
    
    if(self = [super init]){
        
        _rates = [@{}mutableCopy];
        
    }
    
    return self;
    
}

-(id<AGTMoney>) reduce:(id<AGTMoney>) money
          toCurrency:(NSString *) currency{
    
    //double dispatch, cuando recibo mensaje, sé que soy broker,
    //pero no estamos seguro quien eres tú
    return [money reduceToCurrency:currency
                        withBroker:self];
    
}


-(void) addRate:(NSInteger) rate
   fromCurrency:(NSString*)fromCurrency
     toCurrency:(NSString*)toCurrency{
    
    [self.rates setObject:@(rate)
                   forKey:[self keyFromCurrency:fromCurrency
                                     toCurrency:toCurrency]];

    //La inversa
    NSNumber *invRate = @(1.0/rate);
    [self.rates setObject:invRate
                   forKey:[self keyFromCurrency:toCurrency
                                     toCurrency:fromCurrency]];
    
}

#pragma mark - utils

-(NSString *) keyFromCurrency:(NSString *) fromCurrency
                   toCurrency:(NSString *) toCurrency{
    
    return [NSString stringWithFormat:@"%@-%@", fromCurrency, toCurrency];
    
}

#pragma mark - Rates
-(void) parseJSONRates: (NSData *) json{
    
    NSError *err = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:json
                                             options:NSJSONReadingAllowFragments
                                               error:&err];
    
    if (obj != nil){
        
        //Pillamos los rates y los vamos añadiendo al broker
        
    }else{
        
        //No hemos recibido nada -> la cagamos
        [NSException raise:@"NoRAtesInJSONException"
                    format:@"JSON must carry some data!"];
        
    }
    
}
     
@end

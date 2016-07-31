//
//  AGTMoney.m
//  iWallet
//
//  Created by Adrian Perez Lopez on 20/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import "AGTMoney.h"
#import "AGTBroker.h"
#import "NSObject+GNUStepAddons.h"

@implementation AGTMoney

+(id) euroWithAmount:(NSInteger) amount{
    
    return [[AGTMoney alloc] initWithAmount:amount currency:@"EUR"];
    
}

+(id) dollarWithAmount:(NSInteger) amount{
    
    return [[AGTMoney alloc] initWithAmount:amount currency:@"USD"];
    
}

-(id)initWithAmount:(NSInteger) amount currency:(NSString *)currency{
    
    if(self = [super init]){
        
        _amount = @(amount);
        _currency = currency;
        
    }
    
    return self;
    
}

-(id<AGTMoney>) times:(NSInteger) multiplier{
    
        
    AGTMoney *newMoney = [[AGTMoney alloc]
                          initWithAmount:[self.amount integerValue] * multiplier
                          currency:self.currency];
        
    return newMoney;
    
}

-(id<AGTMoney>) reduceToCurrency:(NSString*) currency
                      withBroker:(AGTBroker*) broker{
    
    AGTMoney *result;
    
    double rate = [[broker.rates
                    objectForKey:[broker keyFromCurrency:self.currency
                                            toCurrency:currency]] doubleValue];
    
    //Comprobamos que divisa de orgen y destino son las mismas
    if([self.currency isEqual:currency]){
        
        result = self;
        
    }else if(rate == 0){
        
        //No hay tasa de conversión, excepción al canto.
        [NSException raise:@"NoConversionRateWxception"
                    format:@"Must have a conversion from %@ to %@", self.currency, currency];
        
    }else{
        
        //Tenemos conversion
        NSInteger newAmount = [self.amount integerValue] * rate;
        
        result = [[AGTMoney alloc]
                  initWithAmount:newAmount
                  currency:currency];
        
    }
    
    return result;

    
}

#pragma mark - Overwritten
-(NSString *) description{
    
    return[NSString stringWithFormat:@"<%@: %@ %@>",
           [self class], self.currency, self.amount];
    
}

-(BOOL)isEqual:(id)object{
    
    if([self.currency isEqual:[object currency]]){
        
        return [self amount] == [object amount];
        
    }else{
        
        return NO;
        
    }
    
}

-(id<AGTMoney>) plus:(AGTMoney *) other{
    
    NSInteger totalAmount = [self.amount integerValue] + [other.amount integerValue];
    
    AGTMoney *total = [[AGTMoney alloc] initWithAmount:totalAmount currency:self.currency];
    
    return total;
    
}

-(NSUInteger) hash{
    
    return [self.amount integerValue];
    
}

@end

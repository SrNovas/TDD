//
//  AGTWallet.m
//  iWallet
//
//  Created by Adrian Perez Lopez on 26/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import "AGTWallet.h"
#import "AGTMoney.h"

@interface AGTWallet()
@property (nonatomic, strong) NSMutableDictionary *moneys;
@end

@implementation AGTWallet

-(NSUInteger) count{
    
    return [self.moneys count];
    
}

//También necesito las monedas/billetes
-(NSArray *) coins{
    
    return [self.moneys allKeys];
    
}

-(id) initWithAmount:(NSInteger)amount currency:(NSString *)currency{
    
    if(self = [super init]){
        
        AGTMoney *money = [[AGTMoney alloc] initWithAmount:amount currency:currency];
        
        _moneys = [[NSMutableDictionary alloc] initWithCapacity:1];
        
        [_moneys setObject:@[money] forKey:money.currency];
        
    }
    
    return self;
    
}

-(id<AGTMoney>)plus:(AGTMoney*)money{
    
    NSMutableArray *newCoins = [self.moneys objectForKey:money.currency];
    
    if (!newCoins) {
        
        newCoins = [NSMutableArray arrayWithObject:money];
        
    }else{
        
        newCoins = [[newCoins arrayByAddingObject:money] mutableCopy];
        
    }
    
    [self.moneys setObject:newCoins forKey:money.currency];
    
    return self;
    
}

-(id<AGTMoney>) times:(NSInteger)multiplier{
    
    NSMutableDictionary *newMoneys = [[NSMutableDictionary alloc] init];
    
    //Recorro las monedas
    for (NSString *each in self.coins) {
        
        for (AGTMoney *money in [self.moneys objectForKey:each]) {
            
            AGTMoney *newMoney = [money times:multiplier];
            
            [newMoneys setObject:@[newMoney] forKey:newMoney.currency];
        
        }
    
    }
    
    self.moneys = newMoneys;
    
    return self;
    
}

-(id<AGTMoney>) reduceToCurrency:(NSString *)currency
                      withBroker:(AGTBroker *)broker{
    
    AGTMoney *result = [[AGTMoney alloc] initWithAmount:0 currency:currency];
    
    for (NSString *each in self.coins) {
        
        for (AGTMoney *money in [self.moneys objectForKey:each]) {
        
            result = [result plus:[money reduceToCurrency:currency withBroker:broker]];
        
        }
    
    }
    
    return result;
                  
}

- (id<AGTMoney>)subTotal:(NSString *)currency {
    
    AGTMoney *result =  [[AGTMoney alloc]initWithAmount:0 currency:currency];
    
    NSArray *moneys = [self.moneys objectForKey:currency];
    
    for (AGTMoney *money in moneys) {
        
        result = [result plus:money];
    
    }
    
    return result;

}

- (NSArray *)moneysCurrency:(NSString *)currency{
    
    NSArray *moneys = [self.moneys objectForKey:currency];
    
    return moneys;
}

#pragma mark - Notifications
-(void) subscribeToMemoryWarning:(NSNotificationCenter *) nc{
    
    [nc addObserver:self
           selector:@selector(dumpToDisk:)
               name:UIApplicationDidReceiveMemoryWarningNotification
             object:nil];
    
}

-(void) dumpToDisk:(NSNotification *) notification{
    
    //Guarda las cosas en disco cuando la cosa se ponga fea
    
}

@end

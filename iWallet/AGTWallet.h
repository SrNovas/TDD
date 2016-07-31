//
//  AGTWallet.h
//  iWallet
//
//  Created by Adrian Perez Lopez on 26/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>
#import "AGTMoney.h"

@interface AGTWallet : NSObject<AGTMoney>

@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic,strong)NSArray *coins;

- (NSArray *)moneysCurrency:(NSString *)currency;
- (id<AGTMoney>)subTotal:(NSString *)currency;
- (void)subscribeToMemoryWarning:(NSNotificationCenter *) nc;

@end

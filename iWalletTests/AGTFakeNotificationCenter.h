//
//  AGTFakeNotificationCenter.h
//  iWallet
//
//  Created by Adrian Perez Lopez on 27/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGTFakeNotificationCenter : NSObject

@property (nonatomic,strong)NSMutableDictionary *observers;

-(void) addObserver:(id)observer
           selector:(nonnull SEL)aSelector
               name:(nullable NSString *)aName
             object:(nullable id)anObject; //Si quito el nullable me salta un warning

@end

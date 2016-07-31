//
//  AGTFakeNotificationCenter.m
//  iWallet
//
//  Created by Adrian Perez Lopez on 27/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import "AGTFakeNotificationCenter.h"

@implementation AGTFakeNotificationCenter

-(id) init{
    
    if (self = [super init]){
        
        _observers = [NSMutableDictionary dictionary];
        
    }
    
    return self;
    
}

-(void) addObserver:(id)observer
           selector:(SEL)aSelector
               name:(NSString *)aName
             object:(id)anObject{
    
    [self.observers setObject:observer
                       forKey:aName];
    
}

@end
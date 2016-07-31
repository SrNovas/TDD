//
//  NSObject+GNUStepAddons.m
//  iWallet
//
//  Created by Adrian Perez Lopez on 25/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+GNUStepAddons.h"

@implementation NSObject (GNUStepAddons)

-(id) subclassResponsibility: (SEL)aSel{
    
    //Para saber si vo a tratar una clase o una metaclase
    char prefix = class_isMetaClass(object_getClass(self)) ? '+' : '-';
    
    [NSException raise: NSInvalidArgumentException
                format:@"%@%c%@ should be overriden by its subclass",
     NSStringFromClass([self class]), prefix, NSStringFromSelector(aSel)];
    
    return self;
    
}

@end

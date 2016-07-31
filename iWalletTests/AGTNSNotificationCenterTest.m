//
//  AGTNSNotificationCenterTest.m
//  iWallet
//
//  Created by Adrian Perez Lopez on 27/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTFakeNotificationCenter.h"
#import "AGTWallet.h"

@interface AGTNSNotificationCenterTest : XCTestCase

@end

@implementation AGTNSNotificationCenterTest

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testThatSubscribesToMemoryWarning{
    
    AGTFakeNotificationCenter *fake = [AGTFakeNotificationCenter new];
    
    AGTWallet *w = [AGTWallet new];
    
    [w subscribeToMemoryWarning:(NSNotificationCenter *)fake];
    
    NSDictionary *obs = [fake observers];
    id observer = [obs objectForKey:UIApplicationDidReceiveMemoryWarningNotification];
    
    XCTAssertEqualObjects(observer, w,
                               @"Fat object must sibscribe to UIApplicationDidReceiveMemoryWarningNotification");
    
}

@end

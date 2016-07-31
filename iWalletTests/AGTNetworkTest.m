//
//  AGTNetworkTest.m
//  iWallet
//
//  Created by Adrian Perez Lopez on 27/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTBroker.h"

@interface AGTNetworkTest : XCTestCase

@end

@implementation AGTNetworkTest

- (void)setUp {
    [super setUp];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void) testThatEmptyRateRaisesException{
    
    AGTBroker *broker = [AGTBroker new];
    
    NSData *jsonData = nil;
    
    XCTAssertThrows([broker parseJSONRates:jsonData], @"An empty json should raise exception");
    
}

@end

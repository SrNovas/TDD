//
//  AGTMoneyTest.m
//  iWallet
//
//  Created by Adrian Perez Lopez on 25/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import <XCTest/XCTest.h>
#import"AGTMoney.h"
#import "AGTBroker.h"

@interface AGTMoneyTest : XCTestCase

@end

@implementation AGTMoneyTest

-(void) testCurrencies{
    
    XCTAssertEqualObjects(@"EUR", [[AGTMoney euroWithAmount:1] currency],
                          @"The currency of euros should be EUR");
    
    XCTAssertEqualObjects(@"USD", [[AGTMoney dollarWithAmount:1] currency],
                          @"The currency of $1 should be USD");
    
}

-(void)testMultiplication{
    
    AGTMoney *euro = [AGTMoney euroWithAmount:5];
    AGTMoney *ten = [AGTMoney euroWithAmount:10];
    AGTMoney *total = [euro times:2];
    
    AGTMoney *dollar = [AGTMoney dollarWithAmount:5];
    AGTMoney *tenDollars = [AGTMoney dollarWithAmount:10];
    AGTMoney *totalDollars = [dollar times:2];
    
    //Esto para euros
    XCTAssertEqualObjects(total, ten, @"5€*2 should be 10");
 
    //Y ahora para los dolares
    XCTAssertEqualObjects(totalDollars, tenDollars, @"5$*2 should be 10");
    
}

-(void)testEquality{
    
    AGTMoney *five = [AGTMoney euroWithAmount:5];
    AGTMoney *ten = [AGTMoney euroWithAmount:10];
    AGTMoney *total = [five times:2];
    
    XCTAssertEqualObjects(ten, total, @"Equivalent objects should be equal!");
    XCTAssertEqualObjects([AGTMoney dollarWithAmount:4], [[AGTMoney dollarWithAmount:2] times:2], @"Equivalent objects should be equal!");
    
    //Generates a failure when expression == true, en este caso si objetos no equivalentes.
    //Tiro de isEqual de mi AGTMoney
    XCTAssertFalse([total isEqual:five], @"Non equivalent objects should NOT be equal!");
    
    
}

-(void) testHash{
    
    AGTMoney *a = [AGTMoney euroWithAmount:2];
    AGTMoney *b = [AGTMoney euroWithAmount:2];
    
    XCTAssertEqual([a hash], [b hash], @"Equal objects must have same hash");
    XCTAssertEqual([[AGTMoney dollarWithAmount:1]hash], [[AGTMoney dollarWithAmount:1]hash],
                   @"Equal objects must have same hash");
    
}

-(void) testAmountStorage{
    
    AGTMoney *euro = [AGTMoney euroWithAmount:2];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    //performSelector no devuelve nada que no sea un objeto
    XCTAssertEqual(2, [[euro performSelector:@selector(amount)]integerValue],
                   @"The value retrieved should be the same as the stored");
#pragma clang diagnostic pop
    
    XCTAssertEqual(2, [[[AGTMoney dollarWithAmount:2]performSelector:@selector(amount)]integerValue], @"The value retrieved should be the same as the stored");
    
}

//10$ != 10€
-(void) testDifferentCurrencies{
    
    AGTMoney *euro = [AGTMoney euroWithAmount:1];
    AGTMoney *dollar = [AGTMoney dollarWithAmount:1];
    
    XCTAssertNotEqualObjects(euro, dollar, @"Different currencies should not be equal!");
    
}

-(void) testSimpleAddition{
    
    XCTAssertEqualObjects([[AGTMoney dollarWithAmount:5] plus:
                           [AGTMoney dollarWithAmount:5]],
                           [AGTMoney dollarWithAmount:10],
                           @"$5 + $5 = $10");
    
}

-(void) testThatHashIsAmount{
    
    AGTMoney *one = [AGTMoney dollarWithAmount:1];
    
    XCTAssertEqual([one hash], 1, @"The hash must be the same as the amount");
    
}

-(void) testDescription{
    
    AGTMoney *one = [AGTMoney dollarWithAmount:1];
    NSString *desc = @"<AGTMoney: USD 1>";
    
    XCTAssertEqualObjects(desc, [one description], @"Description must match template");
    
}

@end

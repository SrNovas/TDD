//
//  AGTControllerTest.m
//  iWallet
//
//  Created by Adrian Perez Lopez on 27/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGTSimpleViewController.h"
#import "AGTWalletTableViewController.h"
#import "AGTWallet.h"

@interface AGTControllerTest : XCTestCase
@property (nonatomic, strong) AGTSimpleViewController *simpleVC;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) AGTWalletTableViewController *walletVC;
@property(nonatomic, strong) AGTWallet *wallet;
@end

@implementation AGTControllerTest

- (void)setUp {
    [super setUp];
    
    //Creamos el entorno de laboratorio
    self.simpleVC = [[AGTSimpleViewController alloc] initWithNibName:nil bundle:nil];
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button setTitle:@"Hola" forState:UIControlStateNormal];
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.simpleVC.displayLabel = self.label;
    
    self.wallet = [[AGTWallet alloc] initWithAmount:1 currency:@"USD"];
    [self.wallet plus:[AGTMoney euroWithAmount:1]];
    
    self.walletVC = [[AGTWalletTableViewController alloc] initWithModel: self.wallet];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    //Lo destruimos
    self.simpleVC = nil;
    self.button = nil;
    self.label = nil;
    
}

-(void) testThatTextOnLabelIsEqualToTextOnButton{
    
    //Mandamos mensaje
    [self.simpleVC displayText:self.button];
    
    //Comprobamos que etiqueta y botón tienen el mismo texto.
    XCTAssertEqualObjects(self.button.titleLabel.text,
                          self.label.text, @"Button and label should have the same text");
    
}

-(void) testThatTablehasOneSection{
    
    NSInteger sections = [self.walletVC numberOfSectionsInTableView:nil];
    
    XCTAssertEqual([self.walletVC tableView:nil numberOfRowsInSection:sections], 1,
                   @"There can only be one!");
    
}

-(void) testThatNumberOfcellsIsNumberOfMoneyPlusOne{
    
    NSString *currency = [self.wallet.coins objectAtIndex:0];
    
    NSArray *moneys = [self.wallet moneysCurrency: currency];
    
    XCTAssertEqual([moneys count] + 1,
                   [self.walletVC tableView:nil numberOfRowsInSection:0],
                   @"Number of cells is the number of money plus 1 (the total)");
    
}

//El número de secciones debe ser el número de "monedas" + 1
- (void)testThatNumberOfSectionsIsNumberOfCurrenciesPlusOne {
    
    NSUInteger sections = [self.walletVC numberOfSectionsInTableView:nil];
    
    XCTAssertEqual(sections, self.wallet.count + 1,
                   @"Number of sections should be the number of currencies plus one");
}

@end

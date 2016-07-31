//
//  AGTWalletTableViewController.h
//  iWallet
//
//  Created by Adrian Perez Lopez on 27/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTWallet;

@interface AGTWalletTableViewController : UITableViewController

-(id) initWithModel:(AGTWallet *) model;

@end

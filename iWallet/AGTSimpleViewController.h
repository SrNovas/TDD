//
//  AGTSimpleViewController.h
//  iWallet
//
//  Created by Adrian Perez Lopez on 27/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGTSimpleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

- (IBAction)displayText:(id)sender;

@end

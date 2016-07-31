//
//  AGTWalletTableViewController.m
//  iWallet
//
//  Created by Adrian Perez Lopez on 27/7/16.
//  Copyright © 2016 NovasFactory. All rights reserved.
//

#import "AGTWalletTableViewController.h"
#import "AGTWallet.h"
#import "AGTBroker.h"

static NSString *cellID = @"Identifier";

@interface AGTWalletTableViewController ()

@property(nonatomic, strong) AGTWallet *model;

@end

@implementation AGTWalletTableViewController

-(id) initWithModel:(AGTWallet *)model{
    
    if(self = [super initWithStyle:UITableViewStylePlain]){
        
        _model = model;
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //El título
    self.title = @"iWallet";
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.model.coins count] + 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section < [self.model.coins count]) {
        
        NSArray *array = [self.model moneysCurrency:[self.model.coins objectAtIndex:section]];
        
        return [array count] + 1;
        
    }
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]
                             initWithStyle:UITableViewCellStyleSubtitle
                             reuseIdentifier:cellID];
    
    AGTBroker *broker = [AGTBroker new];
    
    [broker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    if (indexPath.section < [self.model.coins count]) {
        
        NSString *currency = [self.model.coins objectAtIndex:indexPath.section];
        
        NSArray *moneys = [self.model moneysCurrency:currency];
        
        if (indexPath.row < [moneys count]) {
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@",
                                   [moneys[indexPath.row] description]];
        
        }else{
            
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:20]];
            
            cell.textLabel.text = [[self.model subTotal:currency] description];
            
            cell.detailTextLabel.text = @"SubTotal";
        }
        
    }else{
        
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:20]];
        
        cell.backgroundColor = [UIColor greenColor];
        
        cell.textLabel.text = [[self.model reduceToCurrency:@"EUR"
                                                 withBroker:broker] description];
        
        cell.detailTextLabel.text = @"Total";
    
    }
    
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section < [self.model count]) {
        
        return [self.model.coins objectAtIndex:section];
    
    }
    
    return @"Gran Total";
    
}


























@end

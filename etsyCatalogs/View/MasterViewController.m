//
//  MasterViewController.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController
            
- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(420.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *pageUpButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(previousPage)];
    self.navigationItem.leftBarButtonItem = pageUpButton;
    UIBarButtonItem *pageDownButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(nextPage)];
    self.navigationItem.rightBarButtonItem = pageDownButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.navigationItem.titleView.frame = self.searchText.frame;

    [self.loadingView stopAnimating];
    self.loadingView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nextPage
{
    [self.catalogsDatasource fastForwardList];
}

- (void)previousPage
{
    [self.catalogsDatasource rewindList];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        if (self.catalogsDatasource.catalogResults.count) {
            DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
            CatalogItem *item = [self.catalogsDatasource.catalogResults getCatalogItemByIndex:indexPath.row];
            [controller setCatalogDetail:item];
            controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
            controller.navigationItem.leftItemsSupplementBackButton = YES;
        }
        
    }
}


#pragma mark - UITextFieldDelegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *keywords = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![keywords isEqualToString:@""]) {
        [self.catalogsDatasource getInitialListForKeywords:keywords];
        self.loadingView.hidden = NO;
        [self.loadingView startAnimating];
    }
    
    [textField resignFirstResponder];
    
    return YES;
}



#pragma mark - CatalogDataSourceDelegate methods
- (void)catalogsDatasource:(CatalogsDatasource *)sender DidFailWithError:(NSError *)error
{
    
}

- (void)catalogsDatasource:(CatalogsDatasource *)sender DidLoadListingCatalogs:(int)count
{
    if (count) {
        [self.loadingView stopAnimating];
        self.loadingView.hidden = YES;
    }
}


@end

//
//  MasterViewController.h
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CatalogsDatasource.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <UITextFieldDelegate, CatalogsDatasourceDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) IBOutlet UITextField *searchText;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@property (strong, nonatomic) IBOutlet CatalogsDatasource *catalogsDatasource;


@end


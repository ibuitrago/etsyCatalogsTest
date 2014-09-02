//
//  CatalogsDatasource.h
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "UIImageView+AFNetworking.h"

#import "ListingTableViewCell.h"

#import "CatalogItem.h"
#import "CatalogListingImage.h"
#import "CatalogResult.h"

#import "CatalogServices.h"


@protocol CatalogsDatasourceDelegate;


@interface CatalogsDatasource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) IBOutlet UITableView *listingsTable;

@property(nonatomic, strong) CatalogResult *catalogResults;

@property(nonatomic, weak) IBOutlet id<CatalogsDatasourceDelegate> delegate;

- (void)rewindList;
- (void)fastForwardList;
- (void)getInitialListForKeywords:(NSString *)keywords;


@end


@protocol CatalogsDatasourceDelegate <NSObject>

@optional
- (void)catalogsDatasource:(CatalogsDatasource *)sender DidLoadListingCatalogs:(int)count;
- (void)catalogsDatasource:(CatalogsDatasource *)sender DidFailWithError:(NSError *)error;

@end
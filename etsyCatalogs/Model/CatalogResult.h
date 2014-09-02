//
//  CatalogResult.h
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/2/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResultPagination.h"
#import "CatalogItem.h"


@interface CatalogResult : NSObject

@property(nonatomic, strong) ResultPagination *pagination;

/// This method will initialize and set all the pagination info for the results
- (void)insertPaginationInfo:(NSDictionary *)dictionary withCount:(int)count;

/// This method is for inserting new catalog items in the catalogs result array
- (void)insertCatalogItem:(NSDictionary *)dictionary;

/// Method to get a catalog, given by its listing id, from the array, otherwise return nil
- (CatalogItem *)getCatalogItemWithListingID:(long long)listingId;

/// Method to get a catalog in the given position into the catalogs result array
- (CatalogItem *)getCatalogItemByIndex:(int)index;

/// Method to get a copy of the catalogs result array
- (NSMutableArray *)getAllCatalogItemsCopy;

/// Return the count of registries currently in the catalogs result array
- (int)count;
@end

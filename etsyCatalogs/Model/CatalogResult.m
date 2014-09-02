//
//  CatalogResult.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/2/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "CatalogResult.h"


@interface CatalogResult()

@property(nonatomic, strong) NSMutableArray *listingResults;

@end


@implementation CatalogResult


- (id)init
{
    self = [super init];
    if (self) {
        // We need to init the array to be sure it will be there when we need it
        self.listingResults = [NSMutableArray array];
    }
    
    return self;
}


- (void)insertPaginationInfo:(NSDictionary *)dictionary withCount:(int)count
{
    self.pagination = [[ResultPagination alloc] init];
    self.pagination.pageLimit = [[dictionary objectForKey:@"effective_limit"] intValue];
    self.pagination.currentOffset = [[dictionary objectForKey:@"effective_offset"] intValue];
    self.pagination.nextOffset = [[dictionary objectForKey:@"next_offset"] intValue];
    self.pagination.currentPage = [[dictionary objectForKey:@"effective_page"] intValue];
    self.pagination.nextPage = [[dictionary objectForKey:@"next_page"] intValue];
    self.pagination.totalCount = count;
}

- (void)insertCatalogItem:(NSDictionary *)dictionary
{
    CatalogItem *item = [CatalogItem createCatalogItemFromDictionary:dictionary];

    [self.listingResults addObject:item];
}

- (CatalogItem *)getCatalogItemWithListingID:(long long)listingId
{
    for (CatalogItem *item in self.listingResults) {
        if (item.listingID == listingId) {
            return item;
        }
    }
    
    return nil;
}

- (CatalogItem *)getCatalogItemByIndex:(int)index
{
    if (index < self.listingResults.count) {
        return [self.listingResults objectAtIndex:index];
    } else {
        return nil;
    }
}

- (NSMutableArray *)getAllCatalogItemsCopy
{
    return [self.listingResults copy];
}

- (int)count
{
    return self.listingResults.count;
}

@end

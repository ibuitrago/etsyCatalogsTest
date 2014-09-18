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
    NSMutableDictionary *paginationDict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [paginationDict setValue:[NSNumber numberWithInt:count] forKey:@"count"];
    self.pagination = [ResultPagination createResultPaginationFromDictionary:paginationDict];
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

- (CatalogItem *)getCatalogItemByIndex:(NSInteger)index
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

- (NSInteger)count
{
    return self.listingResults.count;
}

- (int)findIndexOfItem:(CatalogItem *)item
{
    for (int i  = 0; i < self.listingResults.count; i++) {
        CatalogItem *check = [self.listingResults objectAtIndex:i];
        if (item == check) {
            return i;
        }
    }
    
    return -1;
}

@end

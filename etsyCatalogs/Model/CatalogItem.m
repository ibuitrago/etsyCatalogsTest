//
//  CatalogItem.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "CatalogItem.h"

@implementation CatalogItem

+ (CatalogItem *)createCatalogItemFromDictionary:(NSDictionary *)dictionary
{
    CatalogItem *item = [[CatalogItem alloc] init];
    
    item.listingID = [[dictionary objectForKey:@"listing_id"] longLongValue];
    item.userID = [[dictionary objectForKey:@"user_id"] longLongValue];
    item.categoryID = [[dictionary objectForKey:@"category_id"] longLongValue];
    item.itemTitle = [dictionary objectForKey:@"title"];
    item.itemDescription = [dictionary objectForKey:@"description"];
    item.currency = [dictionary objectForKey:@"currency_code"];
    item.price = [[dictionary objectForKey:@"price"] doubleValue];
    item.quantity = [[dictionary objectForKey:@"quantity"] intValue];
    item.url = [dictionary objectForKey:@"url"];
    item.whenMade = [dictionary objectForKey:@"when_made"];
    item.images = [NSMutableArray array];

    return item;
}

@end

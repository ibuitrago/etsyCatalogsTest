//
//  CatalogItem.h
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CatalogListingImage.h"


@interface CatalogItem : NSObject

@property (nonatomic, assign) long long listingID;
@property (nonatomic, assign) long long userID;
@property (nonatomic, assign) long long categoryID;
@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) int quantity;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *whenMade;
@property (nonatomic, strong) NSMutableArray *images;


/// This method will create a new CatalogItem using the data given in the dictionary,
/// and will return it.
+ (CatalogItem *)createCatalogItemFromDictionary:(NSDictionary *)dictionary;


@end

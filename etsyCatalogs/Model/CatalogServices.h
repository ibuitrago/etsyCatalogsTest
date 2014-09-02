//
//  CatalogServices.h
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "ModelUtilities.h"

#import "CatalogItem.h"
#import "CatalogListingImage.h"
#import "ResultPagination.h"
#import "CatalogResult.h"


@interface CatalogServices : NSObject

+ (void)getCatalogListingsByWeywords:(NSString *)keywords inPage:(int)nPage withBlock:(void (^)(CatalogResult *catalogResults, NSError *error))block;

+ (void)getListingImagesForListingID:(long long)listingId withBlock:(void (^)(NSArray *imagesResult, NSError *error))block;


@end

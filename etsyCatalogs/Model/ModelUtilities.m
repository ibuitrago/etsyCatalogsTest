//
//  ModelUtilities.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "ModelUtilities.h"

@implementation ModelUtilities

NSString * const kApiKey = @"wzqjy1uwfvsb69sgnr2j1f3y";

const int kPageItemsize = 20;

NSString * const kServicesUrl = @"https://openapi.etsy.com/v2/";
NSString * const kListingService = @"listings/active?api_key=%@&keywords='%@'&offset=%d&limit=%d";
NSString * const kListingImagesService = @"listings/%lld/images?api_key=%@";

NSString * const kListingModelErrorDomain = @"com.ihonahan.etsycatalogs.listing";

@end

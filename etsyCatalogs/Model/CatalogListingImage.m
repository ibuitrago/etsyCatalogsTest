//
//  CatalogListingImage.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "CatalogListingImage.h"

@implementation CatalogListingImage


+ (CatalogListingImage *)createCatalogListingImageFromDictionary:(NSDictionary *)dictionary
{
    CatalogListingImage *item = [[CatalogListingImage alloc] init];
    
    item.listingID = [[dictionary objectForKey:@"listing_id"] longLongValue];
    item.listingImageID = [[dictionary objectForKey:@"listing_image_id"] longLongValue];
    item.hexCode = [dictionary objectForKey:@"hex_code"];
    item.red = [[dictionary objectForKey:@"red"] intValue];
    item.green = [[dictionary objectForKey:@"green"] intValue];
    item.blue = [[dictionary objectForKey:@"blue"] intValue];
    item.hue = [[dictionary objectForKey:@"hue"] intValue];
    item.saturation = [[dictionary objectForKey:@"saturation"] intValue];
    item.brightness = [[dictionary objectForKey:@"brightness"] intValue];
    item.isBlackAndWhite = [[dictionary objectForKey:@"is_black_and_white"] boolValue];
    item.fullWidth = [[dictionary objectForKey:@"full_width"] doubleValue];
    item.fullHeight = [[dictionary objectForKey:@"full_height"] doubleValue];
    item.url75x75 = [dictionary objectForKey:@"url_75x75"];
    item.url170x135 = [dictionary objectForKey:@"url_170x135"];
    item.url570xN = [dictionary objectForKey:@"url_570xN"];
    item.urlFullSize = [dictionary objectForKey:@"url_fullxfull"];
    
    return item;
}
@end

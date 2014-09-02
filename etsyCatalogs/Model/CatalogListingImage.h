//
//  CatalogListingImage.h
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatalogListingImage : NSObject

@property (nonatomic, assign) long long listingID;
@property (nonatomic, assign) long long listingImageID;
@property (nonatomic, strong) NSString *hexCode;
@property (nonatomic, assign) int red;
@property (nonatomic, assign) int green;
@property (nonatomic, assign) int blue;
@property (nonatomic, assign) int hue;
@property (nonatomic, assign) int saturation;
@property (nonatomic, assign) int brightness;
@property (nonatomic, assign) BOOL isBlackAndWhite;
@property (nonatomic, assign) double fullWidth;
@property (nonatomic, assign) double fullHeight;
@property (nonatomic, strong) NSString *url75x75;
@property (nonatomic, strong) NSString *url170x135;
@property (nonatomic, strong) NSString *url570xN;
@property (nonatomic, strong) NSString *urlFullSize;


+ (CatalogListingImage *)createCatalogListingImageFromDictionary:(NSDictionary *)dictionary;


@end

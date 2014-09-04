//
//  UIImageView+CatalogListinImage.h
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/4/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "UIImageView+AFNetworking.h"

#import "CatalogListingImage.h"


@interface UIImageView (CatalogListinImage)



+ (UIImageView *)initWithCatalogListingImage:(CatalogListingImage *)image atOriginPoint:(CGPoint)point;



@end

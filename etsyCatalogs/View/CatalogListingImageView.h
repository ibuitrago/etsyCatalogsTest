//
//  CatalogListingImageView.h
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/9/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+AFNetworking.h"

#import "CatalogListingImage.h"


@interface CatalogListingImageView : UIImageView


- (id)initWithCatalogListingImage:(CatalogListingImage *)image atOriginPoint:(CGPoint)point;


@end

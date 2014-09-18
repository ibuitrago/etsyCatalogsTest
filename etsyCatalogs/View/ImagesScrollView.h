//
//  ImagesScrollView.h
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/4/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CatalogListingImage.h"

#import "CatalogListingImageView.h"


@interface ImagesScrollView : UIScrollView

- (void)buildImagesFromArray:(NSArray *)imagesArray adjustHeight:(BOOL)heightAdjust;

@end

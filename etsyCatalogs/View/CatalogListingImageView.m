//
//  CatalogListingImageView.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/9/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "CatalogListingImageView.h"


static double kPreferredImageWidth = 285.0;


@implementation CatalogListingImageView


- (id)initWithCatalogListingImage:(CatalogListingImage *)image atOriginPoint:(CGPoint)point
{
    self = [super init];
    
    if (self) {
        double scale = 1.0;
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES) {
            scale = [[UIScreen mainScreen] scale];
        }
        double w = image.fullWidth / scale;
        double h = image.fullHeight / scale;
        
        double imgW = kPreferredImageWidth;
        double imgH = (h * imgW) / w;
        
        self.frame = CGRectMake(point.x,
                                     point.y,
                                     imgW,
                                     imgH);
        
        // Create the image async
        [self setImageWithURL:[NSURL URLWithString:image.urlFullSize]];
    }

    
    return self;
}

@end

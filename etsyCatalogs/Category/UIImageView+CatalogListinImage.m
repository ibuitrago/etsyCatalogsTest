//
//  UIImageView+CatalogListinImage.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/4/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "UIImageView+CatalogListinImage.h"


static double kPreferredImageWidth = 285.0;


@implementation UIImageView (CatalogListinImage)


+ (UIImageView *)initWithCatalogListingImage:(CatalogListingImage *)image atOriginPoint:(CGPoint)point
{
    double scale = 1.0;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES) {
        scale = [[UIScreen mainScreen] scale];
    }
    double w = image.fullWidth / scale;
    double h = image.fullHeight / scale;
    
    double imgW = kPreferredImageWidth;
    double imgH = (h * imgW) / w;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    if (imageView) {
        imageView.frame = CGRectMake(point.x,
                                     point.y,
                                     imgW,
                                     imgH);
        
        // Create the image async
        [imageView setImageWithURL:[NSURL URLWithString:image.urlFullSize]];
    }

    return imageView;
}
@end

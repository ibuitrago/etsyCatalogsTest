//
//  ImagesScrollView.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/4/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "ImagesScrollView.h"


@implementation ImagesScrollView

- (void)buildImagesFromArray:(NSArray *)imagesArray adjustHeight:(BOOL)heightAdjust
{
    double x = 4;
    double y = 0;
    int i = 0;
    double maxHeight = 0;
    for (i = 0; i < imagesArray.count; i++) {
        // So, let's get the image info
        CatalogListingImage *image = [imagesArray objectAtIndex:i];
        
        UIImageView *imageView = [[CatalogListingImageView alloc] initWithCatalogListingImage:image atOriginPoint:CGPointMake(x, y)];
        
        // Then, if exists, add it to the scroller and make the calcs to the next one
        if (imageView) {
            [self addSubview:imageView];
            
            double imgW = imageView.frame.size.width;
            double imgH = imageView.frame.size.width;
            
            x += imgW + 4;
            if (imgH > maxHeight) {
                maxHeight = imgH;
            }
        }
        
    }
    
    // If the scroll is to be adjusted in height, We need to resize the image scroller to display all the images height with no vertical scrolling
    if (heightAdjust) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.frame = CGRectMake(self.frame.origin.x,
                                              self.frame.origin.y,
                                              self.frame.size.width,
                                              maxHeight);
        self.contentSize = CGSizeMake(x, maxHeight);
    }

}

@end

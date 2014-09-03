//
//  DetailViewController.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "DetailViewController.h"


static double kPreferredImageWidth = 285.0;

@interface DetailViewController ()

@end

@implementation DetailViewController
            
#pragma mark - Managing the detail item


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureDetailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configureDetailView
{
    self.titleLabel.text = self.detailItem.itemTitle;
    self.priceTitleLabel.text = NSLocalizedString(@"Price: $", nil);
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f", self.detailItem.price];
    self.descriptionView.text = self.detailItem.itemDescription;
    
    // Now we create the images and put them into the images scroller
    // according to the images found on the images array in the item
    double x = 4;
    double y = 0;
    int i = 0;
    double maxHeight = 0;
    for (i = 0; i < self.detailItem.images.count; i++) {
        // So, let's get the image info
        CatalogListingImage *image0 = [self.detailItem.images objectAtIndex:i];
        
        // Then, calculate the image size based on the constrained width
        double scale = 1.0;
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES) {
            scale = [[UIScreen mainScreen] scale];
        }
        double w = image0.fullWidth / scale;
        double h = image0.fullHeight / scale;
        
        double imgW = kPreferredImageWidth;
        double imgH = (h * imgW) / w;
        
        // At the end we create our image
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(x,
                                     y,
                                     imgW,
                                     imgH);
        
        // Create the image async
        [imageView setImageWithURL:[NSURL URLWithString:image0.urlFullSize]];
        
        // Then add it to the scroller and make the calcs to the next onw
        [self.imageScroller addSubview:imageView];
        
        x += imgW + 4;
        if (imgH > maxHeight) {
            maxHeight = imgH;
        }
    }
    
    // We need to resize the image scroller to display all the images height with no vertical scrolling
    self.imageScroller.frame = CGRectMake(self.imageScroller.frame.origin.x,
                                          self.imageScroller.frame.origin.y,
                                          self.imageScroller.frame.size.width,
                                          maxHeight);
    self.imageScroller.contentSize = CGSizeMake(x, maxHeight);
}



@end

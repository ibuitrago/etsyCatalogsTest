//
//  DetailViewController.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
            
#pragma mark - Managing the detail item


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setCatalogDetail:(CatalogItem *)theCatalog
{
    self.detailItem = theCatalog;
    
    self.titleLabel.text = self.detailItem.itemTitle;
    self.priceTitleLabel.text = NSLocalizedString(@"Price: $", nil);
    self.priceLabel.text = [NSString stringWithFormat:@"%f", self.detailItem.price];
    self.descriptionView.text = self.detailItem.itemDescription;
    if (self.detailItem.images.count) {
        CatalogListingImage *image0 = [self.detailItem.images objectAtIndex:0];
        double scale = 1.0;
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES) {
            scale = [[UIScreen mainScreen] scale];
        }
        double w = image0.fullWidth / scale;
        double h = image0.fullHeight / scale;
        
        double imgW = self.imageView.frame.size.width;
        double imgH = (h * imgW) / w;
        
        self.imageView.frame = CGRectMake(self.imageView.frame.origin.x,
                                          self.imageView.frame.origin.y,
                                          imgW ,
                                          imgH);
        [self.imageView setImageWithURL:[NSURL URLWithString:image0.urlFullSize]];
    }
}



@end

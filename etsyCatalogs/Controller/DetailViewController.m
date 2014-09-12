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
    [self.imageScroller buildImagesFromArray:self.detailItem.images adjustHeight:YES];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    self.contentScroller.contentSize = CGSizeMake(self.contentView.frame.size.width, self.contentView.frame.size.height);
}




@end

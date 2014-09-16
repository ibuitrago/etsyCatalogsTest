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



- (void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(logViewsSizes:) withObject:@"---ViewDidAppear--->" afterDelay:1];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.contentScroller.contentSize = self.contentView.frame.size;
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



- (void)logViewsSizes:(NSString *)message
{
    NSLog(@"%@", message);
    
    NSLog(@"Scroller frame: x: %f | y: %f | w: %f | h: %f",
          self.contentScroller.frame.origin.x,
          self.contentScroller.frame.origin.y,
          self.contentScroller.frame.size.width,
          self.contentScroller.frame.size.height);
    
    NSLog(@"Scroller content size: w: %f | h: %f",
          self.contentScroller.contentSize.width,
          self.contentScroller.contentSize.height);
    
    NSLog(@"Content frame: x: %f | y: %f | w: %f | h: %f",
          self.contentView.frame.origin.x,
          self.contentView.frame.origin.y,
          self.contentView.frame.size.width,
          self.contentView.frame.size.height);
}




@end

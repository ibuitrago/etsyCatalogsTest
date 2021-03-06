//
//  DetailViewController.h
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+AFNetworking.h"

#import "CatalogItem.h"
#import "CatalogListingImage.h"


@interface DetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIScrollView *contentScroller;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *imageScroller;
@property (nonatomic, strong) IBOutlet UILabel *priceTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionView;


@property (nonatomic, strong) CatalogItem *detailItem;



@end


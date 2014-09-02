//
//  ListingTableViewCell.h
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListingTableViewCellDelegate;

@interface ListingTableViewCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UIImageView *listingImage;
@property(nonatomic, strong) IBOutlet UILabel *summaryLabel;
@property(nonatomic, strong) IBOutlet UIButton *detailsButton;

@property(weak) id<ListingTableViewCellDelegate> delegate;

- (IBAction)tapUpDetails:(id)sender;

@end

@protocol ListingTableViewCellDelegate <NSObject>

@optional
- (void)listingTableViewCellDelegateDidTappedDetail:(id)sender;

@end
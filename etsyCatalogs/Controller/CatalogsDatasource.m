//
//  CatalogsDatasource.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "CatalogsDatasource.h"


@interface CatalogsDatasource()

@property(nonatomic, strong) NSString *currentKeywords;
@property(nonatomic, assign) int currentPage;

@end


@implementation CatalogsDatasource


- (void)rewindList
{
    if (self.currentPage > 0) {
        // If the previous page exists then we proceed
        self.currentPage--;
        [self getListPage];
    } else {
        // If we cannot go to previous page, we need to report to the delegate
        [self reportErrorToDelegate:nil];
    }
}

- (void)fastForwardList
{
    // Here we need to control if we have results and also if there's a next page
    BOOL valid = NO;
    if (self.catalogResults && self.catalogResults.pagination) {
        if (self.catalogResults.pagination.nextPage > self.currentPage) {
            // If we have next page, we proceed
            self.currentPage++;
            [self getListPage];
            valid = YES;
        }
    }
    
    // In case the next page is not valid or doesn't exists, we need to report to the delegate
    if (!valid) {
        [self reportErrorToDelegate:nil];
    }
}

- (void)getInitialListForKeywords:(NSString *)keywords
{
    self.currentPage = 0;
    self.currentKeywords = keywords;
    [self getListPage];
}

- (void)getListPage
{
    self.catalogResults = nil;
    [self.listingsTable reloadData];
    [CatalogServices getCatalogListingsByWeywords:self.currentKeywords inPage:self.currentPage withBlock:^(CatalogResult *catalogResults, NSError *error) {
        if (error) {
            // Report the error
            [self reportErrorToDelegate:error];
        } else {
            // Everything went just OK, we reload the table and report to the delegate
            self.catalogResults = catalogResults;
            [self.listingsTable reloadData];
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(catalogsDatasource:DidLoadListingCatalogs:)]) {
                    [self.delegate catalogsDatasource:self DidLoadListingCatalogs:self.catalogResults.count];
                }
            }
        }
    }];
}

/// Method that encapsulates the logic to call the delegate's method when we have to report an error
- (void)reportErrorToDelegate:(NSError *)error
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(catalogsDatasource:DidFailWithError:)]) {
            [self.delegate catalogsDatasource:self DidFailWithError:error];
        }
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.catalogResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListingTableViewCell" forIndexPath:indexPath];
    
    UILabel *titleCell = (UILabel *)[cell viewWithTag:100];
    UIImageView *imageCell = (UIImageView *)[cell viewWithTag:110];
    UIButton *buttonCell = (UIButton *)[cell viewWithTag:120];
    
    buttonCell.tag = indexPath.row;
    [buttonCell addTarget:self action:@selector(tapUpDetails:) forControlEvents:UIControlEventTouchUpInside];
    
    CatalogItem *catalogItem = [self.catalogResults getCatalogItemByIndex:indexPath.row];
    titleCell.text = catalogItem.itemTitle;
    if (catalogItem.images.count) {
        CatalogListingImage *catalogImage = [catalogItem.images objectAtIndex:0];
        NSString *urlImg = catalogImage.url170x135;
        [imageCell setImageWithURL:[NSURL URLWithString:urlImg]];
    } else {
        [self initialSetOfImagesForListingID:catalogItem.listingID];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // We are not allowing selection in the rows of the catalogs listing table
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:NO];
}


#pragma mark - Private methods
- (IBAction)tapUpDetails:(id)sender
{
    UIButton *detailButton = (UIButton *)sender;
    int row = detailButton.tag;
    
    CatalogItem *catalogItem = [self.catalogResults getCatalogItemByIndex:row];
    
    if (catalogItem && self.delegate) {
        if ([self.delegate respondsToSelector:@selector(catalogsDatasource:selectedDetailsForListingItem:)]) {
            [self.delegate catalogsDatasource:self selectedDetailsForListingItem:catalogItem];
        }
    }
}


- (void)initialSetOfImagesForListingID:(long long)listingId
{
    [CatalogServices getListingImagesForListingID:listingId withBlock:^(NSArray *imagesResult, NSError *error) {
        // Let's check if everything went OK
        if (error) {
            [self reportErrorToDelegate:error];
        } else {
            if (imagesResult.count) {
                CatalogListingImage *img0 = [imagesResult objectAtIndex:0];
                CatalogItem *itemFound = [self.catalogResults getCatalogItemWithListingID:img0.listingID];
                if (itemFound) {
                    // We just can work only if we have found the catalog item
                    itemFound.images = [NSMutableArray arrayWithArray:imagesResult];
                    
                    int row = [self.catalogResults findIndexOfItem:itemFound];
                    if (row >= 0) {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                        
                        // Now we get the cell of the given listingID and display the loaded image
                        UITableViewCell *cell = [self.listingsTable cellForRowAtIndexPath:indexPath];
                        UIImageView *imageCell = (UIImageView *)[cell viewWithTag:110];
                        [imageCell setImageWithURL:[NSURL URLWithString:img0.url170x135]];
                    }
                }
            }
        }
    }];
}


@end

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
    self.currentPage--;
    [self getListPage];
}

- (void)fastForwardList
{
    self.currentPage++;
    [self getListPage];
}

- (void)getInitialListForKeywords:(NSString *)keywords
{
    self.currentPage = 0;
    self.currentKeywords = keywords;
    [self getListPage];
}

- (void)getListPage
{
    [CatalogServices getCatalogListingsByWeywords:self.currentKeywords inPage:self.currentPage withBlock:^(CatalogResult *catalogResults, NSError *error) {
        if (error) {
            // Report the error
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(catalogsDatasource:DidFailWithError:)]) {
                    [self.delegate catalogsDatasource:self DidFailWithError:error];
                }
            }
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



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.catalogResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListingTableViewCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[ListingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListingTableViewCell"];
    }
    
    CatalogItem *catalogItem = [self.catalogResults getCatalogItemByIndex:indexPath.row];
    cell.summaryLabel.text = catalogItem.itemTitle;
    if (catalogItem.images.count) {
        CatalogListingImage *catalogImage = [catalogItem.images objectAtIndex:0];
        NSString *urlImg = catalogImage.url170x135;
        [cell.listingImage setImageWithURL:[NSURL URLWithString:urlImg]];
    } else {
        [CatalogServices getListingImagesForListingID:catalogItem.listingID withBlock:^(NSArray *imagesResult, NSError *error) {
            if (error) {
                // TODO: Do something with the error.
            } else {
                if (imagesResult.count) {
                    CatalogListingImage *img0 = [imagesResult objectAtIndex:0];
                    CatalogItem *itemFound = [self.catalogResults getCatalogItemWithListingID:img0.listingID];
                    if (itemFound) {
                        itemFound.images = [NSMutableArray arrayWithArray:imagesResult];
                    }
                }
            }
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListingTableViewCell *cell = (ListingTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:NO];
}

@end

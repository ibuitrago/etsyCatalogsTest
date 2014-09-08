//
//  CatalogServices.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/1/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "CatalogServices.h"

@implementation CatalogServices


+ (void)getCatalogListingsByWeywords:(NSString *)keywords inPage:(int)nPage withBlock:(void (^)(CatalogResult *catalogResults, NSError *error))block
{
    if (!block) {
        return;
    }
    
    int pageOffset = kPageItemsize * nPage;
    NSString *url = [NSString stringWithFormat:@"%@%@", kServicesUrl, kListingService];
    url = [NSString stringWithFormat:url, kApiKey, keywords, pageOffset, kPageItemsize];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 NSDictionary *responseDict = (NSDictionary *)responseObject;
                 NSDictionary *pagination = [responseDict objectForKey:@"pagination"];
                 int count = [[responseDict objectForKey:@"count"] intValue];
                 if (count && pagination) {
                     // For us, a correct response has registries (possitive count) and pagination info
                     // So, we get the results array and create our catalog results object
                     CatalogResult *catalogResult = [[CatalogResult alloc] init];
                     [catalogResult insertPaginationInfo:pagination withCount:count];
                     
                     NSArray *results = [responseDict objectForKey:@"results"];
                     
                     for (NSDictionary *result in results) {
                         [catalogResult insertCatalogItem:result];
                     }
                     
                     block(catalogResult, nil);
                 } else {
                     [CatalogServices reportErrorWithCode:kErrorCodeNoResultsFound
                                               andMessage:NSLocalizedString(@"No results found", nil)
                                                  toBlock:block];
                 }
             } else {
                 [CatalogServices reportErrorWithCode:kErrorCodeBadResponse
                                           andMessage:NSLocalizedString(@"Bad response from server", nil)
                                              toBlock:block];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             block(nil, error);
         }];
}


+ (void)getListingImagesForListingID:(long long)listingId withBlock:(void (^)(NSArray *imagesResult, NSError *error))block
{
    if (!block) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kServicesUrl, kListingImagesService];
    url = [NSString stringWithFormat:url, listingId, kApiKey];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 NSDictionary *responseDict = (NSDictionary *)responseObject;
                 
                 // So we need to check if there're actually results
                 int count = [[responseDict objectForKey:@"count"] intValue];
                 if (count) {
                     // And if we got results, we create the images objects and add them to the array
                     NSMutableArray *images = [NSMutableArray array];
                     NSDictionary *results = [responseDict objectForKey:@"results"];
                     for (NSDictionary *result in results) {
                         CatalogListingImage *image = [CatalogListingImage createCatalogListingImageFromDictionary:result];
                         [images addObject:image];
                     }
                     
                     block(images, nil);
                 } else {
                     [CatalogServices reportErrorWithCode:kErrorCodeNoResultsFound
                                               andMessage:NSLocalizedString(@"No results found", nil)
                                                  toBlock:block];
                 }
             } else {
                 [CatalogServices reportErrorWithCode:kErrorCodeBadResponse
                                           andMessage:NSLocalizedString(@"Bad response from server", nil)
                                              toBlock:block];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             block(nil, error);
         }];
}


#pragma mark - Private methods
+ (void)reportErrorWithCode:(int)code andMessage:(NSString *)desc toBlock:(void (^)(id object, NSError *error))block
{
    if (block) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : desc};
        NSError *error = [NSError errorWithDomain:kListingModelErrorDomain
                                                         code:code
                                                     userInfo:userInfo];
        block(nil, error);
    }
}

@end

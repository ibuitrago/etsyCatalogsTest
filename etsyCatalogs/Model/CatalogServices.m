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
    // Set the Url and the request
    int pageOffset = kPageItemsize * nPage;
    NSString *url = [NSString stringWithFormat:@"%@%@", kServicesUrl, kListingService];
    url = [NSString stringWithFormat:url, kApiKey, keywords, pageOffset, kPageItemsize];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Call the Get method of the service
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
                     
                     // At the end, we execute the block passing it the catalogs result object
                     if (block) {
                         block(catalogResult, nil);
                     }
                 } else {   // If the results has no registries, we return an error reporting that
                     [CatalogServices reportErrorWithCode:4020 andMessage:NSLocalizedString(@"No results found", nil) toBlock:block];
                 }
             } else {   // We are expecting a specific dictionary, if the response is different then is an error
                 [CatalogServices reportErrorWithCode:4001 andMessage:NSLocalizedString(@"Bad response from server", nil) toBlock:block];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (block) {   // Bad request or something went wrong, we return an error
                 block(nil, error);
             }
         }];
}


+ (void)getListingImagesForListingID:(long long)listingId withBlock:(void (^)(NSArray *imagesResult, NSError *error))block
{
    // Set the Url and the request
    NSString *url = [NSString stringWithFormat:@"%@%@", kServicesUrl, kListingImagesService];
    url = [NSString stringWithFormat:url, listingId, kApiKey];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    // Call the Get method of the service
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
                     
                     // At the end, we execute the block passing it the images array we gathered from the
                     if (block) {
                         block(images, nil);
                     }
                 } else {
                     // If the results has no registries, we return an error reporting that
                     [CatalogServices reportErrorWithCode:4020 andMessage:NSLocalizedString(@"No results found", nil) toBlock:block];
                 }
             } else {   // We are expecting a specific dictionary, if the response is different then its an error
                 [CatalogServices reportErrorWithCode:4001 andMessage:NSLocalizedString(@"Bad response from server", nil) toBlock:block];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if (block) {   // Bad request or something went wrong, we return an error
                 block(nil, error);
             }
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

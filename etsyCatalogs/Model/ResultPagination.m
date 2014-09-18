//
//  ResultPagination.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/2/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import "ResultPagination.h"

@implementation ResultPagination


+ (ResultPagination *)createResultPaginationFromDictionary:(NSDictionary *)dictionary
{
    ResultPagination *pagination = [[ResultPagination alloc] init];
    
    pagination.pageLimit = [[dictionary objectForKey:@"effective_limit"] intValue];
    pagination.currentOffset = [[dictionary objectForKey:@"effective_offset"] intValue];
    pagination.nextOffset = [[dictionary objectForKey:@"next_offset"] intValue];
    pagination.currentPage = [[dictionary objectForKey:@"effective_page"] intValue];
    pagination.nextPage = [[dictionary objectForKey:@"next_page"] intValue];
    pagination.totalCount = [[dictionary objectForKey:@"count"] intValue];
    
    return pagination;
}
@end

//
//  ResultPagination.h
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/2/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultPagination : NSObject

@property(nonatomic, assign) int pageLimit;
@property(nonatomic, assign) int currentOffset;
@property(nonatomic, assign) int nextOffset;
@property(nonatomic, assign) int currentPage;
@property(nonatomic, assign) int nextPage;
@property(nonatomic, assign) int totalCount;


@end

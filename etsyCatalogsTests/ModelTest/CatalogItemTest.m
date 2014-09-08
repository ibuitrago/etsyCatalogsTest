//
//  CatalogItemTest.m
//  etsyCatalogs
//
//  Created by Ihonahan Buitrago on 9/8/14.
//  Copyright (c) 2014 Ihonahan Buitrago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "CatalogItem.h"


@interface CatalogItemTest : XCTestCase

@end

@implementation CatalogItemTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testCreateCatalogItemFromDictionary
{
    NSDictionary *test = @{@"listing_id" : [NSNumber numberWithLongLong:1],
                           @"user_id" : [NSNumber numberWithLongLong:1],
                           @"category_id" : [NSNumber numberWithLongLong:1],
                           @"title" : @"Title",
                           @"description" : @"Description",
                           @"currency_code" : @"USD",
                           @"price" : [NSNumber numberWithDouble:200.99],
                           @"quantity" : [NSNumber numberWithInt:1],
                           @"url" : @"https://",
                           @"when_made" : @"2010"};
    
    CatalogItem *item = [CatalogItem createCatalogItemFromDictionary:test];
    XCTAssert(item, @"CatalogItem created");
}


@end

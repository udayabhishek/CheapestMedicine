//
//  TestCaseClass.m
//  CheapestMedicine
//
//  Created by ShikshaPC-41 on 13/01/15.
//  Copyright (c) 2015 ShikshaInfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "SearchByNameRequestClass.h"

@interface TestCaseClass : XCTestCase

@end

@implementation TestCaseClass

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

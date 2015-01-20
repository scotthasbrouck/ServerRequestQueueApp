//
//  ServerRequestQueueAppTests.m
//  ServerRequestQueueAppTests
//
//  Created by Scott Hasbrouck on 1/13/15.
//  Copyright (c) 2015 Scott Hasbrouck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ServerRequest.h"
#import "ServerRequestQueue.h"

@interface ServerRequestQueueAppTests : XCTestCase

@property (strong, nonatomic) ServerRequest *singleSampleRequest;
@property (strong, nonatomic) ServerRequest *singleSampleRequestSecond;

@end

@implementation ServerRequestQueueAppTests

@synthesize singleSampleRequest, singleSampleRequestSecond;

- (void)setUp {
    [super setUp];
    
    //empty app queue from the serialzied queue
    [[NSMutableArray sharedQueue] removeAllObjects];
    
    //sample server request
    singleSampleRequest = [[ServerRequest alloc] init];
    singleSampleRequest.tag = @"sample";
    
    singleSampleRequest.postData = [NSDictionary dictionaryWithObjectsAndKeys:
                       @"Sarah", @"fname",
                       @"Jane", @"lname",
                       @"59857355", @"fb_id",
                       nil];
    
    //second sample server request
    singleSampleRequestSecond = [[ServerRequest alloc] init];
    singleSampleRequestSecond.tag = @"sample2";
    
    singleSampleRequestSecond.postData = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"John", @"fname",
                                    @"Smith", @"lname",
                                    @"8947363", @"fb_id",
                                    nil];
    
    
    //enqueue the first sample request
    [[NSMutableArray sharedQueue] enqueue:singleSampleRequest];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testEnqueueAndPeek {
    ServerRequest *peekedRequest = [[NSMutableArray sharedQueue] peek];
    
    NSLog(@"Test that the enqueued request matches the sample request (also tests peek)");
    NSLog(@"Peek request: %@", peekedRequest.postData);
    NSLog(@"Sample request: %@", singleSampleRequest.postData);
    
    XCTAssert(peekedRequest == singleSampleRequest, @"Pass");
}

- (void)testDequeue {
    ServerRequest *dequeuedRequest = [[NSMutableArray sharedQueue] dequeue];
    
    NSLog(@"Test that the dequeued request matches the sample request");
    NSLog(@"Peek request: %@", dequeuedRequest.postData);
    NSLog(@"Sample request: %@", singleSampleRequest.postData);
    
    XCTAssert(dequeuedRequest == singleSampleRequest, @"Pass");
}

- (void)testInsertAtAndPeekAt {
    NSUInteger testIndex = 0;
    
    [[NSMutableArray sharedQueue] insert:singleSampleRequestSecond at:testIndex];
    
    ServerRequest *insertedRequest = [[NSMutableArray sharedQueue] peekAt:testIndex];
    
    NSLog(@"Test that the insertAt request matches the second sample request");
    NSLog(@"Inserted at reuqest: %@", insertedRequest.postData);
    NSLog(@"Sample request: %@", singleSampleRequestSecond.postData);
    
    XCTAssert(insertedRequest == singleSampleRequestSecond, @"Pass");
}

- (void)testRemoveAt {
    //add the second request so we can test removing at index 1
    [[NSMutableArray sharedQueue] enqueue:singleSampleRequestSecond];
    
    NSLog(@"Test removeAt index 1 after adding second request");
    
    ServerRequest *removedRequest = [[NSMutableArray sharedQueue] removeAt:1];
    
    BOOL sizeTest = [[NSMutableArray sharedQueue] queueSize] == 1;
    BOOL testCorrectRequest = removedRequest == singleSampleRequestSecond;
    
    XCTAssert(sizeTest && testCorrectRequest, @"Pass");
}

- (void)testGetSize {
    
    NSLog(@"Test for size = 1");
    NSLog(@"Size: %lu", (unsigned long)[[NSMutableArray sharedQueue] queueSize]);
    BOOL firstSizeTest = [[NSMutableArray sharedQueue] queueSize] == 1;
    
    [[NSMutableArray sharedQueue] enqueue:singleSampleRequestSecond];
    NSLog(@"Add second queue and test for size = 2");
    NSLog(@"Size: %lu", (unsigned long)[[NSMutableArray sharedQueue] queueSize]);
    BOOL secondSizeTest = [[NSMutableArray sharedQueue] queueSize] == 2;
    
    [[NSMutableArray sharedQueue] dequeue];
    [[NSMutableArray sharedQueue] dequeue];
    NSLog(@"Dequeue twice and test for size = 0");
    NSLog(@"Size: %lu", (unsigned long)[[NSMutableArray sharedQueue] queueSize]);
    BOOL thirdSizeTest = [[NSMutableArray sharedQueue] queueSize] == 0;
    
    XCTAssert(firstSizeTest && secondSizeTest && thirdSizeTest, @"Pass");
}

- (void)testSavePerformace {
    [self measureBlock:^{
        [NSMutableArray saveQueueState];
    }];
}

@end

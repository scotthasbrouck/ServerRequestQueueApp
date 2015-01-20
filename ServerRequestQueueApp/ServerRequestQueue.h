//
//  ServerRequestQueue.h
//  ServerRequestQueue
//
//  Created by Scott Hasbrouck on 1/12/15.
//  Copyright (c) 2015 Scott Hasbrouck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerRequest.h"

//  NSMutableArray is Composite class,
//  so we'll do this as a category to mixin our queue methods to NSMutableArray
@interface NSMutableArray (ServerRequestQueue)

//------Class Methods------

//  Return a singleton anywhere in the app
+ (id)sharedQueue;

//  persistance methods
+ (BOOL)saveQueueState; // automatically called everytime we modify the queue
+ (NSArray*)loadQueueState; // call this from the app delegate on applicationWillTerminate



//------Instance Methods------

//  queue methods
- (void)enqueue:(ServerRequest*)request;
- (ServerRequest*)dequeue;
- (ServerRequest*)peek;
- (ServerRequest*)peekAt:(NSUInteger)index;
- (void)insert:(ServerRequest*)request at:(NSUInteger)index;
- (ServerRequest*)removeAt:(NSUInteger)index;
- (NSUInteger)queueSize;

@end

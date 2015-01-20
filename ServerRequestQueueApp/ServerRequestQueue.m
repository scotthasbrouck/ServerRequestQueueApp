//
//  ServerRequestQueue.m
//  ServerRequestQueue
//
//  Created by Scott Hasbrouck on 1/12/15.
//  Copyright (c) 2015 Scott Hasbrouck. All rights reserved.
//

#import "ServerRequestQueue.h"

@implementation NSMutableArray (ServerRequestQueue)

//------Class Methods------

//  singleton queue
+ (id)sharedQueue {
    static NSMutableArray *sharedQueue = nil;
    //  dispatch assyncrhonosly only once with GCD
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedQueue = [[self alloc] initWithArray:[self loadQueueState]];
    });
    return sharedQueue;
}

//  persistance methods

+ (BOOL)saveQueueState {
    
    NSData *queueData = [NSKeyedArchiver archivedDataWithRootObject:[self sharedQueue]];
    [[NSUserDefaults standardUserDefaults] setObject:queueData forKey:@"sharedQueue"];
    
    return true;
}

+ (NSArray*)loadQueueState {
    NSData *queueData = [[NSUserDefaults standardUserDefaults] objectForKey:@"sharedQueue"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:queueData];
}



//------Instance Methods------

//  queue methods
- (void)enqueue:(ServerRequest*)request {
    [self addObject:request];
    [NSMutableArray saveQueueState];
}

- (ServerRequest*)dequeue {
    return [self removeAt:0];
}

- (ServerRequest*)peek {
    if ([self count] > 0) {
        return [self objectAtIndex:0];
    }
    return nil;
}

- (ServerRequest*)peekAt:(NSUInteger)index {
    if (index <= [self count] - 1) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (void)insert:(ServerRequest*)request at:(NSUInteger)index {
    [self insertObject:request atIndex:index];
    [NSMutableArray saveQueueState];
}

- (ServerRequest*)removeAt:(NSUInteger)index {
    if (index + 1 <= ([self count])) {
        ServerRequest *request = [self objectAtIndex:index];
        if (request != nil) {
            [self removeObjectAtIndex:index];
        }
        [NSMutableArray saveQueueState];
        return request;
    }
    return nil;
}

- (NSUInteger)queueSize {
    return [self count];
}

@end

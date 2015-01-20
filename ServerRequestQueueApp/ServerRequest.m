//
//  ServerRequest.m
//  ServerRequestQueue
//
//  Created by Scott Hasbrouck on 1/12/15.
//  Copyright (c) 2015 Scott Hasbrouck. All rights reserved.
//

#import "ServerRequest.h"

@implementation ServerRequest

- (id)init {
    if (self = [super init]) {
        _tag = [[NSString alloc] init];
        _postData = [[NSDictionary alloc] init];
    }
    return self;
}

//  NSCoding, specify what to be encoded and decoded
//  Required for NSKeyedArchiver to serialize state to file on crash/close

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.tag forKey:@"tag"];
    [coder encodeObject:self.postData forKey:@"postData"];
}

-(id)initWithCoder:(NSCoder *)decoder {
    if(self = [super init]){
        self.tag = [decoder decodeObjectForKey:@"tag"];
        self.postData = [decoder decodeObjectForKey:@"postData"];
    }
    return self;
}

@end
// ServerRequest.h

#import <Foundation/Foundation.h>

@interface ServerRequest : NSObject

@property (strong, nonatomic) NSString *tag;
@property (strong, nonatomic) NSDictionary *postData;

@end
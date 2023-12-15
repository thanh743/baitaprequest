#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface THRequest : NSObject

typedef void (^THRequestCompletionBlock)(NSData *data, NSURLResponse *response, NSError *error);

+ (void)makeGETRequest:(NSString *)urlString
        withParameters:(NSDictionary *)parameters
           andProgress:(MBProgressHUD *)progressHUD
          onCompletion:(THRequestCompletionBlock)completionBlock;

+ (void)makePOSTRequest:(NSString *)urlString
         withParameters:(NSDictionary *)parameters
            andProgress:(MBProgressHUD *)progressHUD
           onCompletion:(THRequestCompletionBlock)completionBlock;

@end

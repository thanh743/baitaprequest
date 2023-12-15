#import "THRequest.h"

@implementation THRequest

+ (void)makeGETRequest:(NSString *)urlString
        withParameters:(NSDictionary *)parameters
           andProgress:(MBProgressHUD *)progressHUD
          onCompletion:(THRequestCompletionBlock)completionBlock {

    // Show progress HUD
    if (progressHUD) {
        [progressHUD showAnimated:YES];
    }

    // Append parameters to URL
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:urlString];
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray array];
    for (NSString *key in parameters.allKeys) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:parameters[key]]];
    }
    urlComponents.queryItems = queryItems;

    NSURL *url = urlComponents.URL;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"X-Auth-Token"];
    if (token){
         NSString *cookieValue = [NSString stringWithFormat:@"X-Auth-Token=%@",token];
        [request setValue:cookieValue forHTTPHeaderField:@"Cookie"];
    }
   

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // Hide progress HUD
        if (progressHUD) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [progressHUD hideAnimated:YES];
            });
        }

        // Call completion block
        if (completionBlock) {
            completionBlock(data, response, error);
        }
    }];

    [dataTask resume];
}


+ (void)makePOSTRequest:(NSString *)urlString
         withParameters:(NSDictionary *)parameters
            andProgress:(MBProgressHUD *)progressHUD
           onCompletion:(THRequestCompletionBlock)completionBlock {

    // Show progress HUD
    if (progressHUD) {
        [progressHUD showAnimated:YES];
    }

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"X-Auth-Token"];
    if (token){
         NSString *cookieValue = [NSString stringWithFormat:@"X-Auth-Token=%@",token];
        [request setValue:cookieValue forHTTPHeaderField:@"Cookie"];
    }
    // Set up request body
    NSError *jsonError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&jsonError];
    if (!jsonError) {
        request.HTTPBody = jsonData;
    }

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // Hide progress HUD
        if (progressHUD) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [progressHUD hideAnimated:YES];
            });
        }

        // Call completion block
        if (completionBlock) {
            completionBlock(data, response, error);
        }
    }];

    [dataTask resume];
}

@end

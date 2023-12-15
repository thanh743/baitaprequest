#import "ValidateDeviceController.h"

@interface ValidateDeviceController ()

@end

@implementation ValidateDeviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *expiredButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [expiredButton setTitle:@"Check Expired" forState:UIControlStateNormal];
    [expiredButton addTarget:self action:@selector(checkExpired) forControlEvents:UIControlEventTouchUpInside];

    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [registerButton setTitle:@"Register Device" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerDevice) forControlEvents:UIControlEventTouchUpInside];

    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[expiredButton,registerButton]];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 20;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.distribution = UIStackViewDistributionFillEqually;

    [self.view addSubview:stackView];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
    ]];
}

- (void)checkExpired {
    // Implement logic to check if the device is expired
    NSLog(@"Checking if the device is expired...");
}



- (void)registerDevice {
    // Implement logic to register the device
    NSLog(@"Registering the device...");
}

// -(void)requestGetDeviceStatus{
//     NSString *urlString = @"http://64.176.85.57:3900/api/users/me";
//     NSURL *url = [NSURL URLWithString:urlString];

//     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//     request.HTTPMethod = @"GET";
//     [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//     NSString *cookieValue = [NSString stringWithFormat:@"X-Auth-Token=%@",[self.userDefaults objectForKey:@"X-Auth-Token"]];
//     [request setValue:cookieValue forHTTPHeaderField:@"Cookie"];
//     NSError *error = nil;
//     NSHTTPURLResponse *response = nil;
//     NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//     if (error) {
//         return false;
//     } else {
//         NSInteger statusCode = [response statusCode];
//         if (statusCode != 200) {
//              return false;
//         }
//         return true;
//     }
// }
@end

#import "LFLoginController.h"
#import "ValidateDeviceController.h"
#import "MBProgressHUD.h"
#import "THRequest.h"
// #import "AutoCompleteTextField.h"
typedef void (^CompletionHandler)(BOOL success);

@interface LFLoginController () <UITextFieldDelegate>
// AutoCompleteTextFieldDataSource
@property (nonatomic, strong) UITextField *txtEmail;
@property (nonatomic, strong) UITextField *txtUserName;
@property (nonatomic, strong) UITextField *txtPassword;
@property (nonatomic, strong) UIImageView *imgvUserIcon;
@property (nonatomic, strong) UIImageView *imgvUserNameIcon;
@property (nonatomic, strong) UIImageView *imgvPasswordIcon;
@property (nonatomic, strong) UIImageView *imgvLogo;
@property (nonatomic, strong) UIView *loginView;
@property (nonatomic, strong) UIView *bottomTxtEmailView;
@property (nonatomic, strong) UIView *bottomTxtPasswordView;
@property (nonatomic, strong) UIView *bottomTxtUserNameView;
@property (nonatomic, strong) UIButton *butLogin;
@property (nonatomic, strong) UIButton *butSignup;
@property (nonatomic, strong) UIButton *butForgotPassword;
@property (nonatomic, strong) UIButton *butOnePassword;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appUrl;
@property (nonatomic, assign) BOOL isLogin ;
@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation LFLoginController

- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.isLogin = true ;

   

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillLayoutSubviews {
    [self validateExistedUserWithCompletion:^(BOOL success){
        NSLog(@"Suiccess valiudate : %@",success ? @"YES": @"NO");
        if (success) [self fowardUserToMainController];
    }];
}

- (void)commonInit {
    NSLog(@"layout");
    self.view.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:68.0/255.0 blue:98.0/255.0 alpha:1.0];
    
    // Add your setup code here
    
    [self setupLoginView];
    [self setupEmailField];
    [self setupPasswordField];
    [self setupLoginButton];
    [self setupSignupButton];
    [self setupUserNameField];
    self.txtUserName.hidden = YES;
    self.bottomTxtUserNameView.hidden = YES;

    
        
    
        
    // [self setupForgotPasswordButton];
    
    [self.view addSubview:self.loginView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupSignupButton{
    if (self.butSignup != nil) {
        [self.butSignup removeFromSuperview];
    }

    self.butSignup = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.loginView.frame) - 200, CGRectGetWidth(self.loginView.frame), 40)];

    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
    NSDictionary *attributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor whiteColor]};
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:@"Don't have an account? Sign up" attributes:attributes];

    [self.butSignup setAttributedTitle:titleString forState:UIControlStateNormal];
    [self.butSignup setAlpha:0.7];

    [self.butSignup addTarget:self action:@selector(signupTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView addSubview:self.butSignup];

}

// Add your additional methods here
- (void)setupLoginView {
    CGFloat loginX = 20;
    CGFloat loginY = 130 + 40;
    CGFloat loginWidth = self.view.bounds.size.width - 40;
    CGFloat loginHeight = self.view.bounds.size.height - loginY - 30;
    NSLog(@"%f", loginHeight);

    self.loginView = [[UIView alloc] initWithFrame:CGRectMake(loginX, loginY, loginWidth, loginHeight)];
}








- (void)setupLoginButton {
    self.butLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    self.butLogin.frame = CGRectMake(0, self.bottomTxtPasswordView.frame.origin.y + self.bottomTxtPasswordView.frame.size.height + 60, self.loginView.frame.size.width, 40);

    UIColor *buttonColor = nil;
    if (self.loginButtonColor) {
        buttonColor = self.loginButtonColor;
    } else {
        buttonColor = [UIColor colorWithRed:80.0 / 255.0 green:185.0 / 255.0 blue:167.0 / 255.0 alpha:0.8];
    }
    self.butLogin.backgroundColor = buttonColor;

    [self.butLogin setTitle:@"Login" forState:UIControlStateNormal];
    [self.butLogin addTarget:self action:@selector(sendLoginRequest) forControlEvents:UIControlEventTouchUpInside];
    self.butLogin.layer.cornerRadius = 5;
    self.butLogin.layer.borderWidth = 1;
    self.butLogin.layer.borderColor = [UIColor clearColor].CGColor;
    [self.loginView addSubview:self.butLogin];
}


////

- (void)setupEmailField {
    self.txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.loginView.frame.size.width, 30)];
    self.txtEmail.delegate = self;
    self.txtEmail.returnKeyType = UIReturnKeyNext;
    self.txtEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.txtEmail.autocorrectionType = UITextAutocorrectionTypeNo;
    self.txtEmail.textColor = [UIColor whiteColor];
    self.txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    self.txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter your Email" attributes:@{NSForegroundColorAttributeName: [UIColor.whiteColor colorWithAlphaComponent:0.5]}];
    [self.loginView addSubview:self.txtEmail];

    self.bottomTxtEmailView = [[UIView alloc] initWithFrame:CGRectMake(0, self.txtEmail.frame.origin.y + self.txtEmail.frame.size.height + 5, self.loginView.frame.size.width, 1)];
    self.bottomTxtEmailView.backgroundColor = [UIColor whiteColor];
    self.bottomTxtEmailView.alpha = 0.5;
    [self.loginView addSubview:self.bottomTxtEmailView];
}
- (void)setupPasswordField {
    self.txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(0, self.txtEmail.frame.origin.y + self.txtEmail.frame.size.height + 10, self.loginView.frame.size.width, 30)];
    self.txtPassword.delegate = self;
    self.txtPassword.returnKeyType = UIReturnKeyDone;
    self.txtPassword.secureTextEntry = YES;
    self.txtPassword.textColor = [UIColor whiteColor];
    self.txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor.whiteColor colorWithAlphaComponent:0.5]}];
    [self.loginView addSubview:self.txtPassword];

    self.bottomTxtPasswordView = [[UIView alloc] initWithFrame:CGRectMake(0, self.txtPassword.frame.origin.y + self.txtPassword.frame.size.height + 5, self.loginView.frame.size.width, 1)];
    self.bottomTxtPasswordView.backgroundColor = [UIColor whiteColor];
    self.bottomTxtPasswordView.alpha = 0.5;
    [self.loginView addSubview:self.bottomTxtPasswordView];
}
- (void)setupUserNameField {
    self.txtUserName = [[UITextField alloc] initWithFrame:CGRectMake(0, self.txtPassword.frame.origin.y + self.txtPassword.frame.size.height + 10, self.loginView.frame.size.width, 30)];
    self.txtUserName.delegate = self;
    self.txtUserName.returnKeyType = UIReturnKeyNext;
    self.txtUserName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.txtUserName.autocorrectionType = UITextAutocorrectionTypeNo;
    self.txtUserName.textColor = [UIColor whiteColor];
    self.txtUserName.keyboardType = UIKeyboardTypeDefault;
    self.txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter your Username" attributes:@{NSForegroundColorAttributeName: [UIColor.whiteColor colorWithAlphaComponent:0.5]}];
    [self.loginView addSubview:self.txtUserName];

    self.bottomTxtUserNameView = [[UIView alloc] initWithFrame:CGRectMake(0, self.txtUserName.frame.origin.y + self.txtUserName.frame.size.height + 5, self.loginView.frame.size.width, 1)];
    self.bottomTxtUserNameView.backgroundColor = [UIColor whiteColor];
    self.bottomTxtUserNameView.alpha = 0.5;
    [self.loginView addSubview:self.bottomTxtUserNameView];
}






////

-(void)sendLoginRequest{
    if ([self.butLogin.titleLabel.text isEqualToString:@"Signup"]){
      [self signupRequest];
    }else{
        NSString *urlString = @"http://64.176.85.57:3900/api/auth";
        NSURL *url = [NSURL URLWithString:urlString];

        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

        NSDictionary *payload = @{@"email": self.txtEmail.text, @"password": self.txtPassword.text};
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:payload options:0 error:nil];
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
        request.HTTPBody = requestData;


        NSError *error = nil;
        NSHTTPURLResponse *response = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSInteger statusCode = [response statusCode];
            NSString *responseDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (statusCode != 200) {
                [self showErrorAlert:responseDataString];
                return;
            }
            [self.userDefaults setObject:responseDataString forKey:@"X-Auth-Token"];
            [self.userDefaults synchronize]; 
            [self fowardUserToMainController];

        }
    }
}

-(void)signupRequest{
        MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [THRequest makeGETRequest:@"http://64.176.85.57:3900/api/users"
            withParameters:@{@"email":self.txtEmail.text ,@"password": self.txtPassword.text , @"name": self.txtUserName.text}
            andProgress:(MBProgressHUD *)progressHUD
            onCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {

                if (!error){
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                    NSInteger statusCode = httpResponse.statusCode;
                    NSString *responseDataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

                    if (statusCode != 200) {
                        [self showErrorAlert:responseDataString];
                        return;
                    }
                    [self.userDefaults setObject:responseDataString forKey:@"X-Auth-Token"];
                    [self.userDefaults synchronize]; 
                    [self fowardUserToMainController];
                }
            

        }];
}

-(void)validateExistedUserWithCompletion:(CompletionHandler)completion{
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [THRequest makeGETRequest:@"http://64.176.85.57:3900/api/users/me"
        withParameters:@{}
           andProgress:(MBProgressHUD *)progressHUD
          onCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
                 // Handle the response or error
            if (error) {
                        completion(NO);
            } else {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                NSInteger statusCode = httpResponse.statusCode;
                if (statusCode != 200) {
                            completion(NO);
                }
                else  {
                        completion(YES);
                }

            }
            
    
    }];

}
- (void)showErrorAlert:(NSString *)message {
    // Create an alert controller
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Error"
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];

    // Add an action to the alert (e.g., an "OK" button)
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:nil];
    
    [alertController addAction:okAction];

    // Present the alert controller
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)fowardUserToMainController{
        ValidateDeviceController *controller = [[ValidateDeviceController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = controller;
        [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
}


- (void)signupTapped {
    [self toggleLoginSignup];
}

- (void)toggleLoginSignup {
    self.isLogin = !self.isLogin;
    if(self.isLogin){
        self.txtUserName.hidden = YES;
        self.bottomTxtUserNameView.hidden = YES;
    }else{
        self.txtUserName.hidden = NO;
        self.bottomTxtUserNameView.hidden = NO;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.butLogin.alpha = 0;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.butLogin.alpha = 1;
        }];
    }];
    
    NSString *login = self.isLogin ? @"Login" : @"Signup";
    [self.butLogin setTitle:login forState:UIControlStateNormal];
    
    NSString *signup = self.isLogin ? @"Don't have an account? Sign up" : @"Have an account? Login";
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
    NSDictionary *attributes = @{  
        NSFontAttributeName: font,
        NSForegroundColorAttributeName: [UIColor whiteColor]
    };
    
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:signup attributes:attributes];
    [self.butSignup setAttributedTitle:titleString forState:UIControlStateNormal];    
   
}


@end
// => check auth token true=> push login sucess ..
//                     false=> login success => save login token => push login success
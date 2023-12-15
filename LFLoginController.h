#import <UIKit/UIKit.h>

@protocol LFLoginControllerDelegate <NSObject>

- (void)loginDidFinishWithEmail:(NSString *)email password:(NSString *)password type:(NSInteger)type;
- (void)forgotPasswordTappedWithEmail:(NSString *)email;

@end

@interface LFLoginController : UIViewController

@property (nonatomic, weak) id<LFLoginControllerDelegate> delegate;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) UIImage *logo;
@property (nonatomic, strong) UIColor *loginButtonColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) BOOL isSignupSupported;

- (instancetype)init;

@end

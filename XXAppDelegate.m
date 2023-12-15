#import "XXAppDelegate.h"
#import "XXRootViewController.h"
#import "LFLoginController.h"
@implementation XXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	//_rootViewController = [[UINavigationController alloc] initWithRootViewController:[[XXRootViewController alloc] init]];
	_window.rootViewController = [[LFLoginController alloc] init];
	[_window makeKeyAndVisible];
	return YES;
}





@end

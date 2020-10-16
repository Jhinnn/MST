//
//  AppDelegate.m
//  MST
//
//  Created by admin on 2020/10/16.
//

#import "AppDelegate.h"
#import "MSTTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[MSTTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}




@end

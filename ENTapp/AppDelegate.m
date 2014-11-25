//
//  AppDelegate.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 17.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
 
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *language = [prefs stringForKey:@"SelectedLanguage"];
    
    UIViewController *viewController = nil;
    
    if(language && language.length > 0){
        LocalizationSetLanguage(language);
        viewController = [storyboard instantiateViewControllerWithIdentifier:@"MainTabbarController"];
    }
    else {
        viewController = [storyboard instantiateViewControllerWithIdentifier:@"LanguageSelectionViewController"];
    }
    
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
    
    [self customizeNavigationBar];
    [self customizeTabBar];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) customizeTabBar{
    //sets the color for the text
    //[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
      //                              [UIFont fontWithName:@"AmericanTypewriter" size:20.0f], UITextAttributeFont,
        //                            [UIColor colorWithRed:0.992 green:0.655 blue:0.122 alpha:1.0], UITextAttributeTextColor,
          //                          [UIColor clearColor], UITextAttributeTextShadowColor,
            //                        [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 0.0f)],UITextAttributeTextShadowOffset,
              //                      nil] forState:UIControlStateHighlighted];
    
    
//    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selection_indicator.png"]];
//    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:0.992 green:0.655 blue:0.122 alpha:1.0]];
    //self.window.tintColor = [UIColor colorWithRed:0.992 green:0.655 blue:0.122 alpha:1.0];
    
}

- (void) customizeNavigationBar{
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_bar.png"]
      //                                 forBarMetrics:UIBarMetricsDefault];
    
    //UIImage *backButtonImage = [[UIImage imageNamed:@"back_button.png"]
      //                       resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
    //UIImage *backgroundImage = [[UIImage imageNamed:@"navigation_bar_button.png"]
      //                          resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
    
    //[[UIBarButtonItem appearance] setBackButtonBackgroundImage: backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //[[UIBarButtonItem appearance] setBackgroundImage: backgroundImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //[[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"back_button.png"]forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

@end

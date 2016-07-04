

#import "CXLoginManager.h"

@interface CXLoginManager()
@property(strong,nonatomic) NSDictionary* registerUserData;
@property(strong,nonatomic) NSDictionary* loggedInUserData;
@property(assign,nonatomic) BOOL mIsLoggedIn;

@end

static CXLoginManager *sharedPGLoginManager = nil;

@implementation CXLoginManager

@synthesize loginActions = mLoginActions;
@synthesize loginInProgress = mLoginInProgress;

#pragma mark -
#pragma mark singleton overrides
#pragma mark -

+(CXLoginManager*)sharedManager
{
	if (sharedPGLoginManager == nil) 
	{
        sharedPGLoginManager = [[super allocWithZone:NULL] init];
        [[NSNotificationCenter defaultCenter] addObserver:sharedPGLoginManager selector:@selector(handleUserRegistered:) name:@"CXUserRegisterDidNotification" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:sharedPGLoginManager selector:@selector(handleUserLoggedIn:) name:@"CXUserLoginDidNotification" object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:sharedPGLoginManager selector:@selector(handleUserLoggedOut:) name:@"CXUserLoggedOutNotification" object:nil];

        
        
    }
	
    return sharedPGLoginManager;
}


#pragma mark -
#pragma mark accessors
#pragma mark -

-(void)doLoginWithUserId:(NSString*)userId ssoKey:(NSString*)ssoKey
{
	if (self.loginInProgress) {
		return;
	}
	mLoginInProgress = YES;
}

-(void)initiateLoginWithActions:(NSArray*)actions;
{
	if (actions )
	{
		self.loginActions = actions;
		
	}
	if ([self isLoggedIn] == NO)
	{
		
	}
}

-(BOOL)isLoggedIn
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"loggedinUserDetails"];
    if ([dic valueForKey:@"UserId"]) {
        return YES;
    }
	return NO;
}

-(void)handleUserRegistered:(NSNotification*)notification
{
    self.registerUserData = [notification userInfo];
    self.mIsLoggedIn = YES;
}

-(void)handleUserLoggedIn:(NSNotification*)notification
{
    self.loggedInUserData = [notification userInfo];
    self.mIsLoggedIn = YES;
}

-(void)handleUserLoggedOut:(NSNotification*)notification
{
    self.loggedInUserData = nil;
    self.mIsLoggedIn = NO;
}

-(NSString *)loggedInUserId
{
    NSString *userId = [self.loggedInUserData objectForKey:@"userid"];
    if(!userId)
    {
        userId = [self.loggedInUserData objectForKey:@"UserId"];
    }
    return userId;
}


@end

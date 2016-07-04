


@interface CXLoginManager : NSObject
{
	NSArray *mLoginActions;
	BOOL mLoginInProgress;
}

@property(nonatomic,retain)NSArray *loginActions;
@property(readonly) BOOL loginInProgress;

/**
 * shared Manager
 */
+(CXLoginManager*)sharedManager;

/**
 * Method to send the login request to server
 * @param : NSString - user Id
 * @param : NSString - ssoKey
 */
-(void)doLoginWithUserId:(NSString*)userId ssoKey:(NSString*)ssoKey;
/**
 * Method to start the login process by activating the view controller 
 */
-(void)initiateLoginWithActions:(NSArray*)actions;

-(BOOL)isLoggedIn;

-(NSString *)loggedInUserId;

-(void)autoLoginWithSsoKey:(NSString*)ssoKey 
		  invokerProductId:(NSString*)productId 
		 invokerSessionKey:(NSString*)invokerSessionKey;


@end

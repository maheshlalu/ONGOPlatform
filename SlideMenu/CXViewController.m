

#import "CXViewController.h"
#import "RightViewController.h"
#import "CCKFNavDrawer.h"
#import "CXLoginManager.h"
#import "SignInViewController.h"
#import "ProfileTabViewController.h"
#import "CartViewController.h"

@interface CXViewController()
@property(strong,nonatomic) RightViewController* modalController;

@end

@implementation CXViewController

@synthesize cxPopoverController;

-(void)backButtonTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)leftMenuTapped
{
    CCKFNavDrawer* navC = (CCKFNavDrawer*)self.navigationController;
    [navC drawerToggle];
}

- (IBAction)toggleHalfModal:(UIButton *)sender {
    
    
    UIViewController *contentController = [[UIViewController alloc] init];
    contentController.preferredContentSize = CGSizeMake(120, 44);
    
    contentController.view = [self createTableview];
    
    self.cxPopoverController = [[WYPopoverController alloc] initWithContentViewController:contentController];
    
    [self.cxPopoverController presentPopoverFromRect:CGRectMake(288, 30, sender.frame.size.width, sender.frame.size.height) inView:self.navigationController.navigationBar permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
    

    return;
    
    if (self.childViewControllers.count == 0) {
        
        self.modalController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
        [self addChildViewController:self.modalController];
        
//        self.modalController.view.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        self.modalController.view.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.modalController.view];
//        [UIView animateWithDuration:0.5 animations:^{
//            self.modalController.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);;
//        } completion:^(BOOL finished) {
//            [self.modalController didMoveToParentViewController:self];
//        }];
    }else{
        [self.modalController.view removeFromSuperview];
        [self.modalController removeFromParentViewController];
        self.modalController = nil;

        
//        [UIView animateWithDuration:0.5 animations:^{
//            self.modalController.view.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
//        } completion:^(BOOL finished) {
//            [self.modalController.view removeFromSuperview];
//            [self.modalController removeFromParentViewController];
//            self.modalController = nil;
//        }];
    }
}


-(void)removeRightViewController
{
    [self.modalController.view removeFromSuperview];
    [self.modalController removeFromParentViewController];
    self.modalController = nil;
}


-(void)profileTapped
{
    if([[CXLoginManager sharedManager] isLoggedIn])
    {
        ProfileTabViewController* profileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileTabViewController"];
        [self.navigationController pushViewController:profileViewController animated:YES];
        
    }
    else
    {
        SignInViewController* signInViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
        [self.navigationController pushViewController:signInViewController animated:YES];
    }
    
    //[self removeRightViewController];
    
}

-(void)cartTapped
{
    CartViewController* cartViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CartViewController"];
    [self.navigationController pushViewController:cartViewController animated:YES];

}

-(BOOL)shouldCustomizeLeftNavigationItem
{
    return YES;
}

-(BOOL)shouldShowCart
{
    return YES;
}

-(BOOL)shouldShowRightMenu
{
    return YES;
}

-(BOOL)shouldShowLeftMenu
{
    return NO;
}

-(void)rightMenuTapped
{
    [self toggleHalfModal:nil];
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"]
//                                                         bundle:[NSBundle mainBundle]];
//    
//    RightViewController* rightViewController = [storyBoard instantiateViewControllerWithIdentifier:@"RightViewController"];
//
//    
//    [self presentViewController:rightViewController animated:YES completion:^()
//     {
//     }];

}


#pragma mark TableView

- (UITableView*)createTableview{
    
    _rightMenuTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 120, 50) style:UITableViewStylePlain];
    [_rightMenuTableView setDelegate:self];
    [_rightMenuTableView setDataSource:self];
    
    return _rightMenuTableView;
}




#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell* cell = [aTableView dequeueReusableCellWithIdentifier:@"WYSettingsTableViewCell" forIndexPath:indexPath];
    
    UITableViewCell* cell = [aTableView dequeueReusableCellWithIdentifier:@"POPOVERCELL"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"POPOVERCELL"];
    }
    if ([[CXLoginManager sharedManager] isLoggedIn]) {
        cell.textLabel.text = @"Log Out";
    }else{
        cell.textLabel.text = @"Profile";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[CXLoginManager sharedManager] isLoggedIn]){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loggedinUserDetails"];
    }else{
        [self profileTapped];
    }
    [cxPopoverController dismissPopoverAnimated:YES];

}


#pragma mark - WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    if (controller == cxPopoverController)
    {
        cxPopoverController.delegate = nil;
        cxPopoverController = nil;
    }
}

@end



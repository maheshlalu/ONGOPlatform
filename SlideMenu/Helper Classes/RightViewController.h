//
//  RightViewController.h
//  OnGO
//
//  Created by CreativeXpert pvt Ltd.  on 4/24/13.


#import <UIKit/UIKit.h>
#import "CXViewController.h"

@interface RightViewController : CXViewController{
    

}

@property(nonatomic,strong) IBOutlet UIButton* logoutButton;
@property(nonatomic,strong) IBOutlet UIButton* profileButton;
@property(nonatomic,strong) IBOutlet UIView* overLayView;


-(IBAction)profileTapped:(id)sender;
-(IBAction)logoutTapped:(id)sender;

@end

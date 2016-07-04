//
//  ProductViewController.m
//  SlideMenu
//
//  Created by Mentor Insight India pvt Ltd on 21/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "ProductSubcategoryViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "SubMenuViewController.h"
#import "StarterViewController.h"
#import "MenuCell.h"
static NSString *CellIdentifier = @"MenuCell";

@interface ProductSubcategoryViewController ()

@end

@implementation ProductSubcategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.tintColor=[UIColor lightGrayColor];
    
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://54.251.36.80:8081/Services/getMasters?type=PSubCategories&mallId=12"]];
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    productsubCategoryArray=[dic valueForKey:@"jobs"];
    NSLog(@"%@",[productsubCategoryArray objectAtIndex:0]);
    NSLog(@"%@",[productsubCategoryArray valueForKey:@"Icon_URL"]);
    filtered = [[NSMutableArray alloc]init];
    
    for (int i=0;i<[productsubCategoryArray count];i++)
    {
        NSDictionary* item=[productsubCategoryArray objectAtIndex:i];
        
        if ([@"Menu(54987)"  isEqual: [item objectForKey:@"MasterCategory"]] )
        {
            [filtered addObject:item];
        }
        NSLog(@"filtered details is=======%@", filtered);
        NSLog(@"array count====%i",filtered.count);
    }
    
}
//COllection View Delegate & Data source Methods..


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return filtered.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIImage *image;
    MenuCell *cell = (MenuCell *)[collectionView
                              dequeueReusableCellWithReuseIdentifier:CellIdentifier
                              forIndexPath:indexPath];
 
    NSString *urlString=[NSString stringWithFormat:@"%@",[[filtered objectAtIndex:indexPath.row]valueForKey:@"Icon_URL"]];
    image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];

    cell.myCellLabel.text =[[filtered objectAtIndex:indexPath.row]valueForKey:@"Name"];
    cell.myCellImgView.image=image;
    cell.lblImgView.image =[UIImage new];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
























    


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // tableView.rowHeight=60;
//	return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//	//return (section == 0) ? 4 : 6;
//    return [filtered count];
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//	return @"MENU CATEGORY";
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    
//    cell.textLabel.text=[[filtered objectAtIndex:indexPath.row]valueForKey:@"Name"];
//    //    cell.textLabel.text=[[categoryArray objectAtIndex:indexPath.row]valueForKey:@"Name"];
//    //    NSString *urlString=[NSString stringWithFormat:@"%@",[[categoryArray objectAtIndex:indexPath.row]valueForKey:@"Icon_URL"]];
//    //    NSLog(@"%@",urlString);
//    //    cell.imageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
//    //    cell.textLabel.textAlignment = NSTextAlignmentLeft;
//    cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
//    
//    cell.textLabel.highlightedTextColor = [UIColor darkGrayColor];
//    return cell;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 320, 25)];
//    headerView.backgroundColor=[UIColor lightGrayColor];
//        UILabel *leftlabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320, 20)];
//    leftlabel.text=@"MENU CATEGORY";
//    [leftlabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:13.0]];
//    [headerView addSubview:leftlabel];
//    return headerView;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
//    if (indexPath.section == 0)
//    {
//        UIViewController *vc ;
//        if (indexPath.row==0) {
//            
//        }
//        else if (indexPath.row==1) {
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
//        }
//        else if (indexPath.row==2) {
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
//        }
//        else if (indexPath.row==3) {
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
//        }
//        else if (indexPath.row==4) {
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
//        }
//        else if (indexPath.row==5) {
//            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
//           StarterViewController *starterVc = (StarterViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"StarterViewController"];
//            [[SlideNavigationController sharedInstance] pushViewController:starterVc animated:NO];
//        }
//        else if (indexPath.row==6) {
//            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
//            SubMenuViewController *prodSubcatVC = (SubMenuViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"SubMenuViewController"];
//            [[SlideNavigationController sharedInstance] pushViewController:prodSubcatVC animated:NO];
//
//        }
//        else if (indexPath.row==7) {
//            
//            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
////            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
////            ProductSubcategoryViewController *prodSubcatVC = (ProductSubcategoryViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ProductSubcategoryViewController"];
////            [[SlideNavigationController sharedInstance] pushViewController:prodSubcatVC animated:NO];
////            //[[SlideNavigationController sharedInstance] switchToViewController:prodSubcatVC withCompletion:nil];
////            // vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ProductSubcategoryViewController"];
//        }
//        else{
//            
//        }
//        
//    }
//
//    
//    
//    
////    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
////	if (indexPath.section == 0)
////	{
////		UIViewController *vc ;
////		
////		switch (indexPath.row)
////		{
////			case 0:
////                
////				vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
////				break;
////				
////			case 1:
////				vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
////				break;
////				
////			case 2:
////				vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
////				break;
////				
////            case 3:
////				vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
////                break;
////            case 4:
////				vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
////                break;
////            case 5:
////				vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"StarterViewController"];
////                break;
////            case 6:
////				vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"SubMenuViewController"];
////                break;
////            case 7:
////            vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
////            break;
////            case 8:
////				[[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
////				return;
////				break;
////		}
////		
////		[[SlideNavigationController sharedInstance] switchToViewController:vc withCompletion:nil];
////	}
////	else
////	{
////		id <SlideNavigationContorllerAnimator> revealAnimator;
////		
////		switch (indexPath.row)
////		{
////			case 0:
////				revealAnimator = nil;
////				break;
////				
////			case 1:
////				revealAnimator = [[SlideNavigationContorllerAnimatorSlide alloc] init];
////				break;
////				
////			case 2:
////				revealAnimator = [[SlideNavigationContorllerAnimatorFade alloc] init];
////				break;
////				
////			case 3:
////				revealAnimator = [[SlideNavigationContorllerAnimatorSlideAndFade alloc] initWithMaximumFadeAlpha:.7 fadeColor:[UIColor purpleColor] andSlideMovement:100];
////				break;
////				
////			case 4:
////				revealAnimator = [[SlideNavigationContorllerAnimatorScale alloc] init];
////				break;
////				
////			case 5:
////				revealAnimator = [[SlideNavigationContorllerAnimatorScaleAndFade alloc] initWithMaximumFadeAlpha:.6 fadeColor:[UIColor blueColor] andMinimumScale:.7];
////				break;
////				
////			default:
////				return;
////		}
////		
////		[[SlideNavigationController sharedInstance] closeMenuWithCompletion:^{
////			[SlideNavigationController sharedInstance].menuRevealAnimator = revealAnimator;
////		}];
////	}
//}

@end

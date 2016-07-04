//
//  FriendsViewController.m
//  SlideMenu
//
//  Created by Aryan Ghassemi on 12/31/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "ProductsViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "ProductSubcategoryViewController.h"

@implementation ProductsViewController

- (void)viewDidLoad
{
//    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://54.251.36.80:8081/Services/getMasters?type=PSubCategories&mallId=12"]];
//    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",string);
//    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//    productCategoryArray=[dic valueForKey:@"jobs"];
//    NSLog(@"%@",[productCategoryArray objectAtIndex:0]);
//    NSLog(@"%@",[productCategoryArray valueForKey:@"Icon_URL"]);
    
    [productCattbl setSeparatorInset:UIEdgeInsetsZero];
    productCattbl.separatorColor  = [UIColor lightGrayColor];


    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://54.251.36.80:8081/Services/getMasters?type=ProductCategories&mallId=12"]];
       NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        productCategoryArray=[dic valueForKey:@"jobs"];
    //    NSLog(@"%@",[categoryArray objectAtIndex:0]);
    //     NSLog(@"%@",[categoryArray valueForKey:@"Icon_URL"]);


}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [productCategoryArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"Products";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
     
    
    cell.textLabel.text = [[productCategoryArray objectAtIndex:indexPath.row]valueForKey:@"Name"];
    
    //NSString *urlString=[NSString stringWithFormat:@"%@",[[productCategoryArray objectAtIndex:indexPath.row]valueForKey:@"Icon_URL"]];
    //    NSLog(@"%@",urlString);
       //cell.imageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
   cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
    
    cell.textLabel.highlightedTextColor = [UIColor darkGrayColor];
    return cell;
}






- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] init];
    UIImageView *imageViewForImage=[[UIImageView alloc]init];
    imageViewForImage.frame = CGRectMake(0, 10, 320, 25);
    UILabel *leftlabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320, 25)];
    leftlabel.text=@"Products";
    [leftlabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0]];
    //    imageViewForImage.image = [UIImage imageNamed:@"borderimg.gif"];
    //    imageViewForImage.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth;
    //
    //    [imageViewForImage.layer setBorderColor: [[UIColor blackColor] CGColor]];
    //    [imageViewForImage.layer setBorderWidth: 1.2];
    //    [imageViewForImage addSubview:leftlabel];
    
    
    
    [headerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    //[headerView addSubview:imageViewForImage];
    [headerView addSubview:leftlabel];
    UIView *seperatorView;
    CGRect sepFrame = CGRectMake(0,22, 320, 3);
    seperatorView = [[UIView alloc] initWithFrame:sepFrame];
    seperatorView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
    seperatorView.backgroundColor = [UIColor colorWithWhite:224.0/255.0 alpha:3.0];
    [headerView addSubview:seperatorView];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
	if (indexPath.section == 0)
	{
		UIViewController *vc ;
		
		switch (indexPath.row)
		{
			case 0:
                
				vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
				break;
				
			case 1:
				vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
				break;
				
			case 2:
				vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"HomeViewController"];
				break;
				
            case 3:
				vc = [mainStoryboard instantiateViewControllerWithIdentifier: @"ProductSubcategoryViewController"];
                               break;
			case 4:
				[[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
				return;
				break;
		}
		
		[[SlideNavigationController sharedInstance] switchToViewController:vc withCompletion:nil];
	}
	else
	{
		id <SlideNavigationContorllerAnimator> revealAnimator;
		
		switch (indexPath.row)
		{
			case 0:
				revealAnimator = nil;
				break;
				
			case 1:
				revealAnimator = [[SlideNavigationContorllerAnimatorSlide alloc] init];
				break;
				
			case 2:
				revealAnimator = [[SlideNavigationContorllerAnimatorFade alloc] init];
				break;
				
			case 3:
				revealAnimator = [[SlideNavigationContorllerAnimatorSlideAndFade alloc] initWithMaximumFadeAlpha:.7 fadeColor:[UIColor purpleColor] andSlideMovement:100];
				break;
				
			case 4:
				revealAnimator = [[SlideNavigationContorllerAnimatorScale alloc] init];
				break;
				
			case 5:
				revealAnimator = [[SlideNavigationContorllerAnimatorScaleAndFade alloc] initWithMaximumFadeAlpha:.6 fadeColor:[UIColor blueColor] andMinimumScale:.7];
				break;
				
			default:
				return;
		}
		
		[[SlideNavigationController sharedInstance] closeMenuWithCompletion:^{
			[SlideNavigationController sharedInstance].menuRevealAnimator = revealAnimator;
		}];
	}
}

@end

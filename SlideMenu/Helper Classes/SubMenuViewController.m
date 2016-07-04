//
//  SubMenuViewController.m
//  SlideMenu
//
//  Created by Mentor Insight India pvt Ltd on 21/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "SubMenuViewController.h"
#import "MyCell.h"

static NSString *CellIdentifier = @"MyCell";
@interface SubMenuViewController ()

@end

@implementation SubMenuViewController


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
//    [subMenuTbl setSeparatorInset:UIEdgeInsetsZero];
//    subMenuTbl.separatorColor  = [UIColor lightGrayColor];
    self.collectuinView.backgroundColor=[UIColor whiteColor];
NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://54.251.36.80:8081/Services/getMasters?type=P3rdLevelCategories&mallId=12"]];
NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
NSString *string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
NSLog(@"%@",string);
NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
menuSubcategoryArray=[dic valueForKey:@"jobs"];
NSLog(@"%@",[menuSubcategoryArray objectAtIndex:1]);
NSLog(@"%@",[menuSubcategoryArray valueForKey:@"Icon_URL"]);

    
    NSDictionary *dict1 = [menuSubcategoryArray objectAtIndex:2];
   NSLog(@"%@",dict1);
    
    filtered = [[NSMutableArray alloc]init];
    
    for (int i=0;i<[menuSubcategoryArray count];i++)
    {
        NSDictionary* item=[menuSubcategoryArray objectAtIndex:i];
        
        if ([@"SOUPS(54992)"  isEqual: [item objectForKey:@"SubCategory"]] )
        {
            [filtered addObject:item];
        }
        NSLog(@"filtered details is=======%@", filtered);
        NSLog(@"array count====%i",filtered.count);
    }
//    for (NSDictionary *myDict in menuSubcategoryArray){
//        NSLog(@"%@", [myDict objectForKey:@"SubCategory"]);
//    }


}

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
MyCell *cell = (MyCell *)[collectionView
dequeueReusableCellWithReuseIdentifier:CellIdentifier
forIndexPath:indexPath];
   // UILabel *label=(UILabel*)[cell viewWithTag:100];
    //label.text=[[filtered objectAtIndex:indexPath.row]valueForKey:@"Name"];
    NSString *urlString=[NSString stringWithFormat:@"%@",[[filtered objectAtIndex:indexPath.row]valueForKey:@"Icon_URL"]];
 image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
//     cellImgView.image=image;
    //cellTxtLabel.text=[[filtered objectAtIndex:indexPath.row]valueForKey:@"Name"];
    cell.myCellLabel.text =[[filtered objectAtIndex:indexPath.row]valueForKey:@"Name"];
    cell.myCellImgView.image=image;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
//        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
//        [[segue destinationViewController] setDetailItem:object];
//    }
//}

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
///*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//	return @"Product Category";
//}*/
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
//      NSString *urlString=[NSString stringWithFormat:@"%@",[[filtered objectAtIndex:indexPath.row]valueForKey:@"Icon_URL"]];
//    //    NSLog(@"%@",urlString);
//      cell.imageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
//    //    cell.textLabel.textAlignment = NSTextAlignmentLeft;
//    cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
//    
//    cell.textLabel.highlightedTextColor = [UIColor darkGrayColor];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




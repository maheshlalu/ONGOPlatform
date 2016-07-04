//
//  StarterViewController.m
//  SlideMenu
//
//  Created by Mentor Insight India pvt Ltd on 24/02/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "StarterViewController.h"

@interface StarterViewController ()

@end

@implementation StarterViewController

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
    
    [starterMenuTbl setSeparatorInset:UIEdgeInsetsZero];
    starterMenuTbl.separatorColor  = [UIColor lightGrayColor];
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
        
        if ([@"STARTERS(55247)"  isEqual: [item objectForKey:@"SubCategory"]] )
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // tableView.rowHeight=60;
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//return (section == 0) ? 4 : 6;
    return [filtered count];
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 return @"Product Category";
 }*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.textLabel.text=[[filtered objectAtIndex:indexPath.row]valueForKey:@"Name"];
    //    cell.textLabel.text=[[categoryArray objectAtIndex:indexPath.row]valueForKey:@"Name"];
    NSString *urlString=[NSString stringWithFormat:@"%@",[[filtered objectAtIndex:indexPath.row]valueForKey:@"Icon_URL"]];
    //    NSLog(@"%@",urlString);
    cell.imageView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    //    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
    
    cell.textLabel.highlightedTextColor = [UIColor darkGrayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

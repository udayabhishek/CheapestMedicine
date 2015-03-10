//
//  SearchByCategoryViewController.m
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import "SearchByCategoryViewController.h"

@interface SearchByCategoryViewController ()

@end

@implementation SearchByCategoryViewController
@synthesize titleString;
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
    
    self.title=titleString;
    categoryArray=[[NSMutableArray alloc]init];
    checkNetwork=[[NetworkChecking alloc]init];
    
  
   
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self makeRequestForCategoryOfMedicineList];
    
}

-(void)makeRequestForCategoryOfMedicineList{
   
    spinnerView.hidden=NO;
    if (![checkNetwork reachable])
    {
       
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"Unable to reach the network"
                              delegate:nil
                              cancelButtonTitle:@"Dismiss"
                              otherButtonTitles:nil, nil];
        [alert show];
        spinnerView.hidden=YES;
    }
    else
    {
   
        CategoryRequestClass *cat=[[CategoryRequestClass alloc]init];
      cat.CategorySearchDelegate=self;
      [cat makeRequestForCheckingListOfCategories];
        spinnerView.hidden=NO;
       
    }

    }
-(void)successJSONParsingCategorySearch:(NSMutableDictionary *)responseDictionary
{
    spinnerView.hidden=YES;
    
    
    if ([[responseDictionary valueForKey:@"Failure"] isEqualToString:@"null"]) {
        
        UIAlertView *alert_medicineSearch = [[UIAlertView alloc]initWithTitle:@"" message:@"No results found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert_medicineSearch show];
        
    }

    
    if ([responseDictionary count])
    {

        categoryArray=  [responseDictionary objectForKey:@"category"];
    
    }
    [categoryTableView reloadData];
}
-(void)failureJSONParsingCategorySearchResult
{
    spinnerView.hidden=YES;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning!" message:@"server is not responding" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     alert.tag=123;
    [alert show];
   
   //[self.navigationController popViewControllerAnimated:YES];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ((buttonIndex==0)&&(alertView.tag=123)) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark -   UITableView Delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (categoryTableView.tag == 10)
	{
        return [filteredCategoryArray count];
    }
    
    if ([categoryArray count]) {
        return categoryArray.count;
    }
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
    }
    else{
        
        cell.textLabel.adjustsFontSizeToFitWidth=YES;
    }
    
    if (categoryTableView.tag == 10)
	{
        cell.textLabel.text= [filteredCategoryArray objectAtIndex:indexPath.row];
    }
    else{
        cell.textLabel.text=[categoryArray objectAtIndex:indexPath.row];
    }
    if (categoryTableView.tag==0) {
        cell.textLabel.text=[categoryArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [categoryTableView deselectRowAtIndexPath:indexPath animated:YES];
    CategoryMedicineViewController *category;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
    category=[[CategoryMedicineViewController alloc]initWithNibName:@"CategoryMedicineViewController_iPad" bundle:nil];
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (IS_IPHONE_5){
        category=[[CategoryMedicineViewController alloc]initWithNibName:@"CategoryMedicineViewController" bundle:nil];
        }
        
        else{
            category=[[CategoryMedicineViewController alloc]initWithNibName:@"CategoryMedicineViewController_iPhone" bundle:nil];
        }
    }
    if (categoryTableView.tag == 10)
	{
        category.medicineString= [filteredCategoryArray objectAtIndex:indexPath.row];
    }
    
    else{
        
        category.medicineString=[NSString stringWithFormat:@"%@",[categoryArray objectAtIndex:indexPath.row]];
        
        
    }
    [self.navigationController pushViewController:category animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}


#pragma mark - UISearchDisplayController Delegate Methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self filterContentForSearchText:searchBar.text scope:searchBar.text];
    [searchBar setShowsCancelButton:YES animated:YES];
    
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    categoryTableView.tag=0;
    [searchBar setText:@""];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];

    [categoryTableView reloadData];
    
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchText];
    NSArray *filterArr= [[categoryArray filteredArrayUsingPredicate:resultPredicate] mutableCopy];
    filteredCategoryArray=[NSMutableArray arrayWithArray:filterArr];
    categoryTableView.tag = 10;
    [searchCategory resignFirstResponder];
    [categoryTableView reloadData];
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

@end

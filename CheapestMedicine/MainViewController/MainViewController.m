//
//  MainViewController.m
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    self.title=@"Cheapest Medicine";
    checkNetwork=[[NetworkChecking alloc]init];
    spinnerView.hidden=YES;
    
    
}
-(IBAction)actionForSearchByCategory:(id)sender
{
    SearchByCategoryViewController *category;
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
    
    else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            
            category=[[SearchByCategoryViewController alloc]initWithNibName:@"SearchByCategoryViewController_iPad" bundle:nil];
            
        }
        else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            if (IS_IPHONE_5) {
                category=[[SearchByCategoryViewController alloc]initWithNibName:@"SearchByCategoryViewController" bundle:nil];
            }
            
            else{
                category=[[SearchByCategoryViewController alloc]initWithNibName:@"SearchByCategoryViewController_iPhone" bundle:nil];
            }
        }
        category.titleString=@"Category Search";
        [self.navigationController pushViewController:category animated:YES];
    }
    
}
-(IBAction)actionForSearchByGeneric:(id)sender{
    SearchByGenericViewController *generic;
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
    
    else{
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            generic=[[SearchByGenericViewController alloc]initWithNibName:@"SearchByGenericViewController__iPad" bundle:nil];
        }
        else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            if (IS_IPHONE_5){
                generic=[[SearchByGenericViewController alloc]initWithNibName:@"SearchByGenericViewController" bundle:nil];
                
            }
            else{
                generic=[[SearchByGenericViewController alloc]initWithNibName:@"SearchByGenericViewController_iPhone" bundle:nil];
            }
        }
        generic.titleString=@"Generic Search";
        [self.navigationController pushViewController:generic animated:YES];
    }
    
}
-(IBAction)actionForSearchByName:(id)sender{
    spinnerView.hidden=NO;
    
    SearchByNameViewController *name;
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
    
    else {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            name=[[SearchByNameViewController alloc]initWithNibName:@"SearchByNameViewController_iPad" bundle:nil];
        }
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            if (IS_IPHONE_5){
                name=[[SearchByNameViewController alloc]initWithNibName:@"SearchByNameViewController" bundle:nil];
                
            }
            else{
                name=[[SearchByNameViewController alloc]initWithNibName:@"SearchByNameViewController_iPhone" bundle:nil];
            }
        }
                name.titleString=@"Name Search";
        [self.navigationController pushViewController:name animated:YES];
    }
 }

-(IBAction)actionForAppicationSetting:(id)sender{
    ApplicationSettingsViewController *settings;
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
    
    else{
        if (UI_USER_INTERFACE_IDIOM() ==UIUserInterfaceIdiomPad ) {
            settings=[[ApplicationSettingsViewController alloc]initWithNibName:@"ApplicationSettingsViewController_iPad" bundle:nil];
        }
        else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            if (IS_IPHONE_5) {
                settings=[[ApplicationSettingsViewController alloc]initWithNibName:@"ApplicationSettingsViewController" bundle:nil];
            }
            
            else{
                settings=[[ApplicationSettingsViewController alloc]initWithNibName:@"ApplicationSettingsViewController_iPhone" bundle:nil];
            }
        }
        
        [self.navigationController pushViewController:settings animated:YES];
    }
 }

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    spinnerView.hidden=YES;
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
}

@end

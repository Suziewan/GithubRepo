//
//  ViewController.m
//  GithubRepos
//
//  Created by Angie Linton on 2017-01-30.
//  Copyright © 2017 Angie Linton. All rights reserved.
//

#import "ViewController.h"
#import "GithubTableView.h"
#import "RepoTableViewCell.h"
#import "Repos.h"

@interface ViewController ()
@property (nonatomic) NSDictionary *repo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/Suziewan/repos"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error){
        if (error) {
            NSLog(@"ERROR: %@", error.localizedDescription);
            return ;
        }
        NSError *jsonError = nil;
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        for (NSDictionary *repo in repos) {
            NSString *repoName = repo[@"name"];
            NSLog(@"repo: %@", repoName);
            };
    [dataTask resume];
    
    }
                                      
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RepoTableViewCell *cell = (RepoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   
    //the class,.the variable name i am creating = self.theDictionaryProperty[then where we are getting it -- the indexpath and (in this case) the row] -- could be the section instead.
    Repos *repoList = self.repoName[indexPath.row];
    
     //cell, the lable I want to affect, then setText:theVariableName.theProperty
    cell.repoLabel setText:repoList.name;

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.repo.count;
}

                                      
@end







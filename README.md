# iOSEssentials


### Below objective C code will show/ remove a loading screen over the view
``` objective C
-(void) showLoadingIndicator{

    loadingView = [[UIView alloc] initWithFrame:self.view.frame];
    loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [spinner setCenter:CGPointMake(self.view.frame.size.width / 2,self.view.frame.size.height / 2)];
    [loadingView setBackgroundColor: [UIColor blackColor]];
    [loadingView setAlpha:0.5];
    [self.view setUserInteractionEnabled:NO];
    [spinner setAlpha:1.0];
    [loadingView addSubview:spinner];
    [spinner startAnimating];
    loadingView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview: loadingView];
    
    [loadingView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [loadingView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [loadingView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [loadingView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

-(void) removeLoadingIndicator{
    [self.view setUserInteractionEnabled:YES];
    [self.view setAlpha:1.0];
    [spinner stopAnimating];
    [spinner removeFromSuperview];
    [loadingView removeFromSuperview];
}
```


### TableRoWHeight / estimatedRowHeight
Normally, a cell’s height is determined by the table view delegate’s tableView:heightForRowAtIndexPath:method. 
To enable self-sizing table view cells, you must set the table view’s rowHeight property to UITableViewAutomaticDimension. You must also assign a value to the estimatedRowHeight property. As soon as both of these properties are set, the system uses Auto Layout to calculate the row’s actual height.
* tableView.estimatedRowHeight = 85.0
* tableView.rowHeight = UITableViewAutomaticDimension


### UserDefault
Save data in userdefault:
``` Swift
UserDefaults.standard.set(indexPath.row, forKey: "myIndex")
```
Then retrieve the data from any viewController:
``` Swift
If UserDefaults.standard.object(forKey: "myIndex"){
	let savedIndexPAth = UserDefaults.standard.integer(forKey: "myIndex")
}
```

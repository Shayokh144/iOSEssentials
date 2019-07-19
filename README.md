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

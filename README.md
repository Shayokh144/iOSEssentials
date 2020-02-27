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
UserDefaults.standard.set(IntegerData, forKey: "myIndex") // other datatypes can be saved also
// key must be unique for each userDefault
```
Then retrieve the data from any viewController:
``` Swift
If UserDefaults.standard.object(forKey: "myIndex"){
	let savedIndexPAth = UserDefaults.standard.integer(forKey: "myIndex")
}
```

### CollectionView Scroll Direction 
Change CollectionView Scroll Direction :
``` Swift
if let flowLayout = firstCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
       flowLayout.scrollDirection = .vertical // .horizontal
}
```

### semanticContentAttribute
semanticContentAttribute can force an Item alignment
``` Swift
Button.semanticContentAttribute = .forceLeftToRight
//this will force "Button" to LeftToRight in any situation like RTL also
```

### [content hugging and content compression resistance priorities](https://medium.com/@abhimuralidharan/ios-content-hugging-and-content-compression-resistance-priorities-476fb5828ef)

### [setNeedsLayout() layoutIfNeeded() layoutSubviews()](https://medium.com/@abhimuralidharan/ios-swift-setneedslayout-vs-layoutifneeded-vs-layoutsubviews-5a2b486da31c)

### [GCD vs NSOperation the two threading options in iOS](https://stackoverflow.com/questions/10373331/nsoperation-vs-grand-central-dispatch)

### iOS StatusBar theme Change:
``` Swift
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNeedsStatusBarAppearanceUpdate()
}
override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
}
```

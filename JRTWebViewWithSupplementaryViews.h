
@interface JRTWebViewWithSupplementaryViews : UIWebView <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

@end

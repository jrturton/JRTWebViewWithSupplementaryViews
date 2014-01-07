#import "JRTWebViewWithSupplementaryViews.h"

@implementation JRTWebViewWithSupplementaryViews

{
    CGSize contentSize;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.scrollView.delegate = self;
    }
    return self;
}

-(void)setHeaderView:(UIView *)headerView
{
    [_headerView removeFromSuperview];
    _headerView = headerView;
    [self.scrollView addSubview:headerView];
    UIEdgeInsets inset = self.scrollView.contentInset;
    inset.top = headerView.bounds.size.height;
    self.scrollView.contentInset = inset;
    self.scrollView.scrollIndicatorInsets = inset;
    [self setNeedsLayout];
}

-(void)setFooterView:(UIView *)footerView
{
    [_footerView removeFromSuperview];
    _footerView = footerView;
    [self.scrollView addSubview:footerView];
    UIEdgeInsets inset = self.scrollView.contentInset;
    inset.bottom = footerView.bounds.size.height;
    self.scrollView.contentInset = inset;
    self.scrollView.scrollIndicatorInsets = inset;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutSupplementaryViews];
}

- (void)layoutSupplementaryViews
{
    if(self.headerView)
    {
        CGRect frame = self.headerView.frame;
        frame.origin.y = -frame.size.height;
        self.headerView.frame = frame;
    }
    if (self.footerView)
    {
        CGRect frame = self.footerView.frame;
        frame.origin.y = self.scrollView.contentSize.height;
        self.footerView.frame = frame;
    }
    contentSize = self.scrollView.contentSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!CGSizeEqualToSize(contentSize, scrollView.contentSize))
    {
        [self layoutSupplementaryViews];
    }
    UIEdgeInsets indicatorInsets = UIEdgeInsetsZero;
    if (self.headerView)
    {
        float bottomOfHeaderView = MAX(0, -scrollView.contentOffset.y);
        indicatorInsets.top = bottomOfHeaderView;
    }
    if (self.footerView)
    {
        CGPoint topOfFooter = [self convertPoint:CGPointZero fromView:self.footerView];
        if (CGRectContainsPoint(self.bounds, topOfFooter))
        {
            indicatorInsets.bottom = self.bounds.size.height - topOfFooter.y;
        }
    }
    self.scrollView.scrollIndicatorInsets = indicatorInsets;
}

@end

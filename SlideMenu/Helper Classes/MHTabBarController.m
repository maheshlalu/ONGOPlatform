/*
 * Copyright (c) 2011-2012 Matthijs Hollemans
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "MHTabBarController.h"


@interface TView : UIView

@end

@implementation TView

-(void)drawRect:(CGRect)rect
{
    [[UIColor redColor]set];
    [[UIBezierPath bezierPathWithRect:rect]  fill];
}

@end

static const NSInteger TagOffset = 1000;

@implementation MHTabBarController
{
	UIView *tabButtonsContainerView;
	UIView *contentContainerView;
	UIImageView *indicatorImageView;
    
}

//-(UIView*)view
//{
//
//}

- (void)viewDidLoad
{
	[super viewDidLoad];
    // self.view = [TView new];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	CGRect rect = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.tabBarHeight);
	tabButtonsContainerView = [[UIView alloc] initWithFrame:rect];
    //tabButtonsContainerView.backgroundColor = [UIColor blueColor];
	tabButtonsContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:tabButtonsContainerView];
    
	rect.origin.y = self.tabBarHeight;
	rect.size.height = self.view.bounds.size.height - self.tabBarHeight;
	contentContainerView = [[UIView alloc] initWithFrame:rect];
    //contentContainerView.backgroundColor = [UIColor redColor];
    
	contentContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:contentContainerView];
    
    //	indicatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MHTabBarIndicator"]];
    //	[self.view addSubview:indicatorImageView];
    
	[self reloadTabButtons];
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	[self layoutTabButtons];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Only rotate if all child view controllers agree on the new orientation.
	for (UIViewController *viewController in self.viewControllers)
	{
		if (![viewController shouldAutorotateToInterfaceOrientation:interfaceOrientation])
			return NO;
	}
	return YES;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
    
	if ([self isViewLoaded] && self.view.window == nil)
	{
		self.view = nil;
		tabButtonsContainerView = nil;
		contentContainerView = nil;
		indicatorImageView = nil;
	}
}

- (void)reloadTabButtons
{
	[self removeTabButtons];
	[self addTabButtons];
    
	// Force redraw of the previously active tab.
	NSUInteger lastIndex = _selectedIndex;
	_selectedIndex = NSNotFound;
	self.selectedIndex = lastIndex;
}

- (void)addTabButtons
{
	NSUInteger index = 0;
	for (UIViewController<MHTabBarItemController> *viewController in self.viewControllers)
	{
        
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.tag = TagOffset + index;
		button.titleLabel.font = [UIFont boldSystemFontOfSize:13];
		button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        
		UIOffset offset = viewController.tabBarItem.titlePositionAdjustment;
		button.titleEdgeInsets = UIEdgeInsetsMake(offset.vertical, offset.horizontal, 0.0f, 0.0f);
		button.imageEdgeInsets = viewController.tabBarItem.imageInsets;
        
        if([viewController respondsToSelector:@selector(tabBGColor)])
        {
            button.backgroundColor = viewController.tabBGColor;
            tabButtonsContainerView.backgroundColor = viewController.tabBGColor;
        }
        else
        {
            button.backgroundColor = [UIColor colorWithRed:143.0f/255 green:185.0f/255 blue:207.0f/255 alpha:1.0f];
            tabButtonsContainerView.backgroundColor = button.backgroundColor;
        }
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [button setTitle:viewController.tabItemName forState:UIControlStateNormal];

        
        
        
		[button addTarget:self action:@selector(tabButtonPressed:) forControlEvents:UIControlEventTouchDown];
        
		[self deselectTabButton:button forIndex:index];
		[tabButtonsContainerView addSubview:button];
        
		++index;
        
        if(index < self.viewControllers.count)
        {
            CGFloat x;
            if(self.isTabBarItemWidthResize)
            {
                x = floorf(self.view.bounds.size.width / [self.viewControllers count]);
            }
            else
            {
                x = self.tabBarItemWidth;
            }

            
            UIView* separatorView = [[UIView alloc] initWithFrame:CGRectMake(x-2, 5, 2, self.tabBarHeight-10)];
            separatorView.backgroundColor = [UIColor colorWithRed:196.0f/255 green:196.0f/255 blue:196.0f/255 alpha:1.0f];
            [button addSubview:separatorView];
        }
        
        UIView* selectedBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tabBarHeight-5, self.tabBarItemWidth-5, 2)];
        selectedBottomLineView.backgroundColor = viewController.tabBGColor;
        selectedBottomLineView.tag = 900;
        [button addSubview:selectedBottomLineView];
        
        
	}
}

- (void)removeTabButtons
{
	while ([tabButtonsContainerView.subviews count] > 0)
	{
		[[tabButtonsContainerView.subviews lastObject] removeFromSuperview];
	}
}

- (void)layoutTabButtons
{
	NSUInteger index = 0;
	NSUInteger count = [self.viewControllers count];
    
    CGRect rect;
    if(self.isTabBarItemWidthResize)
    {
        rect = CGRectMake(0.0f, 0.0f, floorf(self.view.bounds.size.width / count), self.tabBarHeight);
    }
    else
    {
        rect = CGRectMake(0.0f, 0.0f, self.tabBarItemWidth, self.tabBarHeight);
    }
    
	indicatorImageView.hidden = YES;
    
	NSArray *buttons = [tabButtonsContainerView subviews];
	for (UIButton *button in buttons)
	{
        if(self.isTabBarItemWidthResize)
        {
            if (index == count - 1)
                rect.size.width = self.view.bounds.size.width - rect.origin.x;
        }
        
        
		button.frame = rect;
		rect.origin.x += rect.size.width;
        
		if (index == self.selectedIndex)
			[self centerIndicatorOnButton:button];
        
		++index;
	}
}

- (void)centerIndicatorOnButton:(UIButton *)button
{
	CGRect rect = indicatorImageView.frame;
	rect.origin.x = button.center.x - floorf(indicatorImageView.frame.size.width/2.0f);
	rect.origin.y = self.tabBarHeight - indicatorImageView.frame.size.height;
	indicatorImageView.frame = rect;
	indicatorImageView.hidden = NO;
}

- (void)setViewControllers:(NSArray *)newViewControllers
{
	NSAssert([newViewControllers count] >= 2, @"MHTabBarController requires at least two view controllers");
    
	UIViewController *oldSelectedViewController = self.selectedViewController;
    
	// Remove the old child view controllers.
	for (UIViewController *viewController in _viewControllers)
	{
		[viewController willMoveToParentViewController:nil];
		[viewController removeFromParentViewController];
	}
    
	_viewControllers = [newViewControllers copy];
    
	// This follows the same rules as UITabBarController for trying to
	// re-select the previously selected view controller.
	NSUInteger newIndex = [_viewControllers indexOfObject:oldSelectedViewController];
	if (newIndex != NSNotFound)
		_selectedIndex = newIndex;
	else if (newIndex < [_viewControllers count])
		_selectedIndex = newIndex;
	else
		_selectedIndex = 0;
    
	// Add the new child view controllers.
	for (UIViewController *viewController in _viewControllers)
	{
		[self addChildViewController:viewController];
		[viewController didMoveToParentViewController:self];
	}
    
	if ([self isViewLoaded])
    {
		[self reloadTabButtons];
        [self layoutTabButtons];
    }
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex
{
	[self setSelectedIndex:newSelectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex animated:(BOOL)animated
{
    if(newSelectedIndex >= [self.viewControllers count])
    {
        NSLog(@"View controller index out of bounds");
        return;
        //NSAssert(newSelectedIndex < [self.viewControllers count], @"View controller index out of bounds");
    }
    
	if ([self.delegate respondsToSelector:@selector(mh_tabBarController:shouldSelectViewController:atIndex:)])
	{
		UIViewController *toViewController = (self.viewControllers)[newSelectedIndex];
		if (![self.delegate mh_tabBarController:self shouldSelectViewController:toViewController atIndex:newSelectedIndex])
			return;
	}
    
	if (![self isViewLoaded])
	{
		_selectedIndex = newSelectedIndex;
	}
	else if (_selectedIndex != newSelectedIndex)
	{
		UIViewController *fromViewController;
		UIViewController *toViewController;
        
		if (_selectedIndex != NSNotFound)
		{
			UIButton *fromButton = (UIButton *)[tabButtonsContainerView viewWithTag:TagOffset + _selectedIndex];
			[self deselectTabButton:fromButton forIndex:_selectedIndex];
			fromViewController = self.selectedViewController;
		}
        
		NSUInteger oldSelectedIndex = _selectedIndex;
		_selectedIndex = newSelectedIndex;
        
		UIButton *toButton;
		if (_selectedIndex != NSNotFound)
		{
			toButton = (UIButton *)[tabButtonsContainerView viewWithTag:TagOffset + _selectedIndex];
			[self selectTabButton:toButton forIndex:_selectedIndex];
			toViewController = self.selectedViewController;
		}
        
		if (toViewController == nil)  // don't animate
		{
			[fromViewController.view removeFromSuperview];
		}
		else if (fromViewController == nil)  // don't animate
		{
			toViewController.view.frame = contentContainerView.bounds;
			[contentContainerView addSubview:toViewController.view];
			[self centerIndicatorOnButton:toButton];
            
			if ([self.delegate respondsToSelector:@selector(mh_tabBarController:didSelectViewController:atIndex:)])
				[self.delegate mh_tabBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
		}
		else if (animated)
		{
			CGRect rect = contentContainerView.bounds;
			if (oldSelectedIndex < newSelectedIndex)
				rect.origin.x = rect.size.width;
			else
				rect.origin.x = -rect.size.width;
            
			toViewController.view.frame = rect;
			tabButtonsContainerView.userInteractionEnabled = NO;
            
			[self transitionFromViewController:fromViewController
                              toViewController:toViewController
                                      duration:0.3f
                                       options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseOut
                                    animations:^
             {
                 CGRect rect = fromViewController.view.frame;
                 if (oldSelectedIndex < newSelectedIndex)
                     rect.origin.x = -rect.size.width;
                 else
                     rect.origin.x = rect.size.width;
                 
                 fromViewController.view.frame = rect;
                 toViewController.view.frame = contentContainerView.bounds;
                 [self centerIndicatorOnButton:toButton];
             }
                                    completion:^(BOOL finished)
             {
                 tabButtonsContainerView.userInteractionEnabled = YES;
                 
                 if ([self.delegate respondsToSelector:@selector(mh_tabBarController:didSelectViewController:atIndex:)])
                     [self.delegate mh_tabBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
             }];
		}
		else  // not animated
		{
			[fromViewController.view removeFromSuperview];
            
			toViewController.view.frame = contentContainerView.bounds;
			[contentContainerView addSubview:toViewController.view];
			[self centerIndicatorOnButton:toButton];
            
			if ([self.delegate respondsToSelector:@selector(mh_tabBarController:didSelectViewController:atIndex:)])
				[self.delegate mh_tabBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
		}
	}
}

- (UIViewController *)selectedViewController
{
	if (self.selectedIndex != NSNotFound)
		return (self.viewControllers)[self.selectedIndex];
	else
		return nil;
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController
{
	[self setSelectedViewController:newSelectedViewController animated:NO];
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController animated:(BOOL)animated
{
	NSUInteger index = [self.viewControllers indexOfObject:newSelectedViewController];
	if (index != NSNotFound)
		[self setSelectedIndex:index animated:animated];
}

- (void)tabButtonPressed:(UIButton *)sender
{
	[self setSelectedIndex:sender.tag - TagOffset animated:YES];
}

#pragma mark - Change these methods to customize the look of the buttons

- (void)selectTabButton:(UIButton *)button forIndex:(NSUInteger)index
{
    for(UIView* sView in [button subviews])
    {
        if(sView.tag == 900)
        {
            [sView setBackgroundColor:[UIColor redColor]];
        }
    }
    
    //	[button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //	UIImage *image = [self.tabItemsImageList[index+index+1] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    //	[button setBackgroundImage:image forState:UIControlStateNormal];
    //	[button setBackgroundImage:image forState:UIControlStateHighlighted];
	
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	//[button setTitleShadowColor:[UIColor colorWithWhite:0.0f alpha:0.5f] forState:UIControlStateNormal];
}

- (void)deselectTabButton:(UIButton *)button forIndex:(NSUInteger)index
{
    for(UIView* sView in [button subviews])
    {
        if(sView.tag == 900)
        {
            [sView setBackgroundColor:tabButtonsContainerView.backgroundColor];
        }
    }
    
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //	UIImage *image = [self.tabItemsImageList[index+index] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    //	[button setBackgroundImage:image forState:UIControlStateNormal];
    //	[button setBackgroundImage:image forState:UIControlStateHighlighted];
    
    //	[button setTitleColor:[UIColor colorWithRed:175/255.0f green:85/255.0f blue:58/255.0f alpha:1.0f] forState:UIControlStateNormal];
	//[button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (CGFloat)tabBarHeight
{
	return 50.0f;
}

- (CGFloat)tabBarItemWidth
{
    return 150.0f;
}

@end

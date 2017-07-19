//
//  ViewController.m
//  HookSystemCode
//
//  Created by 王金东 on 2016/7/19.
//  Copyright © 2016年 王金东. All rights reserved.
//

#import "ViewController.h"
#import "JDHookCode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //可以获取你想看的类的所有方法 然后通过Method Swizzling 想干任何事
    JDCode *code = [JDHookCode hookClassWithSuper:self.navigationController];
    
    NSLog(@"%@",code);
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

//比如下面看到的是navigation的方法 400多个  vc里面更多 恐怖吧

/*
 .cxx_destruct=v16@0:8,
 dealloc=v16@0:8,
 setDelegate:=v24@0:8@16,
 traitCollectionDidChange:=v24@0:8@16,
 navigationBar=@16@0:8,
 _clipUnderlapWhileTransitioning=B16@0:8,
 _interactionController=@16@0:8,
 _isTransitioning=B16@0:8,
 _shouldUseBuiltinInteractionController=B16@0:8,
 _shouldPopFromLandscapeToPortraitOrientation=B16@0:8,
 isNavigationBarHidden=B16@0:8,
 _existingToolbar=@16@0:8,
 topViewController=@16@0:8,
 navigationItem=@16@0:8,
 previousViewController=@16@0:8,
 setInteractiveTransition:=v20@0:8B16,
 _shouldUseBuiltinAnimator=B16@0:8,
 _setShouldUseBuiltinAnimator:=v20@0:8B16,
 popViewControllerAnimated:=@20@0:8B16,
 _snapshotView=@16@0:8,
 canPerformAction:withSender:=B32@0:8:16@24,
 preferredStatusBarStyle=q16@0:8,
 supportedInterfaceOrientations=Q16@0:8,
 _deepestUnambiguousResponder=@16@0:8,
 loadView=v16@0:8,
 encodeRestorableStateWithCoder:=v24@0:8@16,
 decodeRestorableStateWithCoder:=v24@0:8@16,
 initWithNibName:bundle:=@32@0:8@16@24,
 shouldAutorotateToInterfaceOrientation:=B24@0:8q16,
 _transitionCoordinator=@16@0:8,
 preferredFocusedView=@16@0:8,
 preferredFocusEnvironments=@16@0:8,
 _subclassPreferredFocusedViewPrioritizationType=q16@0:8,
 _didUpdateFocusInContext:withAnimationCoordinator:=v32@0:8@16@24,
 _overridingDestinationEnvironmentForFocusUpdateInContext:=@24@0:8@16,
 viewWillAppear:=v20@0:8B16,
 viewDidAppear:=v20@0:8B16,
 viewWillDisappear:=v20@0:8B16,
 viewDidDisappear:=v20@0:8B16,
 viewDidMoveToWindow:shouldAppearOrDisappear:=v28@0:8@16B24,
 _gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:=B32@0:8@16@24,
 _gestureRecognizer:shouldReceiveTouch:=B32@0:8@16@24,
 setNavigationBar:=v24@0:8@16,
 _updatePaletteConstraints=v16@0:8,
 _updatePalettesWithBlock:=v24@0:8@?16,
 _navigationBarDidChangeStyle:=v24@0:8@16,
 _setUpContentFocusContainerGuide=v16@0:8,
 navigationBarDidChangeOpacity:=v24@0:8@16,
 _hasInterruptibleNavigationTransition=B16@0:8,
 _willPerformCustomNavigationTransitionForPush=B16@0:8,
 _shouldCrossFadeNavigationBar=B16@0:8,
 _isInteractiveCustomNavigationTransition=B16@0:8,
 _customNavigationTransitionDuration=d16@0:8,
 navigationBar:shouldPopItem:=B32@0:8@16@24,
 _willPerformCustomNavigationTransitionForPop=B16@0:8,
 _navigationBarDidEndAnimation:=v24@0:8@16,
 enableBackButtonDuringTransition=B16@0:8,
 navigationBarDidResizeForPrompt:=v24@0:8@16,
 navigationBar:buttonClicked:=v28@0:8@16i24,
 _updateInteractiveTransition:=v24@0:8d16,
 _gestureRecognizerShouldBegin:=B24@0:8@16,
 _contentFocusContainerGuide=@16@0:8,
 editing=B16@0:8,
 setEditing:animated:=v24@0:8B16B20,
 _builtinInteractionController=@16@0:8,
 durationForTransition:=d20@0:8i16,
 _setIsWrappingDuringAdaptation:=v20@0:8B16,
 preferredContentSizeDidChangeForChildContentContainer:=v24@0:8@16,
 _updateLayoutForStatusBarAndInterfaceOrientation=v16@0:8,
 sizeForChildContentContainer:withParentContainerSize:={CGSize=dd}40@0:8@16{CGSize=dd}24,
 viewWillTransitionToSize:withTransitionCoordinator:=v40@0:8{CGSize=dd}16@32,
 preferredContentSize={CGSize=dd}16@0:8,
 willTransitionToTraitCollection:withTransitionCoordinator:=v32@0:8@16@24,
 isModalInPopover=B16@0:8,
 _performBackGesture:=v24@0:8@16,
 _viewControllerUnderlapsStatusBar=B16@0:8,
 _edgeInsetsForChildViewController:insetsAreAbsolute:={UIEdgeInsets=dddd}32@0:8@16^B24,
 _updateChildContentMargins=v16@0:8,
 _avoidanceInsets={UIEdgeInsets=dddd}16@0:8,
 preferredInterfaceOrientationForPresentation=q16@0:8,
 contentSizeForViewInPopover={CGSize=dd}16@0:8,
 setContentSizeForViewInPopover:=v32@0:8{CGSize=dd}16,
 _viewForContentInPopover=@16@0:8,
 _isPresentationContextByDefault=B16@0:8,
 _shouldPersistViewWhenCoding=B16@0:8,
 setSearchBarHidNavBar:=v20@0:8B16,
 viewDidUnload=v16@0:8,
 _didGainChildScrollView:=v24@0:8@16,
 viewControllerForUnwindSegueAction:fromViewController:withSender:=@40@0:8:16@24@32,
 allowedChildViewControllersForUnwindingFromSource:=@24@0:8@16,
 updateTitleForViewController:=v24@0:8@16,
 _backdropBarGroupName=@16@0:8,
 _viewsWithDisabledInteractionGivenTransitionContext:=@24@0:8@16,
 purgeMemoryForReason:=v20@0:8i16,
 _shouldChildViewControllerUseFullScreenLayout:=B24@0:8@16,
 _reallyWantsFullScreenLayout=B16@0:8,
 _frameForContainerViewInSheetForBounds:displayingTopView:andBottomView:={CGRect={CGPoint=dd}{CGSize=dd}}56@0:8{CGRect={CGPoint=dd}{CGSize=dd}}16B48B52,
 _keyboardDirectionForTransition:=i24@0:8q16,
 _isSupportedInterfaceOrientation:=B24@0:8q16,
 _transitionController=@16@0:8,
 pushViewController:animated:=v28@0:8@16B24,
 modalTransitionStyle=q16@0:8,
 _setTransitionController:=v24@0:8@16,
 _setInteractionController:=v24@0:8@16,
 willRotateToInterfaceOrientation:duration:=v32@0:8q16d24,
 willAnimateRotationToInterfaceOrientation:duration:=v32@0:8q16d24,
 didRotateFromInterfaceOrientation:=v24@0:8q16,
 _childViewControllersToSendViewWillTransitionToSize=@16@0:8,
 _allowsAutorotation=B16@0:8,
 _shouldSynthesizeSupportedOrientations=B16@0:8,
 _hasPreferredInterfaceOrientationForPresentation=B16@0:8,
 rotatingHeaderView=@16@0:8,
 rotatingFooterView=@16@0:8,
 _shouldUseOnePartRotation=B16@0:8,
 willAnimateFirstHalfOfRotationToInterfaceOrientation:duration:=v32@0:8q16d24,
 willAnimateSecondHalfOfRotationFromInterfaceOrientation:duration:=v32@0:8q16d24,
 _getRotationContentSettings:=v24@0:8^{?=BBBBBdi}16,
 didAnimateFirstHalfOfRotationToInterfaceOrientation:=v24@0:8q16,
 childViewControllerForStatusBarStyle=@16@0:8,
 childViewControllerForStatusBarHidden=@16@0:8,
 childViewControllerForWhitePointAdaptivityStyle=@16@0:8,
 searchBarHidNavBar=B16@0:8,
 _isNestedNavigationController=B16@0:8,
 _lastNavigationItems=@16@0:8,
 bottomViewController=@16@0:8,
 _willBecomeContentViewControllerOfPopover:=v24@0:8@16,
 _didBecomeContentViewControllerOfPopover:=v24@0:8@16,
 _didResignContentViewControllerOfPopover:=v24@0:8@16,
 _prepareForPresentationInPopover:=v24@0:8@16,
 _prepareForDismissalInPopover:=v24@0:8@16,
 segueForUnwindingToViewController:fromViewController:identifier:=@40@0:8@16@24@32,
 unwindForSegue:towardsViewController:=v32@0:8@16@24,
 showViewController:sender:=v32@0:8@16@24,
 rotatingSnapshotViewForWindow:=@24@0:8@16,
 defaultPNGName=@16@0:8,
 _updateInteractivePopGestureEnabledState=v16@0:8,
 _prepareForNestedDisplayWithNavigationController:=v24@0:8@16,
 _prepareForNormalDisplayWithNavigationController:=v24@0:8@16,
 _allowNestedNavigationControllers=B16@0:8,
 _setAllowNestedNavigationControllers:=v20@0:8B16,
 _rememberPresentingFocusedItem:=v24@0:8@16,
 updateTabBarItemForViewController:=v24@0:8@16,
 tabBarItem=@16@0:8,
 _moreListTitle=@16@0:8,
 moreListImage=@16@0:8,
 moreListSelectedImage=@16@0:8,
 moreListTableCell=@16@0:8,
 collapseSecondaryViewController:forSplitViewController:=v32@0:8@16@24,
 separateSecondaryViewControllerForSplitViewController:=@24@0:8@16,
 _topBarHeight=d16@0:8,
 _updateToolbarItemsFromViewController:animated:=v28@0:8@16B24,
 _additionalViewControllersToCheckForUserActivity=@16@0:8,
 _viewControllerWasSelected=B16@0:8,
 _navigationBarForDragAffordance=@16@0:8,
 _stopTransitionsImmediately=v16@0:8,
 disappearingViewController=@16@0:8,
 setDisappearingViewController:=v24@0:8@16,
 setNavigationBarClass:=v24@0:8#16,
 _setToolbarClass:=v24@0:8#16,
 toolbar=@16@0:8,
 _confirmBarAccessMethods=v16@0:8,
 _setVisualAltitudeForBar:=v24@0:8@16,
 setHidesBarsWhenKeyboardAppears:=v20@0:8B16,
 setHidesBarsOnSwipe:=v20@0:8B16,
 setHidesBarsWhenVerticallyCompact:=v20@0:8B16,
 setHidesBarsOnTap:=v20@0:8B16,
 _navigationItemsCallingPublicAccessor:=@20@0:8B16,
 _setKeyboardAppearedNotificationToken:=v24@0:8@16,
 _setBarSwipeHideGesture:=v24@0:8@16,
 _setInteractiveAnimationCoordinator:=v24@0:8@16,
 _setBarTapHideGesture:=v24@0:8@16,
 _releaseContainerViews=v16@0:8,
 _setCachedTransitionController:=v24@0:8@16,
 _setCachedInteractionController:=v24@0:8@16,
 _setToolbarAnimationId:=v24@0:8@16,
 _positionNavigationBarHidden:edge:initialOffset:=v36@0:8B16Q20d28,
 _positionPaletteHidden:edge:initialOffset:=v36@0:8B16Q20d28,
 visibleViewController=@16@0:8,
 setViewControllers:animated:=v28@0:8@16B24,
 _transitionForOldViewControllers:newViewControllers:=i32@0:8@16@24,
 _prepareCollectionViewControllers:forSharingInRange:=v32@0:8@16@24,
 _setViewControllers:transition:animated:=v32@0:8@16i24B28,
 _transitionConflictsWithNavigationTransitions:=B24@0:8@16,
 needsDeferredTransition=B16@0:8,
 _outermostNavigationController=@16@0:8,
 _navigationItems=@16@0:8,
 interactivePopGestureRecognizer=@16@0:8,
 _existingNavigationBar=@16@0:8,
 _allowChildSplitViewControllers=B16@0:8,
 _setViewControllers_7_0:transition:animated:operation:=v40@0:8@16i24B28q32,
 _setViewControllers:transition:animated:operation:=v40@0:8@16i24B28q32,
 setNeedsDeferredTransition=v16@0:8,
 _usesTransitionController=B16@0:8,
 _customTransitionController:=@20@0:8B16,
 allowUserInteractionDuringTransition=B16@0:8,
 _presentationTransitionWrapViewController:forTransitionContext:=v32@0:8@16@24,
 _customInteractionController:=@24@0:8@16,
 setCustomNavigationTransitionDuration:=v24@0:8d16,
 customNavigationTransitionDuration=d16@0:8,
 _startDeferredTransitionIfNeeded=v16@0:8,
 _propagateContentAdjustmentsForControllersWithSharedViews=v16@0:8,
 _hideOrShowBottomBarIfNeededWithTransition:=v20@0:8i16,
 _executeNavigationHandler:deferred:=v28@0:8@?16B24,
 _startDeferredTransitionIfNeeded:=v24@0:8@16,
 _toolbarAnimationId=@16@0:8,
 _navbarAnimationId=@16@0:8,
 _setNavigationBarAnimationWasCancelled:=v20@0:8B16,
 _setToolbarAnimationWasCancelled:=v20@0:8B16,
 _startInteractiveBarTransition:=@24@0:8@16,
 _setNavbarAnimationId:=v24@0:8@16,
 _navbarIsAppearingInteractively=B16@0:8,
 _navigationBarForNestedNavigationController=@16@0:8,
 _updateInteractiveBarTransition:withUUID:percent:isFinished:didComplete:completionSpeed:completionCurve:=v64@0:8@16@24d32B40B44d48q56,
 _toolbarIsAnimatingInteractively=B16@0:8,
 isCustomTransition=B16@0:8,
 _isUsingBuiltinAnimator=B16@0:8,
 _shouldCrossFadeBottomBars=B16@0:8,
 isInteractiveTransition=B16@0:8,
 _setToolbarHidden:edge:duration:=v36@0:8B16Q20d28,
 _startInteractiveToolbarTransition=v16@0:8,
 _transitionAnimationContext=@16@0:8,
 _isViewControllerFullScene=B16@0:8,
 _frameForViewController:={CGRect={CGPoint=dd}{CGSize=dd}}24@0:8@16,
 _privateWillShowViewController:=v24@0:8@16,
 _startToolbarTransitionIfNecessary:animated:=v28@0:8@16B24,
 _startPaletteTransitionIfNecessary:animated:=v28@0:8@16B24,
 _updateScrollViewFromViewController:toViewController:=v32@0:8@16@24,
 _frameForWrapperViewForViewController:={CGRect={CGPoint=dd}{CGSize=dd}}24@0:8@16,
 _deferredTransition=i16@0:8,
 _keyboardAnimationStyle=@16@0:8,
 _isPerformingLayoutToLayoutTransition=B16@0:8,
 navigationTransitionView=@16@0:8,
 navigationTransitionView:didEndTransition:fromView:toView:=v48@0:8@16q24@32@40,
 _setPreferredContentSizeFromChildContentContainer:=v24@0:8@16,
 _navigationTransitionView:didCancelTransition:fromViewController:toViewController:wrapperView:=v56@0:8@16q24@32@40@48,
 _setUsingBuiltinAnimator:=v20@0:8B16,
 _finishInteractiveTransition:transitionContext:=v32@0:8d16@24,
 _cancelInteractiveTransition:transitionContext:=v32@0:8d16@24,
 _isAlreadyPoppingNavItem=B16@0:8,
 _interruptibleNavigationTransitionAnimator=@16@0:8,
 _navigationTransitionForUITransition:=q20@0:8i16,
 navigationTransitionView:didStartTransition:=v32@0:8@16q24,
 _navigationBarHiddenByDefault:=@20@0:8B16,
 _setBackdropGroupName:=v24@0:8@16,
 _backdropGroupName=@16@0:8,
 _positionNavigationBarHidden:=v20@0:8B16,
 setNavigationBarHidden:animated:=v24@0:8B16B20,
 _setNavigationBarHidden:edgeIfNotNavigating:duration:=v36@0:8B16Q20d28,
 _setNavigationBarHidden:edge:duration:=v36@0:8B16Q20d28,
 _positionTopBar:hidden:edge:center:offset:=v60@0:8@16B24Q28{CGPoint=dd}36d52,
 _navigationBarAnimationWasCancelled=B16@0:8,
 _positionForBar:=q24@0:8@16,
 _frameForPalette:={CGRect={CGPoint=dd}{CGSize=dd}}24@0:8@16,
 _computeTopBarCenter:hidden:edge:center:offset:={CGPoint=dd}60@0:8@16B24Q28{CGPoint=dd}36d52,
 _setNavigationBarHidesCompletelyOffscreen:=v20@0:8B16,
 _hasNestedNavigationController=B16@0:8,
 _computeAndApplyScrollContentInsetDeltaForViewController:=v24@0:8@16,
 _layoutTopViewController=v16@0:8,
 _repositionPaletteWithNavigationBarHidden:duration:shouldUpdateNavigationItems:=v32@0:8B16d20B28,
 wasLastOperationAnimated=B16@0:8,
 lastOperation=q16@0:8,
 _animationParametersForHidingNavigationBar:lastOperation:edge:duration:=B44@0:8B16q20^Q28^d36,
 _positionNavigationBarHidden:edge:=v28@0:8B16Q20,
 _searchHidNavigationBar=B16@0:8,
 _useStandardStatusBarHeight=B16@0:8,
 _positionPaletteHidden:edge:=v28@0:8B16Q20,
 _startInteractiveNavbarTransition=v16@0:8,
 _hideShowNavigationBarDidStop:finished:context:=v40@0:8@16@24@32,
 _layoutTopViewControllerInSheet=v16@0:8,
 setPretendNavBarHidden:=v20@0:8B16,
 isToolbarHidden=B16@0:8,
 _positionToolbarHidden:=v20@0:8B16,
 _configureBarsAutomaticActions=v16@0:8,
 _configureToolbar=v16@0:8,
 setToolbarHidden:animated:=v24@0:8B16B20,
 _positionToolbarHidden:edge:=v28@0:8B16Q20,
 _positionToolbarHidden:edge:crossFade:=v32@0:8B16Q20B28,
 _toolbarAnimationWasCancelled=B16@0:8,
 _hideShowToolbarDidStop:finished:context:=v40@0:8@16@24@32,
 _rememberFocusedItem:forViewController:=v32@0:8@16@24,
 _recallRememberedFocusedItemForViewController:=@24@0:8@16,
 _forgetFocusedItemForViewController:=v24@0:8@16,
 _rememberedFocusedItemsByViewController=@16@0:8,
 _updateBarsForCurrentInterfaceOrientation=v16@0:8,
 _viewControllerForDisappearCallback=@16@0:8,
 viewControllers=@16@0:8,
 popToViewController:animated:=@28@0:8@16B24,
 _presentationTransitionUnwrapViewController:=v24@0:8@16,
 _clearLastOperation=v16@0:8,
 didShowViewController:animated:=v28@0:8@16B24,
 setNeedsDeferredTransition:=v20@0:8B16,
 _isNavigationBarVisible=B16@0:8,
 _hasTranslucentNavigationBarIncludingViewController:=B24@0:8@16,
 _shouldNavigationBarInsetViewControllerPreInnsbruck:=B24@0:8@16,
 _isNavigationBarEffectivelyVisible=B16@0:8,
 _shouldNavigationBarInsetViewController:orOverlayContent:=B32@0:8@16^B24,
 _shouldTabBar:insetViewController:orOverlayContent:=B40@0:8@16@24^B32,
 _shouldToolBar:insetViewController:orOverlayContent:=B40@0:8@16@24^B32,
 _shouldNavigationBarInsetViewController:=B24@0:8@16,
 existingPaletteForEdge:=@24@0:8Q16,
 _shouldStatusBarInsetViewController:=B24@0:8@16,
 _shouldLayoutViewControllerForTransparentStatusBar:=B24@0:8@16,
 _shouldBottomBarBeHidden=B16@0:8,
 _layoutViewController:=v24@0:8@16,
 _shouldToolBar:insetViewController:=B32@0:8@16@24,
 _shouldTabBar:insetViewController:=B32@0:8@16@24,
 _scrollViewTopContentInsetForViewController:=d24@0:8@16,
 _scrollViewBottomContentInsetForViewController:=d24@0:8@16,
 _expectedContentInsetDeltaForViewController:={UIEdgeInsets=dddd}24@0:8@16,
 willShowViewController:animated:=v28@0:8@16B24,
 _startTransition:fromViewController:toViewController:=v36@0:8i16@20@28,
 _startCustomTransition:=v24@0:8@16,
 _notifyTransitionBegan:=v24@0:8@16,
 _updateNavigationBarHandler=@?16@0:8,
 _setUpdateNavigationBarHandler:=v24@0:8@?16,
 _setIsNestedNavigationController:=v20@0:8B16,
 setToolbarHidden:=v20@0:8B16,
 _prepareCollectionViewControllerForSharing:=v24@0:8@16,
 pushViewController:transition:forceImmediate:=v32@0:8@16i24B28,
 _playPushNavigationSound=v16@0:8,
 _nthChildViewControllerFromTop:=@24@0:8Q16,
 _popViewControllerWithTransition:allowPoppingLast:=@24@0:8i16B20,
 _findViewControllerToPopTo=@16@0:8,
 _didExplicitlyHideTabBar=B16@0:8,
 _popViewControllerAndUpdateInterfaceOrientationAnimated:=v20@0:8B16,
 popToRootViewControllerWithTransition:=@20@0:8i16,
 popToViewController:transition:=@28@0:8@16i24,
 popViewControllerWithTransition:=@20@0:8i16,
 _doesTopViewControllerSupportInterfaceOrientation:=B24@0:8q16,
 _shouldHideBarsForTraits:=B24@0:8@16,
 _useCrossFadeForGestureHiding=B16@0:8,
 _existingToolbarWithItems=@16@0:8,
 _findViewControllerToPopToForNavigationItem:=@24@0:8@16,
 _configureKeyboardBarHiding=v16@0:8,
 _configureBarSwipeGesture=v16@0:8,
 _configureBarTapGesture=v16@0:8,
 _setBarsHidden:allowAnimation:=v24@0:8B16B20,
 _hideForKeyboardAppearance=v16@0:8,
 hidesBarsOnSwipe=B16@0:8,
 _makeBarSwipeGestureIfNecessary=v16@0:8,
 _makeBarHideGestureIfNecessary=v16@0:8,
 _gestureRecognizedInteractiveHide:=v24@0:8@16,
 _barInteractiveAnimationCoordinator=@16@0:8,
 _gestureRecognizedToggleVisibility:=v24@0:8@16,
 _setBarsHidden:=v20@0:8B16,
 _layoutTopViewControllerInSheetWithPopoverView:=v24@0:8@16,
 pretendNavBarHidden=B16@0:8,
 _adjustedContentSizeForPopover:={CGSize=dd}32@0:8{CGSize=dd}16,
 _setClipUnderlapWhileTransitioning:=v20@0:8B16,
 _layoutTopViewControllerOutOfSheet=v16@0:8,
 __viewWillLayoutSubviews=v16@0:8,
 _layoutContainerViewSemanticContentAttributeChanged:=v24@0:8@16,
 initWithRootViewController:=@24@0:8@16,
 initWithNavigationBarClass:toolbarClass:=@32@0:8#16#24,
 _isCrossfadingOutTabBar=B16@0:8,
 _isCrossfadingInTabBar=B16@0:8,
 _setCrossfadingOutTabBar:=v20@0:8B16,
 _setCrossfadingInTabBar:=v20@0:8B16,
 _setDidExplicitlyHideTabBar:=v20@0:8B16,
 _setUseCurrentStatusBarHeight:=v20@0:8B16,
 _setUseStandardStatusBarHeight:=v20@0:8B16,
 _useCurrentStatusBarHeight=B16@0:8,
 setAllowUserInteractionDuringTransition:=v20@0:8B16,
 setEnableBackButtonDuringTransition:=v20@0:8B16,
 setViewControllers:=v24@0:8@16,
 _setAllowChildSplitViewControllers:=v20@0:8B16,
 _setViewControllers:transition:=v28@0:8@16i24,
 _setViewControllers_7_0:transition:animated:=v32@0:8@16i24B28,
 _setClipsToBounds:=v20@0:8B16,
 _setContentInset:=v48@0:8{UIEdgeInsets=dddd}16,
 _setBuiltinTransitionStyle:=v24@0:8q16,
 _setBuiltinTransitionGap:=v24@0:8d16,
 navigationBarClass=#16@0:8,
 setNavigationBarHidden:=v20@0:8B16,
 _setSearchHidNavigationBar:=v20@0:8B16,
 avoidMovingNavBarOffscreenBeforeUnhiding=B16@0:8,
 setAvoidMovingNavBarOffscreenBeforeUnhiding:=v20@0:8B16,
 _sendNavigationBarToBack=v16@0:8,
 setToolbar:=v24@0:8@16,
 isShown=B16@0:8,
 _screenEdgePanGestureRecognizer=@16@0:8,
 navigationTransitionView:durationForTransition:=d32@0:8@16q24,
 isBuiltinTransition=B16@0:8,
 _setCustomTransition:=v20@0:8B16,
 _builtinTransitionController=@16@0:8,
 pushViewController:transition:=v28@0:8@16i24,
 _resetBottomBarHiddenState=v16@0:8,
 _updateBottomBarHiddenState=v16@0:8,
 _tabBarControllerDidFinishShowingTabBar:isHidden:=v28@0:8@16B24,
 popViewControllerWithAnimationTransition:duration:curve:=@40@0:8q16d24q32,
 popToRootViewControllerAnimated:=@20@0:8B16,
 popToViewControllerWithSnapbackIdentifier:animated:=@28@0:8@16B24,
 _setPreferredNavigationBarPosition:=v24@0:8q16,
 _setKeyboardNotificationToken:=v24@0:8@16,
 condensesBarsOnSwipe=B16@0:8,
 setCondensesBarsOnSwipe:=v20@0:8B16,
 barHideOnSwipeGestureRecognizer=@16@0:8,
 barHideOnTapGestureRecognizer=@16@0:8,
 _playPopNavigationSound=v16@0:8,
 _setNavigationSoundsEnabled:=v20@0:8B16,
 _navigationSoundsEnabled=B16@0:8,
 _toolbarClass=#16@0:8,
 hidesBarsWhenKeyboardAppears=B16@0:8,
 hidesBarsWhenVerticallyCompact=B16@0:8,
 hidesBarsOnTap=B16@0:8,
 _builtinTransitionStyle=q16@0:8,
 _builtinTransitionGap=d16@0:8,
 _preferredNavigationBarPosition=q16@0:8,
 _cachedTransitionController=@16@0:8,
 _cachedInteractionController=@16@0:8,
 _keyboardAppearedNotificationToken=@16@0:8,
 _barSwipeHideGesture=@16@0:8,
 _barTapHideGesture=@16@0:8,
 _topPalette=@16@0:8,
 setDetailViewController:=v24@0:8@16,
 detailViewController=@16@0:8,
 isExpanded=B16@0:8,
 setIsExpanded:=v20@0:8B16,
 _boundsForPalette:size:={CGRect={CGPoint=dd}{CGSize=dd}}40@0:8@16{CGSize=dd}24,
 _pinningBarForPalette:=@24@0:8@16,
 attachPalette:isPinned:=v28@0:8@16B24,
 detachPalette:isInPaletteTransition:=v28@0:8@16B24,
 _detachPalette:=v24@0:8@16,
 detachPalette:=v24@0:8@16,
 paletteForEdge:size:=@40@0:8Q16{CGSize=dd}24,
 _prepareCollectionViewController:forSharingWithCollectionViewController:=v32@0:8@16@24,
 encodeWithCoder:=v24@0:8@16,
 initWithCoder:=@24@0:8@16,
 delegate=@16@0:8,
 setPreferredContentSize:=v32@0:8{CGSize=dd}16,
 becomeFirstResponder=B16@0:8
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

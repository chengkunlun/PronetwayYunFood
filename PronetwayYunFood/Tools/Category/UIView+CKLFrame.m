//
//  UIView+CKLFrame.m
//  mansoryLayout
//
//  Created by ckl@pmm on 16/8/29.
//  Copyright © 2016年 CKLPronetway. All rights reserved.
//

#import "UIView+CKLFrame.h"
#import <objc/runtime.h>

@implementation UIView (CKLFrame)

//  返回高度
- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}
//  返回宽度
- (CGFloat)width
{
    return self.frame.size.width;
}

//  设置宽度
- (void)setWidth:(CGFloat)newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

//  返回X
- (CGFloat)X
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat) newX
{
    CGRect newframe = self.frame;
    newframe.origin.x = newX;
    self.frame = newframe;
}

//  返回Y
- (CGFloat)Y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)newY
{
    CGRect newframe = self.frame;
    newframe.origin.y = newY;
    self.frame = newframe;
}

//  返回X + width
- (CGFloat)endX
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setEndX:(CGFloat)newEndX
{
    CGFloat delta = newEndX - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

//  返回Y + Height
- (CGFloat)endY
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setEndY:(CGFloat)newEndY
{
    CGRect newframe = self.frame;
    newframe.origin.y = newEndY - self.frame.size.height;
    self.frame = newframe;
}

- (void)makeDraggable
{
    NSAssert(self.superview, @"Super view is required when make view draggable");
    
    [self makeDraggableInView:self.superview damping:0.4];
}

- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping
{
    if (!view) return;
    [self removeDraggable];
    
    self.zy_playground = view;
    self.zy_damping = damping;
    
    [self zy_creatAnimator];
    [self zy_addPanGesture];
}

- (void)removeDraggable
{
    [self removeGestureRecognizer:self.zy_panGesture];
    self.zy_panGesture = nil;
    self.zy_playground = nil;
    self.zy_animator = nil;
    self.zy_snapBehavior = nil;
    self.zy_attachmentBehavior = nil;
    self.zy_centerPoint = CGPointZero;
}

- (void)updateSnapPoint
{
    self.zy_centerPoint = [self convertPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) toView:self.zy_playground];
    self.zy_snapBehavior = [[UISnapBehavior alloc] initWithItem:self snapToPoint:self.zy_centerPoint];
    self.zy_snapBehavior.damping = self.zy_damping;
}

- (void)zy_creatAnimator
{
    self.zy_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.zy_playground];
    [self updateSnapPoint];
}

- (void)zy_addPanGesture
{
    self.zy_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(zy_panGesture:)];
    [self addGestureRecognizer:self.zy_panGesture];
}

#pragma mark - Gesture

- (void)zy_panGesture:(UIPanGestureRecognizer *)pan
{
    CGPoint panLocation = [pan locationInView:self.zy_playground];
    
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        UIOffset offset = UIOffsetMake(panLocation.x - self.zy_centerPoint.x, panLocation.y - self.zy_centerPoint.y);
        [self.zy_animator removeAllBehaviors];
        self.zy_attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self
                                                               offsetFromCenter:offset
                                                               attachedToAnchor:panLocation];
        [self.zy_animator addBehavior:self.zy_attachmentBehavior];
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        [self.zy_attachmentBehavior setAnchorPoint:panLocation];
    }
    else if (pan.state == UIGestureRecognizerStateEnded ||
             pan.state == UIGestureRecognizerStateCancelled ||
             pan.state == UIGestureRecognizerStateFailed)
    {
        [self.zy_animator removeAllBehaviors];
        [self.zy_animator addBehavior:self.zy_snapBehavior];
    }
}

#pragma mark - Associated Object

- (void)setZy_playground:(id)object {
    objc_setAssociatedObject(self, @selector(zy_playground), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)zy_playground {
    return objc_getAssociatedObject(self, @selector(zy_playground));
}

- (void)setZy_animator:(id)object {
    objc_setAssociatedObject(self, @selector(zy_animator), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIDynamicAnimator *)zy_animator {
    return objc_getAssociatedObject(self, @selector(zy_animator));
}

- (void)setZy_snapBehavior:(id)object {
    objc_setAssociatedObject(self, @selector(zy_snapBehavior), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UISnapBehavior *)zy_snapBehavior {
    return objc_getAssociatedObject(self, @selector(zy_snapBehavior));
}

- (void)setZy_attachmentBehavior:(id)object {
    objc_setAssociatedObject(self, @selector(zy_attachmentBehavior), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIAttachmentBehavior *)zy_attachmentBehavior {
    return objc_getAssociatedObject(self, @selector(zy_attachmentBehavior));
}

- (void)setZy_panGesture:(id)object {
    objc_setAssociatedObject(self, @selector(zy_panGesture), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIPanGestureRecognizer *)zy_panGesture {
    return objc_getAssociatedObject(self, @selector(zy_panGesture));
}

- (void)setZy_centerPoint:(CGPoint)point {
    objc_setAssociatedObject(self, @selector(zy_centerPoint), [NSValue valueWithCGPoint:point], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint)zy_centerPoint {
    return [objc_getAssociatedObject(self, @selector(zy_centerPoint)) CGPointValue];
}

- (void)setZy_damping:(CGFloat)damping {
    objc_setAssociatedObject(self, @selector(zy_damping), @(damping), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)zy_damping {
    return [objc_getAssociatedObject(self, @selector(zy_damping)) floatValue];
}

-(void)AddNaVBar:(NSString*)Title TextColor:(UIColor*)TextColor Bg:(UIColor*)bacgroundColor {

    
}


@end

// RUN: rm -rf %t
// RUN: %clang_cc1 -objcmt-migrate-protocol-conformance -mt-migrate-directory %t %s -x objective-c -fobjc-runtime-has-weak -fobjc-arc -triple x86_64-apple-darwin11
// RUN: c-arcmt-test -mt-migrate-directory %t | arcmt-test -verify-transformed-files %s.result
// RUN: %clang_cc1 -triple x86_64-apple-darwin10 -fsyntax-only -x objective-c -fobjc-runtime-has-weak -fobjc-arc %s.result

@interface NSObject @end

@protocol P
- (id) Meth1: (double) arg;
@end

@interface Test1  // Test for no super class and no protocol list
@end

@implementation Test1
- (id) Meth1: (double) arg { return 0; }
@end

@protocol P1 @end
@protocol P2 @end

@interface Test2 <P1, P2>  // Test for no super class and with protocol list
{
  id IVAR1;
  id IVAR2;
}
@end

@implementation Test2
- (id) Meth1: (double) arg { return 0; }
@end

@interface Test3 : NSObject  { // Test for Super class and no  protocol list
  id IV1;
}
@end

@implementation Test3
- (id) Meth1: (double) arg { return 0; }
@end

@interface Test4 : NSObject <P1, P2> // Test for Super class and protocol list
@end

@implementation Test4
- (id) Meth1: (double) arg { return 0; }
@end

// Test5 - conforms to P3 because it implement's P3's property.
@protocol P3
@property (copy) id Prop;
@end

@protocol P4
@property (copy) id Prop;
@end

@interface Test5 : NSObject<P3>
@end

@implementation Test5
@synthesize Prop=_XXX;
@end

@protocol P5 <P3, P4>
@property (copy) id Prop;
@end

@protocol P6 <P3, P4, P5>
@property (copy) id Prop;
@end

@interface Test6 : NSObject // Test for minimal listing of conforming protocols
@property (copy) id Prop;
@end

@implementation Test6 
@end

@class UIDynamicAnimator, UIWindow;
@interface UIResponder : NSObject
@end

@protocol EmptyProtocol
@end

@protocol OptionalMethodsOnly
@optional
- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator;
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator;
@end

@protocol OptionalPropertiesOnly
@optional
@property (strong, nonatomic) id OptionalProperty;
@end

@protocol OptionalEvrything
@optional
- (void)dynamicAnimatorWillResume:(UIDynamicAnimator*)animator;
@property (strong, nonatomic) id OptionalProperty;
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator*)animator;
@end

@protocol UIApplicationDelegate
@end

@interface Test7 : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@implementation Test7
@end

@interface BTLEBrowser
@end

@protocol CBCentralManagerDelegate; 

@protocol CBCentralManagerDelegate 
- (id) Meth1: (double) arg;
@end

@interface BTLEBrowser() <CBCentralManagerDelegate> 
@end

@implementation BTLEBrowser
- (id) Meth15515206: (double) arg { return 0; }
@end

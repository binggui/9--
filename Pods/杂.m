nsnull     addObject:


//目的: 不让返回值为nil
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    //如果该对象中没有该方法,则签名为nil(如果返回的方法签名为nil,则项目会立即崩溃 )
    if (signature != nil) return signature;
    
    //遍历各种类型,判断该方法是否在这些类型的对象中有实现
    for (NSObject *object in UXY_NullObjects)
    {
        signature = [object methodSignatureForSelector:selector];
        
        if (signature)
        {
            
            //判断当前类型的对象中该方法的实现是否有返回值
            if (strcmp(signature.methodReturnType, "@") == 0)
            {
                signature = [[NSNull null] methodSignatureForSelector:@selector(__returnNil)];
            }
            break;
        }
    }
    
    return signature;
}




- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if (strcmp(anInvocation.methodSignature.methodReturnType, "@") == 0)
    {
        anInvocation.selector = @selector(__uxy_nil);
        [anInvocation invokeWithTarget:self];
        return;
    }
    
    for (NSObject *object in UXY_NullObjects)
    {
        if ([object respondsToSelector:anInvocation.selector])
        {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    
    [self doesNotRecognizeSelector:anInvocation.selector];
}

- (id)__uxy_nil
{
    return nil;
}









1.AFN原理




2.服务器返回的数据中有value为🈳值

{
    “names” :,
    “age”: “22”,
}I


nsnull

http://www.cocoachina.com/ios/20130528/6295.html
http://www.cocoachina.com/ios/20150604/12013.html




3.block和代理区别

代理可以设置可选



4.UITableViewcell的优化
http://www.cocoachina.com/ios/20150602/11968.html



5. SDWebImage如果已经下载了图片,还会重新下载吗? url没有变,图片变了,sdwebimage会重新下载吗?如果不会,怎么办?
http://blog.csdn.net/xumugui007/article/details/51605546


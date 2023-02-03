---
layout: post
title: Why ABAP exception handling isn’t like playing catch with your dog
date: 2020-03-27 07:00
author: Johan Wigert
tags: [ABAP, ABAP fundamentals]
permalink: /2020-03-27-why-abap-exception-handling-isnt-like-playing-catch-with-your-dog/
---

I've been cleaning up some legacy ABAP code lately, and a reoccurring theme is poor exception handling. In this post, I'll explain why ABAP exception handling shouldn't be treated like a game of catch with your dog. I'll discuss some anti-patterns I've come across in the legacy code and give a few suggestions on how to improve your exception handling.
<!--more-->

## Catching `CX_ROOT`

Catching `CX_ROOT` looks something like this:

```abap
    TRY.
      zcl_my_class=>my_method( ).
      CATCH cx_root INTO DATA(lx_root).
        " do something, like logging the error;
        " or even worse, do nothing
    ENDTRY.
```

`CX_ROOT` is an abstract class and the super class of all exception classes. Catching `CX_ROOT` thus catches every possible exception that could be raised. This is a very broad approach to exception handling, which I'm not a big fan of. When you play catch with your dog, you always want the dog to catch all the balls. This is not an appropriate approach to ABAP exception handling and was the major inspiration for writing this blog post.

I think that exception handling should be as narrow and specific as possible. Hopefully `zcl_my_class=>my_method( )` only raises one specific exception, and the caller should only catch this exception.

I find it hard to imagine scenarios where it makes sense to catch every possible exception, especially when the CATCH clause is empty. Why would you want your code to continue executing when an unknown exception has occurred?

## Catching an exception just to raise it again

I've come across code which looks something like this:

```abap
    TRY.
      zcl_my_class=>my_method( ).
      CATCH cx_my_exception INTO DATA(lx_my_exception).
        RAISE EXCEPTION lx_my_exception.
    ENDTRY.
```

To catch an exception just to raise the same exception again makes no sense. It is much better to make sure that the exception is part of the method signature and just let the exception bubble up without catching it.

The only scenario I can think of where it would make sense to catch the exception to then raise it again is the scenario where the exception is logged first:

```abap
    TRY.
      zcl_my_class=>my_method( ).
      CATCH cx_my_exception INTO DATA(lx_my_exception).
        zcl_my_log_class=>write_to_log( lx_my_exception ).
        RAISE EXCEPTION lx_my_exception.
    ENDTRY.
```

## Not having the exception in the method signature

I've seen code where exceptions are raised, which are not part of the method signature. This makes the code fragile since the callers of the method don't know which exceptions to expect and thus don't see the need to implement proper exception handling on their end.

## Raising several different types of exceptions from the same method

I've seen methods with several exceptions in the method signature. The caller of the method would then have to catch several exceptions:

```abap
    TRY.
      zcl_my_class=>my_method( ).
      CATCH cx_my_exception1.
        ...
      CATCH cx_my_exception2.
        ...
    ENDTRY.
```

If a method raises several exceptions, it is probably a sign of the method doing several things. Consider [Clean ABAP: Do one thing, do it well, do it only](https://github.com/SAP/styleguides/blob/master/clean-abap/CleanABAP.md#do-one-thing-do-it-well-do-it-only).

If `zcl_my_class=>my_method( )` raises several exceptions, a refactoring should be done (see [Clean ABAP: Throw one type of exception](https://github.com/SAP/styleguides/blob/master/clean-abap/CleanABAP.md#throw-one-type-of-exception)).

## Catch is empty

Another scenario I've seen is that the exception is caught, but not acted upon, especially with an entertaining comment about how this should never happen:

```abap
    TRY.
      zcl_my_class=>my_method( ).
      CATCH cx_my_exception INTO DATA(lx_my_exception).
        " do nothing, since this should never happen...
    ENDTRY.
```

Maybe there is a scenario where the exception shouldn't be acted upon, but in that case, I would recommend to:
- Add a comment explaining why it is not necessary to act upon the exception.
- Not catch the exception into an object instance, when it is not being used.

```abap
    TRY.
      zcl_my_class=>my_method( ).
      CATCH cx_my_exception.
        " No action required since ...
    ENDTRY.
```

## The TRY-CATCH block is several hundred lines big

A violation of the recommendation [Clean ABAP: Keep methods small](https://github.com/SAP/styleguides/blob/master/clean-abap/CleanABAP.md#keep-methods-small) is to write huge blocks of code and then surrounding these huge blocks of code with a TRY-CATCH. Please keep your methods small, and the exception handling will be much easier to follow.

## Conclusion

The anti-patterns discussed above don't make up an exhaustive list of poor exception handling but illustrate some common pitfalls which should be avoided. If you have more examples, please feel free to add them in the comments section.

Happy exception handling!

_If you would like to comment on this post, please head over to [SAP Community](https://blogs.sap.com/2020/03/27/why-abap-exception-handling-isnt-like-playing-catch-with-your-dog/)._
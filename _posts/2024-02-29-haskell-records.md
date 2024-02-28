---
title: Haskell Records
date: 2024-02-29 09:00:00 +1300
categories: [Programming]
tags: [functional programming, haskell, programming]
pin: false
hidden: false
render_with_liquid: false
last_modified_at: 2024-02-29 09:00:00 +1300
---

## Introduction

Haskell records appear simple, but this simplicity belies some significant drawbacks. While there are a plethora of libraries and language extensions that improve ergonomics, the trade-offs are not immediately obvious.

This post describes two of the most popular approaches, with an eye towards future improvements.

## Records, a background

By records, we mean product types that have named fields. For example:

```java
class Employee {
  String name;
  String title;
  int age;

  class Employee(String n, String t, Int a) {
    this.name = n;
    this.title = t;
    this.age = a;
  }

  static String greetEmployee(Employee e) {
    return "Hello " + e.name + "!";
  }
}
```

We have a type representing an employee that includes fields for a name, title, and age. Not only do we have the fields themselves, we associate a _name_ with them. To see why this matters, consider the following haskell code:

```haskell
data Employee = MkEmployee String String Int

mkEmployee :: String -> String -> Int -> Employee
mkEmployee name title age = MkEmployee name title age

greetEmployee :: Employee -> String
greetEmployee (MkEmployee n _ _) = "Hello " ++ n ++ "!"
```

Like the java example, this declares an `Employee` type that takes two strings and an int. Unlike the java example, however, the fields are unnamed. To access them we have to use pattern-matching. The downside is that we have to remember which field is which. This is especially problematic when we have multiple fields with the same type. For instance, the following code typechecks, yet is clearly a mistake, as we use the field intended for the `title`, not the `name`:

```haskell
greetEmployee :: Employee -> String
greetEmployee (MkEmployee _ t _) = "Hello " ++ t ++ "!"
```

Not only is it easy to make mistakes, it also means we need to modify `greetEmployee` any time we add or remove a field from `Employee`.

Fortunately, haskell provides "record syntax" that allows us to name fields:

```haskell
data Employee = MkEmployee
  { name :: String,
    title :: String,
    age :: Int
  }

mkEmployee :: String -> String -> Int -> Employee
mkEmployee n t a =
  MkEmployee
    { name = n,
      title = t,
      age = a
    }

greetEmployee :: Employee -> String
greetEmployee e = "Hello " ++ name e ++ "!"
```

Much better! Pattern matching still works, but we can now use the names to write clearer code that is less vulnerable to updates. All is well, right?

## All is not well

### Problem 1: Duplicate Field Names

Suppose we want to create two types with the same field name:

```haskell
data Employee = MkEmployee
  { name :: String,
    title :: String,
    age :: Int
  }

data Company = MkCompany
  { name :: String,
    employee :: Employee -- it's a small company, okay?
  }
```

Unfortunately, these will not compile in the same module! The problem is that haskell's record syntax essentially generates "field selectors" for each field i.e. for `Employee`:

```haskell
name :: Employee -> String
name (MkEmployee n _ _) = n

title :: Employee -> String
title (MkEmployee _ t _) = n

age :: Employee -> Int
age (MkEmployee _ _ a) = a
```

So if we try to compile `Employee` and `Company` we'd have:

```haskell
name :: Employee -> String
name (MkEmployee n _ _) = n

name :: Company -> String
name (MkCompany n _) = n
```

But we cannot have two top-level functions with the same name, hence the error.[^fn1] The work-around is to declare these data types in different modules, and then qualify their usage:

```haskell
-- Employee.hs
data Employee = ...

-- Company.hs
data Company = ...

-- Lib.hs
module Lib where

import Company (Company)
import Company qualified as Company
import Employee (Employee)
import Employee qualified as Employee

msg :: Company -> String
msg c = Employee.name (Company.employee c) ++ " works at " ++ Company.name c
```

This works, but isn't terribly satisfying.

### Problem 2: Nested Updates

Haskell's record syntax offers a further convenience; we can model updates:

```haskell
setName :: Employee -> String -> Employee
setName e newName = e { name = newName }
```

The `setName` function takes an employee `e`, new name `n`, and returns a new employee that is the same as `e` except its name is `n`. This is useful as it means we do not have to manually copy over unchanged fields when we want to change just one.

There is a limitation, however: nested updates do not compose. That is, there is nothing like the following pseudo-syntax:

```haskell
setEmployeeName :: Company -> String -> Company
setEmployeeName c newEmpName = c { employee = employee { name = newEmpName } }
```

In other words, while update syntax allows us to update e.g. `company.employee` and `employee.name`, it does not work to update `company.employee.name`. This is unfortunate, as it greatly increases the difficulty of working with immutable data.[^fn2]

## Solution 1: OverloadedRecordDot

This is the simplest solution that will be the most familiar to users with experience in mainstream languages.

GHC 9.2 introduced the `-XOverloadedRecordDot` extension. With it, we can rewrite our modules as follows:

```haskell
{-# LANGUAGE DuplicateRecordFields #-} -- we need this too
{-# LANGUAGE OverloadedRecordDot #-}

module Data where

data Employee = MkEmployee
  { name :: String,
    title :: String,
    age :: Int
  }

data Company = MkCompany
  { name :: String,
    employee :: Employee
  }

msg :: Company -> String
msg c = c.employee.name ++ " works at " ++ c.name
```

Much nicer! Not only is this more concise and familiar, it allows both definition and usage of duplicate record fields, completely solving problem 1.

<!-- prettier-ignore-start -->

> Note that the record field needs to be in scope in order to use it. For example:
>
> ```haskell
> module Foo where
>
> import Data (Company (name)) -- need to import name here
>
> getCompanyGreeting :: Company -> String
> getCompanyGreeting c = c.name ++ " welcomes you"
>
> ```
{: .prompt-tip }

<!-- prettier-ignore-end -->

### Tell me the catch

While this neatly solves the problem of duplicate names, this does not help with nested updates. In fact, `-XOverloadedRecordDot` does not work for updates at all. For that, we need another extension, `-XOverloadedRecordUpdate`:

```haskell
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedRecordUpdate #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE RebindableSyntax #-} -- also required :-(
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Data where

import Prelude

-- Declare HasField class, getField, and setField

class HasField x r a | x r -> a where
  hasField :: r -> (a -> r, a)

getField :: forall x r a . HasField x r a => r -> a
getField = snd . hasField @x

setField :: forall x r a . HasField x r a => r -> a -> r
setField = fst . hasField @x

data Employee = MkEmployee
  { name :: String,
    title :: String,
    age :: Int
  }

-- manually write instances for each field that we want

instance HasField "name" Employee String where
  hasField e@(MkEmployee name title age) = (\n -> MkEmployee n title age, name)

data Company = MkCompany
  { name :: String,
    employee :: Employee
  }

instance HasField "employee" Company Employee where
  hasField c@(MkCompany name employee) = (\e -> MkCompany name e, employee)

-- now we can use it

setEmployeeName :: Company -> String -> Company
setEmployeeName c newEmpName = c { employee.name = newEmpName }
```

Yikes! As you can see, this is a far-cry from the simplicity of `-XOverloadedRecordDot`. The unfortunate truth is that as of GHC 9.8, `-XOverloadedRecordUpdate` is a bit of a hack. It relies on several other extensions -- including the huge hammer `-XRebindableSyntax` -- which can break all sorts of normal code.

Even the [docs](https://downloads.haskell.org/ghc/9.8.2/docs/users_guide/exts/overloaded_record_update.html) explicitly warn against using it.

There is good news, however. A proposal to improve the situation was accepted in [October 2023](https://github.com/ghc-proposals/ghc-proposals/pull/583), and updates should work after this is implemented. This will not cover _all_ use cases: type-changing updates will not immediately be supported. But this will easily cover 95% of typical record usage.

## Solution 2: Optics

Optics provide a second solution. Unlike `-XOverloadedRecordDot`, optics are not built-in; they are implemented at the library level. Not only do we therefore have to choose an optics library (there are many), there are often more choices to make. Here we choose [`optics-core`](https://hackage.haskell.org/package/optics-core) (and [`optics-th`](https://hackage.haskell.org/package/optics-th) for generating optics automatically) with `-XOverloadedLabels` style:

```haskell
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}

module Data where

import Optics.Core (set, view, (%))
import Optics.TH (makeFieldLabelsNoPrefix) -- optics-th library

data Employee = MkEmployee
  { name :: String,
    title :: String,
    age :: Int
  }

makeFieldLabelsNoPrefix ''Employee

data Company = MkCompany
  { name :: String,
    employee :: Employee
  }

makeFieldLabelsNoPrefix ''Company

msg :: Company -> String
msg c = view (#employee % #name) c ++ " works at " ++ view #name c

setEmployeeName :: Company -> String -> Company
setEmployeeName c newEmpName = set (#employee % #name) newEmpName c
```

First, we use `makeFieldLabelsNoPrefix` from the `optics-th` library to generate lenses (a type of optic). After this, we can implement our getter and setter functions simply using the `#<field-name>` syntax. To compose two lenses together, we use the `(%)` operator from `optics-core`. For instance, the equivalent of `myCompany.employee.name` is `view (#employee % #name) myCompany`.

TemplateHaskell (used in `makeFieldLabelsNoPrefix`) has several drawbacks. One of the major annoyances is how it requires the source code to be in a specific order. That is, normally you can reorder code in a Haskell module to your heart's content:

```haskell
a :: Int -> Int
a x = f x

f :: Int -> Int
f = ...

-- It makes no difference whether 'f' or 'a' comes first in a haskell source file.

f :: Int -> Int
f = ...

a :: Int -> Int
a x = f x
```

With TH this is no longer true. In particular, if you want to use the result of TH, the code that uses it must come _after_ the TH code.

```haskell
-- This works because the usage (msg) comes _after_ the TH definition
-- (makeFieldLabelsNoPrefix)
makeFieldLabelsNoPrefix ''Company

msg :: Company -> String
msg c = view (#employee % #name) c ++ " works at " ++ view #name c

-- The below does not work!

msg :: Company -> String
msg c = view (#employee % #name) c ++ " works at " ++ view #name c

makeFieldLabelsNoPrefix ''Company
```

This can be pretty frustrating. TH also comes with other drawbacks:

- Increases compilation time.
- Prevents cross-compilation.

Thus we can drop the dependency on `optics-th` and hand-write our lenses instead:

```haskell
import Optics.Core (A_Lens, lensVL, set, view, (%))
import Optics.Label (LabelOptic(labelOptic))

-- name lens for employee
instance LabelOptic "name" A_Lens Employee Employee String String where
  labelOptic = lensVL nameLensVL
    where
      nameLensVL :: Functor f => (String -> f String) -> Employee -> f Employee
      nameLensVL f (MkEmployee _name _title _age) =
        fmap (\name' -> MkEmployee name' _title _age) (f _name)

-- name lens for company
instance LabelOptic "name" A_Lens Company Company String String where
  labelOptic = lensVL nameLensVL
    where
      nameLensVL :: Functor f => (String -> f String) -> Company -> f Company
      nameLensVL f (MkCompany _name _employee) =
        fmap (\name' -> MkCompany name' _employee) (f _name)

-- employee lens for company
instance LabelOptic "employee" A_Lens Company Company Employee Employee where
  labelOptic = lensVL employeeLensVL
    where
      employeeLensVL :: Functor f => (Employee -> f Employee) -> Company -> f Company
      employeeLensVL f (MkCompany _name _employee) =
        fmap (\employee' -> MkCompany _name employee') (f _employee)
```

That's it! A bit heavy on the boilerplate, but this solves both duplicate fields **and** nested updates. Additionally, we receive nice features beyond normal getters and setters like _modify_.

```haskell
import Optics.Core (over)

-- using 'over' to _modify_ a nested field rather than simply setting or
-- getting it.
incEmployeeAge :: Company -> Company
incEmployeeAge c = over (#employee % #age) (+1) c
```

In general, optics offer a powerful way to view and modify data, far surpassing what mere getters and setters can do.[^fn3]

## Conclusion

Haskell offers a useful record syntax for manipulating data, but this syntax comes with some shortcomings. We have shown two different ways to overcome this: The `-XOverloadedRecordDot` extension and the `optics-core` library. Which should you use?

It depends.

`-XOverloadedRecordDot` is undoubtedly simpler and friendlier to people coming from other languages. If the primary problem you face is duplicate record fields and you don't need nested updates all that often, perhaps `-XOverloadedRecordDot` is the best choice (and nested updates are hopefully not too far away).

If, on the other hand, you want the most complete, sophisticated way of handling records today, take the plunge, and explore how deep the optics rabbit-hole goes.

---

[^fn1]: There is an extension `-XDuplicateRecordFields` that overcomes this limitation. This only allows the _definition_ -- not actual **usage** -- so it is not a complete solution.
[^fn2]: I wrote about this problem as a motivator for optics [here](https://tbidne.github.io/posts/optics/).
[^fn3]: Not only can optics handle fields via lenses, but we can also manipulate sum types via _prisms_. A full description is beyond the scope of this article, however.

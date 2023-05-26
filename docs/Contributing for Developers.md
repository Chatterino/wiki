# Contribution Guidelines

This is a set of guidelines for contributing to Chatterino. The goal is to teach programmers without C++ background (java/python/etc.), people who haven't used Qt or otherwise have different experience the idioms of the codebase. Thus, we will focus on those which are different from those other environments. There are extra guidelines available [here](https://hackmd.io/@fourtf/chatterino-pendantic-guidelines), but they are considered as extras and not as important.

## Tooling

### Formatting

Code is automatically formatted using [`clang-format`](https://clang.llvm.org/docs/ClangFormat.html). It takes the burden off of the programmer and ensures that all contributors use the same style (even if mess something up accidentally). We recommend that you set up automatic formatting on file save in your editor.

### Comments

Comments should only be used to:

-   Increase readability (e.g. grouping member variables).
-   Containing information that can't be expressed in code.

Try to structure your code so that comments are not required.

#### Good example

```cpp
/**
 * @return 0 if a == b, negative if a < b and positive if b > a. (1)
 */
int /* (2)! */ compare(const QString &a, const QString &b);
```

1. You can't know this from the function signature, so it's good to clarify this.
2. Even better: Return a "strong ordering" type (but we don't have such a type right now).

#### Bad example

```cpp
/*
 * Matches a link and returns boost::none if it failed and a
 * QRegularExpressionMatch on success. (1)
 *
 * @param text The text that will be checked if it contains a link. (2)
 */
boost::optional<QRegularExpressionMatch> matchLink(const QString &text);
```

1. This repeats the function signature.
2. This is obvious from the function and parameter names.

## Code

### Arithmetic Types

Arithmetic types (like `char`, `int`, `float` or `size_t`), `bool`, and pointers are NOT initialized by default in C++. They keep whatever value is already at their position in the memory. This makes debugging harder and is unpredictable, so we initialize them to zero by using `{}` after their name when declaring them.

```cpp
class ArithmeticTypes
{
    // DO
    int n{}; // (1)!
    bool isEnabled{}; // (2)!
    QWidget *myPtr{}; // (3)!
    int thisIs5 = 5; // (4)!
    std::vector<int> myVec; // (5)!

    // DON'T
    int m; // (6)!
    bool isHidden; // (7)!
    QWidget *yourPtr; // (8)!
    std::vector<int> myVec{}; // (9)!
};
```

1. Initialized to `0`.
2. Initialized to `false`.
3. Initialized to `nullptr`.
4. Explicitly initialized to `5`.
5. Other non-arithmetic types call constructors instead, so no need for `{}`.
6. ⚠ Random value.
7. ⚠ Random value.
8. ⚠ Random value. Derefenrencing this will likely segfault.
9. Unnecessary `{}` as the default constructor will be called even without `{}`.

### Passing parameters

The way a parameter is passed signals how it is going to be used inside of the function. C++ doesn't have multiple return values so there is "out parameters" (reference to a variable that is going to be assigned inside of the function) to simulate multiple return values.

**Cheap to copy types** like int/enum/etc. can be passed in per value since copying them is fast.

```cpp
void setValue(int value /* (1)! */) {
    this->value_ = value;
}

void sendGreeting(const /* (2)! */ User &user /* (3)! */, MessageFlags flags /* (4)! */) {
    this->sendMessage(user.id(), user.name(), flags);
}
```

1. `int`s are cheap to copy. Here, the parameter will likely be passed in a register.
2. We only need to read the user's name, so it's marked as `const`.
3. `User` is a class that contains the user's name and other fields, thus it's expensive to copy - so a reference i used.
4. `MessageFlags` is an enum, so it's cheap to copy.

**References** mean that the variable doesn't need to be copied when it is passed to a function.

| type               | meaning                                                                                  |
| ------------------ | ---------------------------------------------------------------------------------------- |
| `const Type& name` | _in_ Parameter. It is NOT going to be modified and may be copied inside of the function. |
| `Type& name`       | _out_ or _in+out_ Parameter. It will be modified.                                        |

**Pointers** signal that objects are managed manually. While the above are only guaranteed to live as long as the function call (= don't store and use later) these may have more complex lifetimes.

| type         | meaning                                                                                                                    |
| ------------ | -------------------------------------------------------------------------------------------------------------------------- |
| `Type* name` | The lifetime of the parameter may exceed the length of the function call. It may use the `QObject` parent/children system. |

**R-value references** `&&` work similar to regular references but signal the parameter should be "consumed".

```cpp
void storeLargeObject(LargeObject &&object) {
    // ...
}

void storeObject(std::unique_ptr<Object> &&object) {
    // ...
}

void main() {
    LargeObject large = { /*...*/ };

    storeLargeObject(std::move(large)); // (1)!

    std::unique_ptr<Object> unique = std::make_unique(/*...*/);
    storeObject(std::move(unique)); // (2)!

    assert(unique.get() == nullptr); // (3)!
}
```

1. `storeLargeObject` accepts an r-value reference and we use `std::move()`, thus we move the object and avoid the need to copy.
2. You can't copy a [`std::unique_ptr`][unique_ptr] so we **need** to move here.
3. The pointer contained by unique has now been consumed by `storeObject`, so it just holds a null pointer now.

Generally the lowest level of requirement should be used e.g. passing `Channel&` instead of `std::shared_ptr<Channel>&` (aka `ChannelPtr`) if possible.

### Members

All functions names are in `camelCase`. _Private_ member variables are in `camelCase_` (note the underscore at the end). We don't use the `get` prefix for getters. We mark functions as `const` [if applicable](https://stackoverflow.com/questions/751681/meaning-of-const-last-in-a-function-declaration-of-a-class).

```cpp
class NamedObject
{
public:
    const QString &name() const; // (1)!
    void setName(const QString &name);
    bool hasLongName() const; // (2)!

    static void myStaticFunction(); // (3)!
    QString publicName;

private:
    QString name_; // (4)!
    // QString name; (5)

    void myPrivateMethod(); // (6)!
};

void myFreeStandingFunction(); // (7)!
```

1. No `get` prefix.
2. A `has` or `is` prefix is okay.
3. Static member functions start lowercase as well.
4. Private members have a `_` suffix.
5. This declaration would collide with the `name()` accessor.
6. Private methods **don't** have a `_` suffix.
7. Free standing functions start lowercase as well.

### Casts

-   **Avoid** c-style casts: `(type)variable`.
-   Instead use explicit type casts: `type(variable)`
-   Or use one of [static_cast], [const_cast] and [dynamic_cast]
-   Try to avoid [reinterpret_cast] unless necessary.

```cpp
void example(float f, Base *b, const User &user, int p) {
    // DO
    int i = int(f); // (1)!
    Derived* derived = dynamic_cast<Derived*>(base); // (2)!
    if (derived != nullptr) // (3)!
    {
        // use derived
    }

    // BE CAREFUL
    const_cast<User &>(c).setName("foo"); // (4)!
    float *pp = reinterpret_cast<float*>(&p); // (5)!

    // DON'T (6)
    int i = (int)f;
    Derived* derived = (Derived*)base;
    ((int &)c) = 123;
    float *pp = (float*)&p;
}
```

1. Use explicit type casts.
2. Use explicit [dynamic_cast].
3. Unless extremely obvious, always check the result of [dynamic_cast].
4. Only use [const_cast] if using proper const correctness doesn't work.
5. [reinterpret_cast] is required very rarely.
6. **Avoid** C-style casts.

### This

Always use `this` to refer to instance members to make it clear where we use either locals or members.

```cpp
class Test
{
    void testFunc(int a);
    int testInt_{};
}

Test::testFunc(int a)
{
    // DO
    this->testInt_ += 2;
    this->testFunc();

    // DON'T
    testInt_ -= 123;
    testFunc(2);
    this->testFunc(testInt_/*(1)!*/ + 1);
}
```

1. It's unclear if it's a local or member variable, especially if the method is more complex.

### Managing resources

#### Regular classes

Keep the element on the stack if possible. If you need a pointer or have complex ownership you should use one of these classes:

-   Use [`std::unique_ptr`][unique_ptr] if the resource has a single owner.
-   Use [`std::shared_ptr`][shared_ptr] if the resource has multiple owners.

#### QObject classes

-   Use the [object tree](https://doc.qt.io/qt-6/objecttrees.html) to manage lifetime where possible. Objects are destroyed when their parent object is destroyed.
-   If you have to explicitly delete an object use `variable->deleteLater()` instead of `delete variable`. This ensures that it will be deleted on the correct thread.
-   If an object doesn't have a parent consider using `std::unique_ptr<Type, DeleteLater>` with `DeleteLater` from "common/Common.hpp". This will call `deleteLater()` on the pointer once it goes out of scope or the object is destroyed.

[static_cast]: https://en.cppreference.com/w/cpp/language/static_cast
[const_cast]: https://en.cppreference.com/w/cpp/language/const_cast
[dynamic_cast]: https://en.cppreference.com/w/cpp/language/dynamic_cast
[reinterpret_cast]: https://en.cppreference.com/w/cpp/language/reinterpret_cast
[unique_ptr]: https://en.cppreference.com/w/cpp/memory/unique_ptr
[shared_ptr]: https://en.cppreference.com/w/cpp/memory/shared_ptr

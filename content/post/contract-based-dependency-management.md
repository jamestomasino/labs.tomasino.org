---
date: 2021-10-05 23:32:36 +0000
title: "Contract-Based Dependency Management"
url: "/contract-based-dependency-management"
tags:
  - code
  - dependencies
  - productivity
---

## Semantic Versioning

There are many aspects to [dependency hell](https://en.wikipedia.org/wiki/Dependency_hell). Semantic
Versioning (SemVer) and other major/minor versioning patterns are an incomplete method for addressing some of these
common aspects. With knowledge of version compatibility it is possible to implement the side-by-side installation of
multiple versions of a package or library, or manage them on a per application basis. But the safety offered by SemVer
is a facade. It is a social trust contract filling the gap left by a missing technical one.

What happens when a change happens to a library that breaks compatibility? We hope the author(s) of the library will
update the major version to signify the change. But what if the change is non-obvious? What if it only breaks
compatibility for edge cases? What if the author simply doesn't feel it warrants a major version change?

This is not a theoretical possibility. It happens with some regularity across ecosystems. The codification of SemVer as
a pattern for major/minor versioning is an attempt to minimize these discrepancies by putting rules in place for what
changes constitute various version changes. These rules are not programmatic, but mental. They are rules for the author
to consider and follow and therefore as predictable and reliable as any given programmer might be, no more, no less.

I envision a different model that could exist in place of these human-named version numbers. I envision a system to
manage dependencies based upon the needs of code itself, leveraging essential programming tooling, and machine
enforceable. I call it Contract-Based Dependency Management.

## Contract-Based Dependency Management

To explain this model I will use the example of a make-believe computer program, language agnostic. This program
needs an external library to provide three key components. From the stand-point of dependency management our program
now depends on these three components of this external library. It expects them to work in a certain way. In fact, the
way they work should be provable via tests so that our program can trust them.

This is the contract. A program has a contract with the library via its tests which provide trust in the implementation
of a given feature. As long as those tests remain unchanged and passing, the library can be updated freely without
hesitation.

Rather than relying on human-based versioning the code relies on the tests of specific features it requires. These
contracts provide trust in the entire network of dependencies, even nested ones. If a library requires components of
another library to fulfill the contract, it in turn has contracts of its own. These are likewise managed via tests as
first-class citizens.

### So how would this work?

There is a much more complex overhead in managing the independent features of a library as dependencies than the entire
library; however, almost all of this process can be automated away through language tooling. These contract
relationships are defined in the code itself in import definitions, function signatures, or similar language constructs.
Mapping these relationships is a routine matter for a compiler and could be easily mapped into a language server
protocol interface for real-time accessibility.

With these tools in place, your dependency hierarchy is built in real time by your program. Optionally layering
additional metadata on top of this hierarchy could allow for enhanced features like audit trails, enhanced security
processes, and more.

Assume our program has just completed a first draft. A contract-based dependency hierarchy is generated. The program's
list of first level dependencies is now available as a series of tests. These tests can now be audited, checked for code
coverage, even fuzzed, and given a trust value by the auditor.

As the program moves forward in its life cycle dependencies may be updated. The dependency management system could be
configured to allow a range of behaviors of varying levels of safety. For instance, a program may want to automatically
update to use the latest version of a library where the contract tests are not failing. A higher security level may
pause the update if a test changes even if it is not failing, requiring a new audit of the updated test.

These security modes as metadata on top of a contract-based system could inform nested dependency choices in the same
way. Your system could act in a very strict mode requiring only audited test changes in dependencies all the way down.
Or we could offload some of this test auditing to automated tools and only require manual checks on 1st level
dependencies.

### What do we gain?

A contract-based approach removes the human guesswork from updates. It promotes tests to a fundamental part of the
dependency ecosystem. Test coverage is absolutely required for good libraries as they are the mechanism by which
contracts are formed. The system creates space for safety audits, enforceable security patterns, and greater dependency
tree introspection.


<!--  vim: set shiftwidth=4 tabstop=4 expandtab: -->

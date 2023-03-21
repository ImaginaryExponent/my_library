
# Advanced CMake will (not) be needed.

![Tree of targets](./imgs/tree.png)

Please, note, these are not vital for this specific manual, but that is one of the correct ways of writing CMake and I would rather keep reminding myself what the good code looks like.

## Generator expressions.

Statements like `$<Something_here>` are "generator expressions" in CMake. Those are interesting beasts in and of themselves and they can achieve a lot, but for now you can consider them conditional replacements: `$<some_condition:some_string>`. When `some_condition` is evaluated by the interpreter to `true` the interpreter behaves like there is `some_string` in that place in the script. In all other cases it is as if the whole `$<>` never existed.

```CMake
target_compile_options(my_library INTERFACE $<$<CXX_COMPILER_ID:MSVC>:/Za>)
```
Here it is a shorthand for "IF the current compiler is a Microsoft Compiler THEN provide an extra `/Za` compilation option to the target, OTHERWISE provide nothing."

## Installation process. 

Another deep dive is installation. As in, how do you want your software to be installed, where, what the final file system layout should be and so on. CMake can help with that. It is quite capable of copying the library headers to a dedicated folder in the system, placing the binaries where they should reside and so on. Just like the build process installation is also target-based and deserves a manual to itself and is completely unnecessary for this tutorial. 

Here I will just mention that when CMake generates the **build** commands it operates on the **internal** view of the targets. So, the side that your own codebase should see. And the users, likely, should require no idea about. This concerns include directories among other things. While **build**ing, the directories involved should be mostly local to your **build** folder of the codebase. Here seeing `/d:/sources/c++/tutorials/my_library/include` or some such is normal.

On the other hand when CMake generates the **install** scripts it requires **external** view of its targets. So things like include directories associated with your targets should point to where the **install**ed headers are. `/c:/Program Files/my_library/include` or similar should be seen here.

```CMake
target_include_directories(my_library INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include> $<INSTALL_INTERFACE:include>)
```
In order to provide two different values for two different prcesses here two generator expressions are used. They expand to "IF we are building the codebase THEN add the local `./my_library/include` to the rest of the include directories associated with this target. OTHERWISE add nothing." And "IF we are installing things THEN add the global `wherever_we_are_installing/include` to the include directories associated with this target, OTHERWISE do nothing".

```CMake
target_include_directories(my_library INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)

target_include_directories(my_library INTERFACE $<INSTALL_INTERFACE:$include>)
```

This script would achieve exactly the same. It is my personal preference to use the former rather than latter.
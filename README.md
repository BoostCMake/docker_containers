# Boost CMake Build Tools

## Building.
```
cd <path>
docker build -t base base/
docker build -t clang-6.0 clang-6.0/
```

## Examples.
```
docker run -v <path_to_boost>:/home/builder/boost -v <path_to_boost_cmake>:/home/builder/project -v <path_to_build_directory>:/home/builder/bin clang-6.0 -C -M tests
```
## Command Line Arguments.

```-C``` - Simply runs CMake
```-M <target>``` - Runs ```make``` with target
```-D``` - Clears caches
```-T``` - Runs ```ctest``` with target

#!/bin/bash

# Execute system setup hook
/systemsetup.sh

# If we are running docker natively, we want to create a user in the container
# with the same UID and GID as the user on the host machine, so that any files
# created are owned by that user. Without this they are all owned by root.
if [[ -n $BUILDER_UID ]] && [[ -n $BUILDER_GID ]]; then
    groupadd -o -g $BUILDER_GID $BUILDER_GROUP 2> /dev/null
    useradd -o -m -g $BUILDER_GID -u $BUILDER_UID $BUILDER_USER 2> /dev/null
    shopt -s dotglob

    # Make sure the home directory is owned by the specified user/group.
    chown -R $BUILDER_UID:$BUILDER_GID $HOME

    # Make sure build artifacts are accessible by the specified user/group.
    chown -R $BUILDER_UID:$BUILDER_GID /binary

    # Execute user setup hook
    chpst -u :$BUILDER_UID:$BUILDER_GID /usersetup.sh
    # Run the command as the specified user/group.
    #exec chpst -u :$BUILDER_UID:$BUILDER_GID ctest -S entrypoint.cmake "$@"
else
    # Execute user setup hook
    clear_cache=false
    run_make=false
    run_cmake=false
    run_ctest=false
    path_boost=/home/builder/boost
    path_bin=/home/builder/bin
    path_sources=/home/builder/project
    while [ -n "$1" ]
    do
    case "$1" in
    -C) run_cmake=true ;;
    -M) run_make=true \
        target_make=$2
        shift ;;
    -P) path=$2
        shift ;;
    -T) run_ctest=true \
        target_ctest=$2
        shift ;;
    -D) clear_cache=true ;;
    --help) \
            echo "-C for run cmake"
            echo "-M for run make"
            echo "-T for run ctest"
            echo "-P for chane path. Default: $path"
            echo "-D for clear cache" ;;
    *) echo "$1 is not an option, please use --help" ;;
    esac
    shift
    done
    mkdir $path_boost
    mkdir $path_bin
    mkdir $path_sources
    cd $path_bin
    if [ "$clear_cache" = true ]; then
        rm -rf $path_bin
        mkdir $path_bin
    fi
    if [ "$run_cmake" = true ]; then
        echo "Run cmake"
        cmake $path_sources -DBUILD_WITH_SOURCES_DIR=$path_boost
    fi
    if [ "$run_make" = true ]; then
        echo "Make $target_make"
        make -j $(nproc) $target_make
    fi
    if [ "$run_ctest" = true ]; then
        echo "Run ctest for $target_ctest"
        ctest -j $(nproc) $target_ctest
    fi
    # Just run the command as root.
    #exec ctest -S entrypoint.cmake "$@"
fi

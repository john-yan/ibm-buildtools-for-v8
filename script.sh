#!/bin/bash

# cleanup
rm -rf /workdir && mkdir /workdir

# fetch and prepare src
cd /workdir && \
    fetch --no-history --nohooks chromium && \
    patch -p1 -d /workdir/src -i /srcdir/src.diff && \
    touch /workdir/src/build/util/LASTCHANGE

generate_and_build() {
  OUT=$1
  cd /workdir/src  && \
      $GN gen $OUT --args='enable_nacl=false use_allocator="none" is_component_build=false is_debug=false' && \
      ninja -C $OUT gn gn_unittests
}

# generate and build gn
GN=/buildtools/gn generate_and_build out

# test: build itself
GN=/workdir/src/out/gn generate_and_build out_test && cp /workdir/src/out/gn /buildtools/gn

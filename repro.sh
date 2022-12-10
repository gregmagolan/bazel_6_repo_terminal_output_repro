#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

if [ "$(uname)" == "Darwin" ]; then
  platform="darwin"
else
  platform="linux"
fi

if [ ! -f bazel5 ]; then
  wget https://github.com/bazelbuild/bazel/releases/download/5.3.2/bazel-5.3.2-${platform}-x86_64 -O bazel5
  chmod +x bazel5
fi

if [ ! -f bazel6 ]; then
  wget https://releases.bazel.build/6.0.0/rc4/bazel-6.0.0rc4-${platform}-x86_64 -O bazel6
  chmod +x bazel6
fi

./bazel5 clean --expunge
echo "Running bazel build //:foo with $(./bazel5 --version)"
echo "You should see the status output of the @not_fast repo rule: Fetching @not_fast; Doing nothing for 10 seconds..."
./bazel5 build //:foo

./bazel6 clean --expunge
echo "Running bazel build //:foo with $(./bazel6 --version)"
echo "The status output of the @not_fast repo rule is not shown and bazel appears to hang for 10 seconds"
./bazel6 build //:foo

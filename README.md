# Repro of Bazel 6 issue https://github.com/bazelbuild/bazel/issues/16978

## Conditions for issue

- Bazel 6.0.0rc1, rc2, rc3 & rc3 (did not test with pre-releases 6.0.0)
## Issue

The status of repository rules that are eagerly loaded in the WORKSPACE file are not seen
when running `bazel build`

## Run repro

Run `./repro.sh`. This will run `bazel build //:foo` with bazel 5 & then with bazel 6.

With bazel 5 you'll see the status output of the `@not_fast` repository rule:

```
Fetching @not_fast; Doing nothing for 10 seconds...
```

With bazel 6 the status output of the `@not_fast` repository rule will not be shown
so it will appear that Bazel is hung for 10 seconds while the repo rule executes.

def _my_repo_rule_impl(rctx):
    rctx.report_progress("Doing nothing for 10 seconds...")
    rctx.execute(["sleep", "10"])
    rctx.file("BUILD.bazel", content = "")
    rctx.file("generated.bzl", """
def _my_other_repo_rule_impl():
    pass
my_other_repo_rule = repository_rule(
    implementation = _my_other_repo_rule_impl,
)
def generated():
    my_other_repo_rule(name = "other")
""")

my_repo_rule = repository_rule(
    implementation = _my_repo_rule_impl,
)

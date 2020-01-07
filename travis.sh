#!/bin/bash

set -euxo pipefail
dub build --compiler=${DC} --vverbose
# && dub test --build=unittest-cov --compiler=${DC}

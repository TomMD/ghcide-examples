#!/usr/bin/env bash

execute_test() {
    LOG=$(mktemp)
    printf "Log: %s\n" "${LOG}"
    rm -rf dist-newstyle
    ghcide 1> "${LOG}" 2>&1
    for i in x y z w ; do
        nrCfg=$(grep -c "Configuring library for $i" ${LOG})
        nrBld=$(grep -c "Building library for $i" ${LOG})
        printf "$i was configured %2d times and built %2d times.\n" $nrCfg $nrBld
    done
}

reset_files() {
    cat <<EOF >hie.yaml
cradle:
    multi:
EOF
    printf "packages:\n" >cabal.project
}

build_files() {
    projects=($@)
    reset_files
    for i in ${projects[@]} ; do
        printf "        - path: \"./$i\"\n" >> hie.yaml
        printf "          config: {cradle: {cabal: {component: \"lib:$i\"}}}\n" >> hie.yaml
        printf "    $i \n" >> cabal.project
    done
}

run_test() {
    projects=($@)
    echo "Executing test on projects: ${projects[@]}"
    build_files ${projects[@]}
    execute_test
}

args=(w z y x)
run_test ${args[@]}
args=(x y z w)
run_test ${args[@]}
args=(x y z)
run_test ${args[@]}
args=(x y)
run_test ${args[@]}
args=(x)
run_test ${args[@]}

#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly CT_VERSION=latest
readonly KIND_VERSION=v0.7.0
readonly CLUSTER_NAME=chart-testing
readonly K8S_VERSION=v1.17.0

run_ct_container() {
    echo 'Running ct container...'
    docker run --rm --interactive --detach --network host --name ct \
        --volume "$(pwd)/test/ct.yaml:/etc/ct/ct.yaml" \
        --volume "$(pwd):/workdir" \
        --workdir /workdir \
        "quay.io/helmpack/chart-testing:$CT_VERSION" \
        cat
    echo
}

cleanup() {
    echo 'Removing ct container...'
    docker kill ct > /dev/null 2>&1
    ./build/kind delete cluster --name "$CLUSTER_NAME"
    echo 'Done!'
}

docker_exec() {
    docker exec --interactive ct "$@"
}

create_kind_cluster() {
    echo 'Installing kind...'

    mkdir -p build
    wget -nc -O build/kind "https://github.com/kubernetes-sigs/kind/releases/download/$KIND_VERSION/kind-$(uname)-amd64" || true
    chmod +x ./build/kind

    ./build/kind create cluster --name "$CLUSTER_NAME" --config test/kind-config.yaml --image "kindest/node:$K8S_VERSION" --wait 60s --kubeconfig ./build/kubecfg.yaml

    echo 'Copying kubeconfig to container...'
    docker exec ct mkdir -p /root/.kube
    docker cp ./build/kubecfg.yaml ct:/root/.kube/config

    docker_exec kubectl cluster-info
    echo

    docker_exec kubectl get nodes
    echo

    echo 'Cluster ready!'
    echo
}

install_charts() {
    docker_exec ct install
    echo
}

main() {
    run_ct_container
    trap cleanup EXIT

    create_kind_cluster
    install_charts
}

main

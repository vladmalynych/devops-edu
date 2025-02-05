
#kubectl get deployment,statefulset,daemonset -A -o json | from json | flatten | get items | select -i kind metadata.namespace metadata.name spec.replicas spec.template.spec.containers.name spec.template.spec.containers.resources

let objects = kubectl get deployments,statefulsets,daemonsets -A -o json | from json | flatten | get items | select -i kind metadata.namespace metadata.name spec.replicas spec.template.spec.containers.name spec.template.spec.containers.resources
let rs = kubectl get replicasets -A -o json | from json | flatten | get items | select kind metadata.namespace metadata.name metadata.ownerReferences.0.kind metadata.ownerReferences.0.name
let pods = kubectl get pods -A -o json | from json

$rs
$objects

let test = $objects | join $rs metadata.name metadata.ownerReferences.0.name

$test
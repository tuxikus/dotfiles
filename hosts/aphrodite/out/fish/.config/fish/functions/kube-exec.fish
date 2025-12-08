
### MANAGED BY mw-dev-env START (DO NOT EDIT)
function kube-exec -a pod cmd
  if [ -z "$pod" ];
    echo "Usage: kube-exec <pod> [cmd] [args..]"
    echo "Default cmd is bash"
    return 1
  end

  if [ -z "$cmd" ];
    set cmd "bash"
  end

  set matching_pods $(kubectl get pods -A -o json --field-selector=status.phase=Running | jq -r --arg pod "$pod" '.items[] | select(.metadata.name | contains($pod)) | .metadata | {name, namespace}')
  set count (echo "$matching_pods" | jq -s length)

  if [ "$count" -gt 1 ];
    echo "Multiple pods matched:"
    echo "$matching_pods" | jq -r -s ".[] | .name"
    return 1
  elif [ "$count" -eq 0 ];
    echo "No pod matched"
    return 1
  end

  set namespace (echo "$matching_pods" | jq -r ".namespace")
  set name (echo "$matching_pods" | jq -r ".name")

  kubectl exec -it -n $namespace $name -- $cmd $argv[3..]
end
### MANAGED BY mw-dev-env END (DO NOT EDIT)


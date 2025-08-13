# Prometheus Alert Rules Configuration
# This file contains reusable alert rules for AKS monitoring

# Node Level Alert Rules
prometheus_node_alert_rules = [
  {
    alert      = "KubeNodeUnreachable"
    enabled    = true
    expression = <<EOF
(kube_node_spec_taint{job="kube-state-metrics",key="node.kubernetes.io/unreachable",effect="NoSchedule"} unless ignoring(key,value) kube_node_spec_taint{job="kube-state-metrics",key=~"ToBeDeletedByClusterAutoscaler|cloud.google.com/imminent-node-termination|aws-node-termination-handler/spot-itn"} == 1)
EOF
    for        = "PT15M"
    severity   = 3
    alert_resolution = {
      auto_resolved   = true
      time_to_resolve = "PT10M"
    }
    annotations = {
      description = "{{ $labels.node }} in {{ $labels.cluster }} is unreachable."
    }
    labels = {
      team       = "prod"
      alert_name = "KubeNodeUnreachable"
    }
  },
  {
    alert      = "KubeNodeReadinessFlapping"
    enabled    = true
    expression = "sum(changes(kube_node_status_condition{status=\"true\",condition=\"Ready\"}[15m])) by (cluster, node) > 2"
    for        = "PT15M"
    severity   = 3
    alert_resolution = {
      auto_resolved   = true
      time_to_resolve = "PT10M"
    }
    annotations = {
      description = "Node readiness is flapping."
    }
    labels = {
      team       = "prod"
      alert_name = "KubeNodeReadinessFlapping"
    }
  }
]

# Cluster Level Alert Rules
prometheus_cluster_alert_rules = [
  {
    alert = "KubeCPUQuotaOvercommit"
    annotations = {
      description = "Cluster {{ $labels.cluster }} has overcommitted CPU resource requests for Namespaces."
    }
    enabled    = true
    expression = "sum(min without(resource) (kube_resourcequota{job=\"kube-state-metrics\", type=\"hard\", resource=~\"(cpu|requests.cpu)\"})) / sum(kube_node_status_allocatable{resource=\"cpu\", job=\"kube-state-metrics\"}) > 1.5"
    for        = "PT5M"
    labels = {
      severity = "warning"
    }
    alert_resolution = {
      auto_resolved   = true
      time_to_resolve = "PT10M"
    }
    severity = 3
  },
  {
    alert = "KubeMemoryQuotaOvercommit"
    annotations = {
      description = "Cluster {{ $labels.cluster }} has overcommitted memory resource requests for Namespaces."
    }
    enabled    = true
    expression = "sum(min without(resource) (kube_resourcequota{job=\"kube-state-metrics\", type=\"hard\", resource=~\"(memory|requests.memory)\"})) / sum(kube_node_status_allocatable{resource=\"memory\", job=\"kube-state-metrics\"}) > 1.5"
    for        = "PT5M"
    labels     = {}
    alert_resolution = {
      auto_resolved   = true
      time_to_resolve = "PT10M"
    }
    severity = 3
  },
  {
    alert = "KubeContainerOOMKilledCount"
    annotations = {
      description = "Number of OOM killed containers is greater than 0."
    }
    enabled    = true
    expression = "sum by (cluster,container,controller,namespace) (kube_pod_container_status_last_terminated_reason{reason=\"OOMKilled\"} * on(cluster,namespace,pod) group_left(controller) label_replace(kube_pod_owner, \"controller\", \"$1\", \"owner_name\", \".*\")) > 0"
    for        = "PT5M"
    labels     = {}
    alert_resolution = {
      auto_resolved   = true
      time_to_resolve = "PT10M"
    }
    severity = 4
  },
  {
    alert = "KubeClientErrors"
    annotations = {
      description = "Kubernetes API server client '{{ $labels.job }}/{{ $labels.instance }}' is experiencing {{ $value | humanizePercentage }} errors."
    }
    enabled    = true
    expression = "(sum(rate(rest_client_requests_total{code=~\"5..\"}[5m])) by (cluster, instance, job, namespace) / sum(rate(rest_client_requests_total[5m])) by (cluster, instance, job, namespace)) > 0.01"
    for        = "PT15M"
    labels     = {}
    alert_resolution = {
      auto_resolved   = true
      time_to_resolve = "PT10M"
    }
    severity = 3
  }
]

# Pod Level Alert Rules
prometheus_pod_alert_rules = [
  {
    alert      = "KubePVUsageHigh"
    enabled    = true
    expression = <<EOF
avg by (namespace, controller, container, cluster) (
  (kubelet_volume_stats_used_bytes{job="kubelet"} / on(namespace, cluster, pod, container) group_left
  kubelet_volume_stats_capacity_bytes{job="kubelet"}) * on(namespace, pod, cluster) group_left(controller)
  label_replace(kube_pod_owner, "controller", "$1", "owner_name", "(.*)")
) > 0.8
EOF
    for        = "PT15M"
    severity   = 3
    alert_resolution = {
      auto_resolved   = true
      time_to_resolve = "PT10M"
    }
    annotations = {
      description = "Average PV usage on pod {{ $labels.pod }} in container {{ $labels.container }} is greater than 80%."
    }
    labels = {
      alert_name = "KubePVUsageHigh"
    }
  },
  {
    alert      = "KubePodCrashLooping"
    enabled    = true
    expression = <<EOF
max_over_time(kube_pod_container_status_waiting_reason{reason="CrashLoopBackOff", job="kube-state-metrics"}[5m]) >= 1
EOF
    for        = "PT15M"
    severity   = 4
    alert_resolution = {
      auto_resolved   = true
      time_to_resolve = "PT10M"
    }
    annotations = {
      description = "{{ $labels.namespace }}/{{ $labels.pod }} ({{ $labels.container }}) in {{ $labels.cluster}} is restarting {{ printf \"%.2f\" $value }} / second."
    }
    labels = {
      alert_name = "KubePodCrashLooping"
    }
  },
  {
    alert      = "KubeDeploymentReplicasMismatch"
    enabled    = true
    expression = <<EOF
(
  kube_deployment_spec_replicas{job="kube-state-metrics"} > kube_deployment_status_replicas_available{job="kube-state-metrics"}
  and (changes(kube_deployment_status_replicas_updated{job="kube-state-metrics"}[10m]) == 0)
)
EOF
    for        = "PT15M"
    severity   = 4
    alert_resolution = {
      auto_resolved   = true
      time_to_resolve = "PT15M"
    }
    annotations = {
      description = "Deployment {{ $labels.namespace }}/{{ $labels.deployment }} in {{ $labels.cluster}} replica mismatch."
    }
    labels = {
      alert_name = "KubeDeploymentReplicasMismatch"
    }
  },
  {
    alert      = "KubePodReadyStateLow"
    enabled    = true
    expression = <<EOF
sum by (cluster,namespace,deployment)
(kube_deployment_status_replicas_ready) / sum by
(cluster,namespace,deployment)(kube_deployment_spec_replicas) < .8 or sum
by (cluster,namespace,deployment)(kube_daemonset_status_number_ready) /
sum by (cluster,namespace,deployment)(kube_daemonset_status_desired_number_scheduled) < .8
EOF
    for        = "PT5M"
    severity   = 4
    alert_resolution = {
      auto_resolved   = true
      time_to_resolve = "PT15M"
    }
    annotations = {
      description = "Ready state of pods is less than 80%."
    }
    labels = {
      alert_name = "KubePodReadyStateLow"
    }
  }
]

# Node Recording Rules
prometheus_node_recording_rules = [
  {
    enabled    = true
    record     = "instance:node_num_cpu:sum"
    expression = <<EOF
count without (cpu, mode) (  node_cpu_seconds_total{job="node",mode="idle"})
EOF
  },
  {
    enabled    = true
    record     = "instance:node_cpu_utilisation:rate5m"
    expression = <<EOF
1 - avg without (cpu) (  sum without (mode) (rate(node_cpu_seconds_total{job="node", mode=~"idle|iowait|steal"}[5m])))
EOF
  },
  {
    enabled    = true
    record     = "instance:node_load1_per_cpu:ratio"
    expression = <<EOF
(  node_load1{job="node"}/  instance:node_num_cpu:sum{job="node"})
EOF
  },
  {
    enabled    = true
    record     = "instance:node_memory_utilisation:ratio"
    expression = <<EOF
1 - (  (    node_memory_MemAvailable_bytes{job="node"}    or    (      node_memory_Buffers_bytes{job="node"}      +      node_memory_Cached_bytes{job="node"}      +      node_memory_MemFree_bytes{job="node"}      +      node_memory_Slab_bytes{job="node"}    )  )/  node_memory_MemTotal_bytes{job="node"})
EOF
  },
  {
    enabled    = true
    record     = "instance:node_vmstat_pgmajfault:rate5m"
    expression = <<EOF
rate(node_vmstat_pgmajfault{job="node"}[5m])
EOF
  },
  {
    enabled    = true
    record     = "instance_device:node_disk_io_time_seconds:rate5m"
    expression = <<EOF
rate(node_disk_io_time_seconds_total{job="node", device!=""}[5m])
EOF
  },
  {
    enabled    = true
    record     = "instance_device:node_disk_io_time_weighted_seconds:rate5m"
    expression = <<EOF
rate(node_disk_io_time_weighted_seconds_total{job="node", device!=""}[5m])
EOF
  },
  {
    enabled    = true
    record     = "instance:node_network_receive_bytes_excluding_lo:rate5m"
    expression = <<EOF
sum without (device) (  rate(node_network_receive_bytes_total{job="node", device!="lo"}[5m]))
EOF
  },
  {
    enabled    = true
    record     = "instance:node_network_transmit_bytes_excluding_lo:rate5m"
    expression = <<EOF
sum without (device) (  rate(node_network_transmit_bytes_total{job="node", device!="lo"}[5m]))
EOF
  },
  {
    enabled    = true
    record     = "instance:node_network_receive_drop_excluding_lo:rate5m"
    expression = <<EOF
sum without (device) (  rate(node_network_receive_drop_total{job="node", device!="lo"}[5m]))
EOF
  },
  {
    enabled    = true
    record     = "instance:node_network_transmit_drop_excluding_lo:rate5m"
    expression = <<EOF
sum without (device) (  rate(node_network_transmit_drop_total{job="node", device!="lo"}[5m]))
EOF
  }
]

# Kubernetes Recording Rules
prometheus_kubernetes_recording_rules = [
  {
    enabled    = true
    record     = "node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate"
    expression = <<EOF
sum by (cluster, namespace, pod, container) (  irate(container_cpu_usage_seconds_total{job="cadvisor", image!=""}[5m])) * on (cluster, namespace, pod) group_left(node) topk by (cluster, namespace, pod) (  1, max by(cluster, namespace, pod, node) (kube_pod_info{node!=""}))
EOF
  },
  {
    enabled    = true
    record     = "node_namespace_pod_container:container_memory_working_set_bytes"
    expression = <<EOF
container_memory_working_set_bytes{job="cadvisor", image!=""}* on (namespace, pod) group_left(node) topk by(namespace, pod) (1,  max by(namespace, pod, node) (kube_pod_info{node!=""}))
EOF
  },
  {
    enabled    = true
    record     = "node_namespace_pod_container:container_memory_rss"
    expression = <<EOF
container_memory_rss{job="cadvisor", image!=""}* on (namespace, pod) group_left(node) topk by(namespace, pod) (1,  max by(namespace, pod, node) (kube_pod_info{node!=""}))
EOF
  },
  {
    enabled    = true
    record     = "node_namespace_pod_container:container_memory_cache"
    expression = <<EOF
container_memory_cache{job="cadvisor", image!=""}* on (namespace, pod) group_left(node) topk by(namespace, pod) (1,  max by(namespace, pod, node) (kube_pod_info{node!=""}))
EOF
  },
  {
    enabled    = true
    record     = "node_namespace_pod_container:container_memory_swap"
    expression = <<EOF
container_memory_swap{job="cadvisor", image!=""}* on (namespace, pod) group_left(node) topk by(namespace, pod) (1,  max by(namespace, pod, node) (kube_pod_info{node!=""}))
EOF
  },
  {
    enabled    = true
    record     = "cluster:namespace:pod_memory:active:kube_pod_container_resource_requests"
    expression = <<EOF
kube_pod_container_resource_requests{resource="memory",job="kube-state-metrics"}  * on (namespace, pod, cluster)group_left() max by (namespace, pod, cluster) (  (kube_pod_status_phase{phase=~"Pending|Running"} == 1))
EOF
  },
  {
    enabled    = true
    record     = "namespace_memory:kube_pod_container_resource_requests:sum"
    expression = <<EOF
sum by (namespace, cluster) (    sum by (namespace, pod, cluster) (        max by (namespace, pod, container, cluster) (          kube_pod_container_resource_requests{resource="memory",job="kube-state-metrics"}        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (          kube_pod_status_phase{phase=~"Pending|Running"} == 1        )    ))
EOF
  },
  {
    enabled    = true
    record     = "cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests"
    expression = <<EOF
kube_pod_container_resource_requests{resource="cpu",job="kube-state-metrics"}  * on (namespace, pod, cluster)group_left() max by (namespace, pod, cluster) (  (kube_pod_status_phase{phase=~"Pending|Running"} == 1))
EOF
  },
  {
    enabled    = true
    record     = "namespace_cpu:kube_pod_container_resource_requests:sum"
    expression = <<EOF
sum by (namespace, cluster) (    sum by (namespace, pod, cluster) (        max by (namespace, pod, container, cluster) (          kube_pod_container_resource_requests{resource="cpu",job="kube-state-metrics"}        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (          kube_pod_status_phase{phase=~"Pending|Running"} == 1        )    ))
EOF
  },
  {
    enabled    = true
    record     = "cluster:namespace:pod_memory:active:kube_pod_container_resource_limits"
    expression = <<EOF
kube_pod_container_resource_limits{resource="memory",job="kube-state-metrics"}  * on (namespace, pod, cluster)group_left() max by (namespace, pod, cluster) (  (kube_pod_status_phase{phase=~"Pending|Running"} == 1))
EOF
  },
  {
    enabled    = true
    record     = "namespace_memory:kube_pod_container_resource_limits:sum"
    expression = <<EOF
sum by (namespace, cluster) (    sum by (namespace, pod, cluster) (        max by (namespace, pod, container, cluster) (          kube_pod_container_resource_limits{resource="memory",job="kube-state-metrics"}        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (          kube_pod_status_phase{phase=~"Pending|Running"} == 1        )    ))
EOF
  },
  {
    enabled    = true
    record     = "cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits"
    expression = <<EOF
kube_pod_container_resource_limits{resource="cpu",job="kube-state-metrics"}  * on (namespace, pod, cluster) group_left() max by (namespace, pod, cluster) ( (kube_pod_status_phase{phase=~"Pending|Running"} == 1) )
EOF
  },
  {
    enabled    = true
    record     = "namespace_cpu:kube_pod_container_resource_limits:sum"
    expression = <<EOF
sum by (namespace, cluster) (    sum by (namespace, pod, cluster) (        max by (namespace, pod, container, cluster) (          kube_pod_container_resource_limits{resource="cpu",job="kube-state-metrics"}        ) * on(namespace, pod, cluster) group_left() max by (namespace, pod, cluster) (          kube_pod_status_phase{phase=~"Pending|Running"} == 1        )    ))
EOF
  },
  {
    enabled    = true
    record     = "namespace_workload_pod:kube_pod_owner:relabel"
    expression = <<EOF
max by (cluster, namespace, workload, pod) (  label_replace(    label_replace(      kube_pod_owner{job="kube-state-metrics", owner_kind="ReplicaSet"},      "replicaset", "$1", "owner_name", "(.*)"    ) * on(replicaset, namespace) group_left(owner_name) topk by(replicaset, namespace) (      1, max by (replicaset, namespace, owner_name) (        kube_replicaset_owner{job="kube-state-metrics"}      )    ),    "workload", "$1", "owner_name", "(.*)"  ))
EOF
    labels = {
      workload_type = "deployment"
    }
  },
  {
    enabled    = true
    record     = "namespace_workload_pod:kube_pod_owner:relabel"
    expression = <<EOF
max by (cluster, namespace, workload, pod) (  label_replace(    kube_pod_owner{job="kube-state-metrics", owner_kind="DaemonSet"},    "workload", "$1", "owner_name", "(.*)"  ))
EOF
    labels = {
      workload_type = "daemonset"
    }
  },
  {
    enabled    = true
    record     = "namespace_workload_pod:kube_pod_owner:relabel"
    expression = <<EOF
max by (cluster, namespace, workload, pod) (  label_replace(    kube_pod_owner{job="kube-state-metrics", owner_kind="StatefulSet"},    "workload", "$1", "owner_name", "(.*)"  ))
EOF
    labels = {
      workload_type = "statefulset"
    }
  },
  {
    enabled    = true
    record     = "namespace_workload_pod:kube_pod_owner:relabel"
    expression = <<EOF
max by (cluster, namespace, workload, pod) (  label_replace(    kube_pod_owner{job="kube-state-metrics", owner_kind="Job"},    "workload", "$1", "owner_name", "(.*)"  ))
EOF
    labels = {
      workload_type = "job"
    }
  },
  {
    enabled    = true
    record     = ":node_memory_MemAvailable_bytes:sum"
    expression = <<EOF
sum(  node_memory_MemAvailable_bytes{job="node"} or  (    node_memory_Buffers_bytes{job="node"} +    node_memory_Cached_bytes{job="node"} +    node_memory_MemFree_bytes{job="node"} +    node_memory_Slab_bytes{job="node"}  )) by (cluster)
EOF
  },
  {
    enabled    = true
    record     = "cluster:node_cpu:ratio_rate5m"
    expression = <<EOF
sum(rate(node_cpu_seconds_total{job="node",mode!="idle",mode!="iowait",mode!="steal"}[5m])) by (cluster) /count(sum(node_cpu_seconds_total{job="node"}) by (cluster, instance, cpu)) by (cluster)
EOF
  }
]

# UX Recording Rules
prometheus_ux_recording_rules = [
  {
    enabled    = true
    record     = "ux:pod_cpu_usage:sum_irate"
    expression = <<EOF
(sum by (namespace, pod, cluster, microsoft_resourceid) (
    irate(container_cpu_usage_seconds_total{container != "", pod != "", job = "cadvisor"}[5m])
)) * on (pod, namespace, cluster, microsoft_resourceid) group_left (node, created_by_name, created_by_kind)
(max by (node, created_by_name, created_by_kind, pod, namespace, cluster, microsoft_resourceid) (kube_pod_info{pod != "", job = "kube-state-metrics"}))
EOF
  },
  {
    enabled    = true
    record     = "ux:controller_cpu_usage:sum_irate"
    expression = <<EOF
sum by (namespace, node, cluster, created_by_name, created_by_kind, microsoft_resourceid) (
ux:pod_cpu_usage:sum_irate
)
EOF
  },
  {
    enabled    = true
    record     = "ux:pod_workingset_memory:sum"
    expression = <<EOF
(
        sum by (namespace, pod, cluster, microsoft_resourceid) (
        container_memory_working_set_bytes{container != "", pod != "", job = "cadvisor"}
        )
    ) * on (pod, namespace, cluster, microsoft_resourceid) group_left (node, created_by_name, created_by_kind)
(max by (node, created_by_name, created_by_kind, pod, namespace, cluster, microsoft_resourceid) (kube_pod_info{pod != "", job = "kube-state-metrics"}))
EOF
  },
  {
    enabled    = true
    record     = "ux:controller_workingset_memory:sum"
    expression = <<EOF
sum by (namespace, node, cluster, created_by_name, created_by_kind, microsoft_resourceid) (
ux:pod_workingset_memory:sum
)
EOF
  },
  {
    enabled    = true
    record     = "ux:pod_rss_memory:sum"
    expression = <<EOF
(
        sum by (namespace, pod, cluster, microsoft_resourceid) (
        container_memory_rss{container != "", pod != "", job = "cadvisor"}
        )
    ) * on (pod, namespace, cluster, microsoft_resourceid) group_left (node, created_by_name, created_by_kind)
(max by (node, created_by_name, created_by_kind, pod, namespace, cluster, microsoft_resourceid) (kube_pod_info{pod != "", job = "kube-state-metrics"}))
EOF
  },
  {
    enabled    = true
    record     = "ux:controller_rss_memory:sum"
    expression = <<EOF
sum by (namespace, node, cluster, created_by_name, created_by_kind, microsoft_resourceid) (
ux:pod_rss_memory:sum
)
EOF
  },
  {
    enabled    = true
    record     = "ux:pod_container_count:sum"
    expression = <<EOF
sum by (node, created_by_name, created_by_kind, namespace, cluster, pod, microsoft_resourceid) (
((
sum by (container, pod, namespace, cluster, microsoft_resourceid) (kube_pod_container_info{container != "", pod != "", container_id != "", job = "kube-state-metrics"})
or sum by (container, pod, namespace, cluster, microsoft_resourceid) (kube_pod_init_container_info{container != "", pod != "", container_id != "", job = "kube-state-metrics"})
)
* on (pod, namespace, cluster, microsoft_resourceid) group_left (node, created_by_name, created_by_kind)
(
max by (node, created_by_name, created_by_kind, pod, namespace, cluster, microsoft_resourceid) (
    kube_pod_info{pod != "", job = "kube-state-metrics"}
)
)
)

)
EOF
  },
  {
    enabled    = true
    record     = "ux:controller_container_count:sum"
    expression = <<EOF
sum by (node, created_by_name, created_by_kind, namespace, cluster, microsoft_resourceid) (
ux:pod_container_count:sum
)
EOF
  },
  {
    enabled    = true
    record     = "ux:pod_container_restarts:max"
    expression = <<EOF
max by (node, created_by_name, created_by_kind, namespace, cluster, pod, microsoft_resourceid) (
((
max by (container, pod, namespace, cluster, microsoft_resourceid) (kube_pod_container_status_restarts_total{container != "", pod != "", job = "kube-state-metrics"})
or sum by (container, pod, namespace, cluster, microsoft_resourceid) (kube_pod_init_status_restarts_total{container != "", pod != "", job = "kube-state-metrics"})
)
* on (pod, namespace, cluster, microsoft_resourceid) group_left (node, created_by_name, created_by_kind)
(
max by (node, created_by_name, created_by_kind, pod, namespace, cluster, microsoft_resourceid) (
    kube_pod_info{pod != "", job = "kube-state-metrics"}
)
)
)

)
EOF
  },
  {
    enabled    = true
    record     = "ux:controller_container_restarts:max"
    expression = <<EOF
max by (node, created_by_name, created_by_kind, namespace, cluster, microsoft_resourceid) (
ux:pod_container_restarts:max
)
EOF
  },
  {
    enabled    = true
    record     = "ux:pod_resource_limit:sum"
    expression = <<EOF
(sum by (cluster, pod, namespace, resource, microsoft_resourceid) (
(
    max by (cluster, microsoft_resourceid, pod, container, namespace, resource)
     (kube_pod_container_resource_limits{container != "", pod != "", job = "kube-state-metrics"})
)
)unless (count by (pod, namespace, cluster, resource, microsoft_resourceid)
    (kube_pod_container_resource_limits{container != "", pod != "", job = "kube-state-metrics"})
!= on (pod, namespace, cluster, microsoft_resourceid) group_left()
 sum by (pod, namespace, cluster, microsoft_resourceid)
 (kube_pod_container_info{container != "", pod != "", job = "kube-state-metrics"}) 
)

)* on (namespace, pod, cluster, microsoft_resourceid) group_left (node, created_by_kind, created_by_name)
(
    kube_pod_info{pod != "", job = "kube-state-metrics"}
)
EOF
  },
  {
    enabled    = true
    record     = "ux:controller_resource_limit:sum"
    expression = <<EOF
sum by (cluster, namespace, created_by_name, created_by_kind, node, resource, microsoft_resourceid) (
ux:pod_resource_limit:sum
)
EOF
  },
  {
    enabled    = true
    record     = "ux:controller_pod_phase_count:sum"
    expression = <<EOF
sum by (cluster, phase, node, created_by_kind, created_by_name, namespace, microsoft_resourceid) ( (
(kube_pod_status_phase{job="kube-state-metrics",pod!=""})
 or (label_replace((count(kube_pod_deletion_timestamp{job="kube-state-metrics",pod!=""}) by (namespace, pod, cluster, microsoft_resourceid) * count(kube_pod_status_reason{reason="NodeLost", job="kube-state-metrics"} == 0) by (namespace, pod, cluster, microsoft_resourceid)), "phase", "terminating", "", ""))) * on (pod, namespace, cluster, microsoft_resourceid) group_left (node, created_by_name, created_by_kind)
(
max by (node, created_by_name, created_by_kind, pod, namespace, cluster, microsoft_resourceid) (
kube_pod_info{job="kube-state-metrics",pod!=""}
)
)
)
EOF
  },
  {
    enabled    = true
    record     = "ux:cluster_pod_phase_count:sum"
    expression = <<EOF
sum by (cluster, phase, node, namespace, microsoft_resourceid) (
ux:controller_pod_phase_count:sum
)
EOF
  },
  {
    enabled    = true
    record     = "ux:node_cpu_usage:sum_irate"
    expression = <<EOF
sum by (instance, cluster, microsoft_resourceid) (
(1 - irate(node_cpu_seconds_total{job="node", mode="idle"}[5m]))
)
EOF
  },
  {
    enabled    = true
    record     = "ux:node_memory_usage:sum"
    expression = <<EOF
sum by (instance, cluster, microsoft_resourceid) ((
node_memory_MemTotal_bytes{job = "node"}
- node_memory_MemFree_bytes{job = "node"} 
- node_memory_cached_bytes{job = "node"}
- node_memory_buffers_bytes{job = "node"}
))
EOF
  },
  {
    enabled    = true
    record     = "ux:node_network_receive_drop_total:sum_irate"
    expression = <<EOF
sum by (instance, cluster, microsoft_resourceid) (irate(node_network_receive_drop_total{job="node", device!="lo"}[5m]))
EOF
  },
  {
    enabled    = true
    record     = "ux:node_network_transmit_drop_total:sum_irate"
    expression = <<EOF
sum by (instance, cluster, microsoft_resourceid) (irate(node_network_transmit_drop_total{job="node", device!="lo"}[5m]))
EOF
  }
]

# Alert Configuration
alert_configuration = {
  email_receiver = {
    email_address = "admin@example.com"
    name          = "aks-admin-alerts"
  }
  action_group = {
    short_name = "aks-alerts"
    location   = "germanywestcentral"
  }
}

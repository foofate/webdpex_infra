module "kube" {
  source     = "/mnt/d/modules/terraform-yc-kubernetes"
  network_id = module.yc-vpc.vpc_id

  public_access = true

  master_locations = [
    for s in module.yc-vpc.private_subnets :
    {
      zone      = s.zone,
      subnet_id = s.subnet_id
    }
  ]

  master_maintenance_windows = [
    {
      day        = "monday"
      start_time = "23:00"
      duration   = "3h"
    }
  ]

  node_groups = {
    "node-groupe" = {
      description = "Autoscale environment"
      auto_scale = {
        min     = 2
        max     = 4
        initial = 2
      }
      node_labels = {
        role        = "worker"
        environment = "prod"
      }

      max_expansion   = 1
      max_unavailable = 1
    }
  }
}

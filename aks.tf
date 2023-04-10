data "azurerm_kubernetes_service_versions" "aks_version" {
  count           = var.location == null ? 0 : 1
  location        = var.location
  include_preview = false
}

module "aks" {
  count               = var.azure_aks_deploy ? 1 : 0
  source              = "Azure/aks/azurerm"
  version             = "6.8.0"
  prefix              = var.prefix
  resource_group_name = var.resource_group_name

  aci_connector_linux_enabled                          = var.aci_connector_linux_enabled
  aci_connector_linux_subnet_name                      = var.aci_connector_linux_subnet_name
  admin_username                                       = var.admin_username
  agents_availability_zones                            = var.agents_availability_zones
  agents_count                                         = var.agents_count
  agents_labels                                        = var.agents_labels
  agents_max_count                                     = var.agents_max_count
  agents_max_pods                                      = var.agents_max_pods
  agents_min_count                                     = var.agents_min_count
  agents_pool_kubelet_configs                          = var.agents_pool_kubelet_configs
  agents_pool_linux_os_configs                         = var.agents_pool_linux_os_configs
  agents_pool_name                                     = var.agents_pool_name
  agents_size                                          = var.agents_size
  agents_tags                                          = var.agents_tags
  agents_taints                                        = var.agents_taints
  agents_type                                          = var.agents_type
  api_server_authorized_ip_ranges                      = var.api_server_authorized_ip_ranges
  attached_acr_id_map                                  = var.attached_acr_id_map
  auto_scaler_profile_balance_similar_node_groups      = var.auto_scaler_profile_balance_similar_node_groups
  auto_scaler_profile_empty_bulk_delete_max            = var.auto_scaler_profile_empty_bulk_delete_max
  auto_scaler_profile_enabled                          = var.auto_scaler_profile_enabled
  auto_scaler_profile_expander                         = var.auto_scaler_profile_expander
  auto_scaler_profile_max_graceful_termination_sec     = var.auto_scaler_profile_max_graceful_termination_sec
  auto_scaler_profile_max_node_provisioning_time       = var.auto_scaler_profile_max_node_provisioning_time
  auto_scaler_profile_max_unready_nodes                = var.auto_scaler_profile_max_unready_nodes
  auto_scaler_profile_max_unready_percentage           = var.auto_scaler_profile_max_unready_percentage
  auto_scaler_profile_new_pod_scale_up_delay           = var.auto_scaler_profile_new_pod_scale_up_delay
  auto_scaler_profile_scale_down_delay_after_add       = var.auto_scaler_profile_scale_down_delay_after_add
  auto_scaler_profile_scale_down_delay_after_delete    = var.auto_scaler_profile_scale_down_delay_after_delete
  auto_scaler_profile_scale_down_delay_after_failure   = var.auto_scaler_profile_scale_down_delay_after_failure
  auto_scaler_profile_scale_down_unneeded              = var.auto_scaler_profile_scale_down_unneeded
  auto_scaler_profile_scale_down_unready               = var.auto_scaler_profile_scale_down_unready
  auto_scaler_profile_scale_down_utilization_threshold = var.auto_scaler_profile_scale_down_utilization_threshold
  auto_scaler_profile_scan_interval                    = var.auto_scaler_profile_scan_interval
  auto_scaler_profile_skip_nodes_with_local_storage    = var.auto_scaler_profile_skip_nodes_with_local_storage
  auto_scaler_profile_skip_nodes_with_system_pods      = var.auto_scaler_profile_skip_nodes_with_system_pods
  automatic_channel_upgrade                            = var.automatic_channel_upgrade
  azure_policy_enabled                                 = var.azure_policy_enabled
  client_id                                            = var.client_id
  client_secret                                        = var.client_secret
  cluster_log_analytics_workspace_name                 = var.cluster_log_analytics_workspace_name
  cluster_name                                         = var.cluster_name
  create_role_assignment_network_contributor           = var.create_role_assignment_network_contributor
  disk_encryption_set_id                               = var.disk_encryption_set_id
  enable_auto_scaling                                  = var.enable_auto_scaling
  enable_host_encryption                               = var.enable_host_encryption
  enable_node_public_ip                                = var.enable_node_public_ip
  http_application_routing_enabled                     = var.http_application_routing_enabled
  identity_ids                                         = var.identity_ids
  identity_type                                        = var.identity_type
  ingress_application_gateway_enabled                  = var.ingress_application_gateway_enabled
  ingress_application_gateway_id                       = var.ingress_application_gateway_id
  ingress_application_gateway_name                     = var.ingress_application_gateway_name
  ingress_application_gateway_subnet_cidr              = var.ingress_application_gateway_subnet_cidr
  ingress_application_gateway_subnet_id                = var.ingress_application_gateway_subnet_id
  key_vault_secrets_provider_enabled                   = var.key_vault_secrets_provider_enabled
  kms_enabled                                          = var.kms_enabled
  kms_key_vault_key_id                                 = var.kms_key_vault_key_id
  kms_key_vault_network_access                         = var.kms_key_vault_network_access
  kubernetes_version                                   = var.kubernetes_version
  load_balancer_profile_enabled                        = var.load_balancer_profile_enabled
  load_balancer_profile_idle_timeout_in_minutes        = var.load_balancer_profile_idle_timeout_in_minutes
  load_balancer_profile_managed_outbound_ip_count      = var.load_balancer_profile_managed_outbound_ip_count
  load_balancer_profile_managed_outbound_ipv6_count    = var.load_balancer_profile_managed_outbound_ipv6_count
  load_balancer_profile_outbound_ip_address_ids        = var.load_balancer_profile_outbound_ip_address_ids
  load_balancer_profile_outbound_ip_prefix_ids         = var.load_balancer_profile_outbound_ip_prefix_ids
  load_balancer_profile_outbound_ports_allocated       = var.load_balancer_profile_outbound_ports_allocated
  load_balancer_sku                                    = var.load_balancer_sku
  local_account_disabled                               = var.local_account_disabled
  location                                             = var.location
  log_analytics_solution_id                            = var.log_analytics_solution_id
  log_analytics_workspace                              = var.log_analytics_workspace
  log_analytics_workspace_enabled                      = var.log_analytics_workspace_enabled
  log_analytics_workspace_resource_group_name          = var.log_analytics_workspace_resource_group_name
  log_analytics_workspace_sku                          = var.log_analytics_workspace_sku
  log_retention_in_days                                = var.log_retention_in_days
  maintenance_window                                   = var.maintenance_window
  microsoft_defender_enabled                           = var.microsoft_defender_enabled
  monitor_metrics                                      = var.monitor_metrics
  net_profile_dns_service_ip                           = var.net_profile_dns_service_ip
  net_profile_docker_bridge_cidr                       = var.net_profile_docker_bridge_cidr
  net_profile_outbound_type                            = var.net_profile_outbound_type
  net_profile_pod_cidr                                 = var.net_profile_pod_cidr
  net_profile_service_cidr                             = var.net_profile_service_cidr
  network_plugin                                       = var.network_plugin
  network_policy                                       = var.network_policy
  node_pools                                           = var.node_pools
  node_resource_group                                  = var.node_resource_group
  oidc_issuer_enabled                                  = var.oidc_issuer_enabled
  only_critical_addons_enabled                         = var.only_critical_addons_enabled
  open_service_mesh_enabled                            = var.open_service_mesh_enabled
  orchestrator_version                                 = var.orchestrator_version
  os_disk_size_gb                                      = var.os_disk_size_gb
  os_disk_type                                         = var.os_disk_type
  os_sku                                               = var.os_sku
  pod_subnet_id                                        = var.pod_subnet_id
  private_cluster_enabled                              = var.private_cluster_enabled
  private_cluster_public_fqdn_enabled                  = var.private_cluster_public_fqdn_enabled
  private_dns_zone_id                                  = var.private_dns_zone_id
  public_network_access_enabled                        = var.public_network_access_enabled
  public_ssh_key                                       = var.public_ssh_key
  rbac_aad                                             = var.rbac_aad
  rbac_aad_admin_group_object_ids                      = var.rbac_aad_admin_group_object_ids
  rbac_aad_azure_rbac_enabled                          = var.rbac_aad_azure_rbac_enabled
  rbac_aad_client_app_id                               = var.rbac_aad_client_app_id
  rbac_aad_managed                                     = var.rbac_aad_managed
  rbac_aad_server_app_id                               = var.rbac_aad_server_app_id
  rbac_aad_server_app_secret                           = var.rbac_aad_server_app_secret
  rbac_aad_tenant_id                                   = var.rbac_aad_tenant_id
  role_based_access_control_enabled                    = var.role_based_access_control_enabled
  scale_down_mode                                      = var.scale_down_mode
  secret_rotation_enabled                              = var.secret_rotation_enabled
  secret_rotation_interval                             = var.secret_rotation_interval
  sku_tier                                             = var.sku_tier
  storage_profile_blob_driver_enabled                  = var.storage_profile_blob_driver_enabled
  storage_profile_disk_driver_enabled                  = var.storage_profile_disk_driver_enabled
  storage_profile_disk_driver_version                  = var.storage_profile_disk_driver_version
  storage_profile_enabled                              = var.storage_profile_enabled
  storage_profile_file_driver_enabled                  = var.storage_profile_file_driver_enabled
  storage_profile_snapshot_controller_enabled          = var.storage_profile_snapshot_controller_enabled
  tags                                                 = var.tags
  temporary_name_for_rotation                          = var.temporary_name_for_rotation
  ultra_ssd_enabled                                    = var.ultra_ssd_enabled
  vnet_subnet_id                                       = var.vnet_subnet_id
  web_app_routing                                      = var.web_app_routing
  workload_identity_enabled                            = var.workload_identity_enabled
}

data "azurerm_kubernetes_cluster" "default" {
  depends_on          = [module.aks] # refresh cluster state before reading
  name                = var.cluster_name
  resource_group_name = var.resource_group_name
}

aks_vnet_name = "triton-aks-vnet"

sshkvsecret = "triton-ssh-public-key"

clientidkvsecret = "triton-service-principal-client-id"

spnkvsecret = "triton-sp-client-secret-vaule"

vnetcidr = ["10.0.0.0/24"]

subnetcidr = ["10.0.0.0/25"]

keyvault_rg = "triton-kv-sg"

keyvault_name = "triton-kv"

azure_region = "eastasia"

resource_group = "triton-aks-rg"

cluster_name = "triton-test-cluster"

dns_name = "triton"

admin_username = "tritonadmin"

kubernetes_version = "1.21.7"

agent_pools = {
      name            = "tritonpool"
      count           = 2
      vm_size         = "Standard_D2_v2"
      os_disk_size_gb = "30"
    }

#PROXMOX

# Connection details for the API
proxmox_api_url          = "https://192.168.1.254:8006/api2/json"
proxmox_api_token_id     = "terraform@pve!terraform-token"
proxmox_api_token_secret = "8f466a9f-f16f-4c63-a16d-3333f23f261f"

#General configuration
proxmox_node       = "andromeda"
proxmox_vm_pool    = "WSC2022"
proxmox_vm_storage = "local_zfs"

# Network configuration 
proxmox_wsc2022kr_internal_bridge = "vmbr1"
proxmox_wsc2022kr_dmz_bridge      = "vmbr4"
proxmox_wsc2022kr_edge_bridge     = "vmbr5"
proxmox_wsc2024fr_internal_bridge = "vmbr2"
proxmox_internet_bridge           = "vmbr3"

#Authentication configuration for the VMs
vm_user     = "user"
vm_password = "Skill39"
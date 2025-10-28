-- ============================================
-- CSS Language Server
-- ============================================

return {
    settings = {
        css = {
            validate = true,
            lint = {
                compatibleVendorPrefixes = "warning",
                vendorPrefix = "warning",
                duplicateProperties = "warning",
            },
        },
        scss = {
            validate = true,
        },
        less = {
            validate = true,
        },
    },
}

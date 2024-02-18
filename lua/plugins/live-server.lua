return {
        'barrett-ruth/live-server.nvim',
        build = 'sudo npm add -g live-server',
        cmd = { 'LiveServerStart', 'LiveServerStop' },
        config = function ()
          require("live-server").setup()
        end
}

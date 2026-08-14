vim.opt.langmap = table.concat({
    "u;k", "n;h", "e;j", "i;l", -- up     left   down   right
    "h;i", "j;e", "k;n", "l;u", -- insert e-word n-next undo
    "U;H", "N;J", "E;L", "I;K", -- s-top  join   s-bot  help
    "H;I", "J;E", "K;N", "L;U", -- i-BOL  E-word N-prev U-line
}, ",")
function SMB.load_cards(path)
    files = NFS.getDirectoryItems(SMODS.current_mod.path .. path)
    print("[SMB] Loading module: " .. path)
    for i = 1, #files do
        SMODS.load_file(path .. "/" .. files[i])()
    end 
end
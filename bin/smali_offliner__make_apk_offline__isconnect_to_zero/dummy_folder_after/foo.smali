   :goto_d
    iget-object v3, v1, Lk/y/b/j0/b$c;->e:Lcom/vungle/warren/downloader/DownloadRequestMediator;

    invoke-virtual {v3}, Lcom/vungle/warren/downloader/DownloadRequestMediator;->isConnected()Z

    ####move-result v3

    const/4 v3, 0x0

    if-eqz v3, :cond_1d
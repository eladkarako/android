content = 
`
   :goto_d
    iget-object v3, v1, Lk/y/b/j0/b$c;->e:Lcom/vungle/warren/downloader/DownloadRequestMediator;

    invoke-virtual {v3}, Lcom/vungle/warren/downloader/DownloadRequestMediator;->isConnected()Z

    move-result v3

    if-eqz v3, :cond_1d
`
;

var regexp_to_match_all_lines                = /(\-\>isconnec.*)($\s*)move-result ([^\s].*)$/igm
   ,regexp_to_break_matched_line_into_groups = /(\-\>isconnec.*)$\s*([^\s].*)$/im
   ;


var matches = Array.from(content.matchAll(regexp_to_match_all_lines))
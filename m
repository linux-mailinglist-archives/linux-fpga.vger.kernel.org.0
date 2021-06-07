Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CC39E939
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Jun 2021 23:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFGWBA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Jun 2021 18:01:00 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:43795 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhFGWBA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Jun 2021 18:01:00 -0400
Received: by mail-pf1-f181.google.com with SMTP id m7so1208136pfa.10;
        Mon, 07 Jun 2021 14:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9jTPa0UY0tGM691xkf4yxBu/UIOdvQ3MoXTrDLCVE28=;
        b=Ch8sEKrmHBy5Hd1vYzfP481OFkYaKiGGy9aJEPSgPBSYo8nRDMP7YpNrqsj+VB8MDh
         2aJOxUxSn3hm9sW5nsx8aa6nDbJulupfnbuWR7EtcKoczsJBgt7/rhZIqlTv9oayeOcs
         B7kSxzBtqTTNpgwJL45zvCSf/RfLbje9bfeGqssBlKnawh91BxUb1VlTQFbFatbTyMpM
         uRwXKJyMweLggHETbQcyfiXiLUQu20VgjADfeIoB/bwCvG+378f7+CsoaHAOFtIGQSnw
         4rkuJTjSvlQQ6tF06WdoqUjMIb8RqixtK12coN8OrkwGHDdsearY8Eo1RMgiZ/F5LD91
         FdxQ==
X-Gm-Message-State: AOAM530W0ZZd5XJmgNwGQ6gB7WxBnSv+AaWC7UeOoTPGgyg8tG8+QO7z
        Wf7rExlWO23CoM0jfH5KfcU=
X-Google-Smtp-Source: ABdhPJwEMED3BT+2G+KRaSnckuwCNQr48LAlsO0xt0KeqSs5tL2hlvV+se5oBw6uhM8ZSwyY8v1M8Q==
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id w125-20020a62dd830000b02902e8e511c32fmr18934441pff.49.1623103148070;
        Mon, 07 Jun 2021 14:59:08 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id n23sm9170372pff.93.2021.06.07.14.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 14:59:07 -0700 (PDT)
Date:   Mon, 7 Jun 2021 14:59:06 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] fpga: wrappers for fpga_manager_ops
Message-ID: <YL6WqqUYHkhj+tEj@epycbox.lan>
References: <20210607172402.2938697-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607172402.2938697-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

On Mon, Jun 07, 2021 at 10:23:55AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> As followup from
> https://lore.kernel.org/linux-fpga/06301910-10a1-0e62-45a0-d28ab5a787ed@redhat.com/
> 
> Boards should not be required to have noop functions.
> So improve or create fpga-mgr wrappers for the fpga_manager_ops.  
> Remove the noop functions.
> Refactor fpga-mgr to use the wrappers.
> 
> write_sg op was not wrapped on purpose.  Its checking / use in
> fpga_mgr_buf_load_sg() did not warrant a wrapper.
> 
> Tom Rix (7):
>   fpga: wrap the write_init() op
>   fpga: make write_complete() op optional
>   fpga: wrap the write() op
>   fpga: wrap the status() op
>   fpga: wrap the state() op
>   fpga: wrap the fpga_remove() op
>   fpga: collect wrappers and change to inline
> 
>  drivers/fpga/dfl-fme-mgr.c   |   6 ---
>  drivers/fpga/fpga-mgr.c      | 102 +++++++++++++++++++++++------------
>  drivers/fpga/stratix10-soc.c |   6 ---
>  drivers/fpga/ts73xx-fpga.c   |   6 ---
>  drivers/fpga/zynqmp-fpga.c   |   7 ---
>  5 files changed, 67 insertions(+), 60 deletions(-)
> 
> -- 
> 2.26.3
> 

Thanks for doing this, will take a look tonight!

- Moritz

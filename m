Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356C0257117
	for <lists+linux-fpga@lfdr.de>; Mon, 31 Aug 2020 02:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgHaAFa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 30 Aug 2020 20:05:30 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40014 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgHaAF3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 30 Aug 2020 20:05:29 -0400
Received: by mail-pj1-f68.google.com with SMTP id kx11so2071157pjb.5;
        Sun, 30 Aug 2020 17:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X+6Dlx8NV1kQ54mK9vN+wa4pINev/YtuIruDSPrIKmY=;
        b=ZWdHgZp3qWk5VVnzbE1ck9csFphq+jQLVcrDIG/I/zVmFTTfF6f/s4nHLriT7Z+ZuL
         QSaf8vyK2HofK0tnpeAjhotPnCF3RRukgf38yUfoYtPVZT6Rpf61a522t97w2C3JqvoJ
         WEApNkayExZQMCXQoEf4gmFEKpNma/7sSRWJsJ6lO+YMMXQMzdQdVgNPUsp8zKI242gR
         vZ5lsgPA0LcDhx8d6z7IWxTkg48VPBJUPudoUdk7INLzORdiX+lugtCijmm43w8U3yyZ
         BgtY6UkJfQjRjJ5hSP2G9m6t+PftY+KNYgce7viXuoxL84eyll0DOOYG4KkVKnbHdQlW
         pC3g==
X-Gm-Message-State: AOAM533oB9QqwvLdYCIrSF/ZduWIdkYQQnFt9nFPtRCOTrLo+EQR1irN
        JFPUzlvV1WODZdqAyLe6rz4=
X-Google-Smtp-Source: ABdhPJxKmdPEZzIvJKXdOOlmodT/nEgx8huKeBShc946fXpRzJ46pXeudtd4oPq3YXWNZ0DDWTlh6w==
X-Received: by 2002:a17:90a:d711:: with SMTP id y17mr6705402pju.10.1598832328256;
        Sun, 30 Aug 2020 17:05:28 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id b6sm5087273pjz.33.2020.08.30.17.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 17:05:27 -0700 (PDT)
Date:   Sun, 30 Aug 2020 17:05:27 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v4 2/5] fpga manager: xilinx-spi: remove final dot from
 dev_err() strings
Message-ID: <20200831000527.GB7421@epycbox.lan>
References: <20200830163850.8380-1-luca@lucaceresoli.net>
 <20200830163850.8380-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830163850.8380-2-luca@lucaceresoli.net>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Aug 30, 2020 at 06:38:47PM +0200, Luca Ceresoli wrote:
> Most dev_err messages in this file have no final dot. Remove the only two
> exceptions to make them consistent.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v4:
>  - add Reviewed-by Tom Rix
> 
> Changes in v3: none.
> 
> Changes in v2:
>  - move before the "provide better diagnostics on programming failure"
>    patch for clarity
> ---
>  drivers/fpga/xilinx-spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 502fae0d1d85..01f494172379 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -77,7 +77,7 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
>  	int err;
>  
>  	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> -		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
> +		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
>  		return -EINVAL;
>  	}
>  
> @@ -169,7 +169,7 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
>  			return xilinx_spi_apply_cclk_cycles(conf);
>  	}
>  
> -	dev_err(&mgr->dev, "Timeout after config data transfer.\n");
> +	dev_err(&mgr->dev, "Timeout after config data transfer\n");
>  	return -ETIMEDOUT;
>  }
>  
> -- 
> 2.28.0
> 
Applied to for-next,

Thanks

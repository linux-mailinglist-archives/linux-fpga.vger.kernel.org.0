Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC90413781F
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Jan 2020 21:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgAJUxM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Jan 2020 15:53:12 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51587 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgAJUxL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Jan 2020 15:53:11 -0500
Received: by mail-pj1-f65.google.com with SMTP id d15so78237pjw.1;
        Fri, 10 Jan 2020 12:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LUH5GtfLSwD9hjB8rTrKF9ZhPwi3kWslMdByd0hgO/c=;
        b=RAFT9bUGe/jmzsqNgqcsJWATa8o6duSX/ipETONxJHOe44NfuFN3b5ZKb+zLc/D/vz
         VgTsaA+616qD3pRs1RJyXMbuKGp8gEZ3D1GPxDCBW+KW/o4L76ggodj1zpZz3xSCoaHz
         jgYw6wSaR8jcp1VF7RdleEyo8EoP8rv2AHYPYGRzCcr0vN4UjijyDEm4m3LB3sqoeeYs
         YiQOSWubHxlzZX6s3YXNe39FrqMIvw5mSqmtrzW67ZCPIPT0dRnpeq+Pon5m7L4OTJLZ
         gI8BZsvFj41hFWxpD2zwmiKCurOqZf44dF0K90HHALHubOga35ETievrPrwl/vTO6A+K
         YdJg==
X-Gm-Message-State: APjAAAUTIPecL9sg46zSzelI8JhBYfnKnLlIV5FBGHH9fq6Vhqm8ZG8Z
        oAMbj2eABpz6BF6guNr7w3Q=
X-Google-Smtp-Source: APXvYqxvUdDAFKBiG1LrEXVkw2L2jENZuvWk3o25dgUNS9tFZF2dVQ9KT+MIQkOVBGaU/px9Yd8LaQ==
X-Received: by 2002:a17:90a:c385:: with SMTP id h5mr7108179pjt.122.1578689590807;
        Fri, 10 Jan 2020 12:53:10 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:ffa7:88dc:9c39:76d9])
        by smtp.gmail.com with ESMTPSA id h7sm4395387pfq.36.2020.01.10.12.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 12:53:09 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:53:07 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Remove clk_get error message
 for probe defer
Message-ID: <20200110205307.GA3246@epycbox.lan>
References: <20200110063113.3064-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110063113.3064-1-nava.manne@xilinx.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jan 10, 2020 at 12:01:13PM +0530, Nava kishore Manne wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> In probe, the driver checks for devm_clk_get return and print error
> message in the failing case. However for -EPROBE_DEFER this message
> is confusing so avoid it.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/fpga/xilinx-pr-decoupler.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index af9b387c56d3..7d69af230567 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -101,7 +101,8 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  
>  	priv->clk = devm_clk_get(&pdev->dev, "aclk");
>  	if (IS_ERR(priv->clk)) {
> -		dev_err(&pdev->dev, "input clock not found\n");
> +		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "input clock not found\n");
>  		return PTR_ERR(priv->clk);
>  	}
>  
> -- 
> 2.18.0
> 
Applied to for-next,

Thanks

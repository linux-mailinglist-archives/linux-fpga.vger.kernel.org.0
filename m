Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED431311FEF
	for <lists+linux-fpga@lfdr.de>; Sat,  6 Feb 2021 21:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBFUdb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 6 Feb 2021 15:33:31 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:45070 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFUda (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 6 Feb 2021 15:33:30 -0500
Received: by mail-pg1-f170.google.com with SMTP id o21so5666054pgn.12;
        Sat, 06 Feb 2021 12:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wShEuuu9XJ9Fvg1+uzzmDXaa5v0f3YmOpMzYCaPD5jY=;
        b=enJcUn8g829qBBB3TabLd50jQb2OrjeCj0BHxRY0iLVlAnJ8XBP+x1N+SnXtmS6JDV
         gbsY8YWD4ZH4OTBpcC8e0ZhPeyjW6rPqcG23YcKpbcwHu8m0NTeC3lyr5WnnivAIWSnM
         6FJwQrW/6GQX7P7U3sKBHeg7HdFmG3HcAtnj+ofjYxU4nLbsPjTz8cyZ7wJJrZKtI9VH
         GWWKucc9S3P7H9VsRfDYY9SqdoYpHTG7dv/XxcSIawCHa19ZFyv7xy98ZJjFYb6FtLSr
         m6C7Pbd0RWwCo2SAvGc9ttCg3xwSvVvtrTpwcY3fvQ3WZK9JaUyezKMiA2RRX4fYqWWU
         xw/g==
X-Gm-Message-State: AOAM5305uc1aiq2jMRE6YRx6sHEvUkY56yQy0iJmf6vJFXPBpW7gJ9Bh
        LlCIce7AhER2I0f5srNuZ6c=
X-Google-Smtp-Source: ABdhPJy0aO+cc2MQQBQuMcxCNwG2P2KRzrcfLZx+UYNGF3hB0IvxiA1EYRRNZnuQfCn9bf8H45ElGw==
X-Received: by 2002:a62:1d14:0:b029:1d7:aed0:64ad with SMTP id d20-20020a621d140000b02901d7aed064admr9094618pfd.38.1612643570028;
        Sat, 06 Feb 2021 12:32:50 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id fv11sm841888pjb.18.2021.02.06.12.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 12:32:48 -0800 (PST)
Date:   Sat, 6 Feb 2021 12:32:47 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Simplify code by using
 dev_err_probe()
Message-ID: <YB7879iHT8lQT8sW@epycbox.lan>
References: <666708105c25ae5fa7bb23b5eabd7d12fe9cb1b3.1612445770.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <666708105c25ae5fa7bb23b5eabd7d12fe9cb1b3.1612445770.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Feb 04, 2021 at 02:36:11PM +0100, Michal Simek wrote:
> Use already prepared dev_err_probe() introduced by commit a787e5400a1c
> ("driver core: add device probe log helper").
> It simplifies EPROBE_DEFER handling.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/fpga/xilinx-pr-decoupler.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index 7d69af230567..b0eaf26af6e7 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -100,11 +100,9 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->io_base);
>  
>  	priv->clk = devm_clk_get(&pdev->dev, "aclk");
> -	if (IS_ERR(priv->clk)) {
> -		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "input clock not found\n");
> -		return PTR_ERR(priv->clk);
> -	}
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
> +				     "input clock not found\n");
>  
>  	err = clk_prepare_enable(priv->clk);
>  	if (err) {
> -- 
> 2.30.0
> 
Looks good, will queue.

- Moritz

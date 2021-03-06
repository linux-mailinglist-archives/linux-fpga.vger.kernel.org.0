Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209BF32FB71
	for <lists+linux-fpga@lfdr.de>; Sat,  6 Mar 2021 16:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhCFPl3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 6 Mar 2021 10:41:29 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:34686 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhCFPlJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 6 Mar 2021 10:41:09 -0500
Received: by mail-pl1-f174.google.com with SMTP id ba1so2899070plb.1;
        Sat, 06 Mar 2021 07:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nXc40e+JPmYpBu4fmyccX1rpUpLpord1lILzin0rU+8=;
        b=RJvfRusmnIHHiqSANbVU1vJ4mpQOOYMKE4FKdPpthegvzf0KfE4zUC7i7Mwvo1eKD2
         YRFq3Fkz1W/YJBxp8/3w2oYQTE2xSfNx9WzlxLH3jvPr3XDSlfsyugTNU9qH617c3qg/
         EyMCA5BDeHsE0vfkELYGo8r74kU7vhVj0ppN+sqoAe0r0KL+zCR8uHTFLO/o+Pm3yYJ3
         1ModYBaG1iLdKPpSrdz507WB8FZKQePSAkRfd41tONFf9M+MESqJ+Kf8WTD2mlWcLhza
         EdTkKqzlIOWvpm22lOM1jG6FwubVoVcqM+tasmjc/ra4MKkXKyzGpW2RBNfxUE7Egwse
         zuew==
X-Gm-Message-State: AOAM530npBpUi6COYUYpLD3vPTVwm+TxpmfrjUP/T0peYb4SX7dtYhO/
        XVf8fJULtowhWIXV/VNvcpmlJT1Ed98=
X-Google-Smtp-Source: ABdhPJzbOb3I8RKUG8KemBKLeGCeNFJ1TE/wsPfNSqWBYPoGaPn8HWcAhUbdsVkDsz6DsP1TJoRScg==
X-Received: by 2002:a17:903:31c4:b029:e1:8840:8ab9 with SMTP id v4-20020a17090331c4b02900e188408ab9mr13355587ple.70.1615045268594;
        Sat, 06 Mar 2021 07:41:08 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id v1sm5827121pjt.1.2021.03.06.07.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 07:41:07 -0800 (PST)
Date:   Sat, 6 Mar 2021 07:41:06 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Simplify code by using
 dev_err_probe()
Message-ID: <YEOikp4Zs4/ABkof@epycbox.lan>
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
Applied to for-5.13,

Thanks

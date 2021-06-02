Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE38A398A2C
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Jun 2021 15:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhFBNEe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Jun 2021 09:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhFBNEd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 2 Jun 2021 09:04:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E87FE613D6;
        Wed,  2 Jun 2021 13:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622638971;
        bh=9GVCr1LuCvcjTrKzbRTyT/1HGLmEne+W2aNyF5fY9Ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGDC1pckBbHFpilSlrP5ficerhpwZc0XRBn9Ghsgg4tiIrjuM8yFGhFATo4EU121z
         f+j34bWeyvWnMhSQ/KYq5AiWQi2CONmNNDeEmkLGcl77whH7PARMfnZADZZhLWlPOJ
         Ri3Ys/c3QfphLNRC49FJyAQoVnL6c1F/n2LFTm3Hk9O4sSKAOindmOa7e3ShRUqXro
         /tarCoUoHDQiHG0GI0LfgqfdtWIUUcNaQEFKTDqlh1VT4AEIbSSTNwRZNMcpG5nK8U
         wvMzuXQ9nSv7oMFpX2ygLn7bH63SYxQsTGZnABZVvC6NloZ7tlqHsX4mx/Yli16Ny8
         HkpIWbjdJGkvg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1loQWG-0000Mb-0x; Wed, 02 Jun 2021 15:02:48 +0200
Date:   Wed, 2 Jun 2021 15:02:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, trix@redhat.com, robh+dt@kernel.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
Subject: Re: [PATCH 3/3] fpga: region: Adds runtime PM support
Message-ID: <YLeBeJjwki/9VVR2@hovoldconsulting.com>
References: <20210402092049.479-1-nava.manne@xilinx.com>
 <20210402092049.479-4-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402092049.479-4-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Apr 02, 2021 at 02:50:49PM +0530, Nava kishore Manne wrote:
> Adds support to handle FPGA/PL power domain. With this patch,
> the PL power domain will be turned on before loading the bitstream
> and turned off while removing/unloading the bitstream using overlays.
> This can be achieved by adding the runtime PM support.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/of-fpga-region.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

>  /**
> @@ -411,9 +416,16 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>  		goto eprobe_mgr_put;
>  	}
>  
> +	pm_runtime_enable(&pdev->dev);
> +	ret = pm_runtime_get_sync(&pdev->dev);
> +	if (ret < 0)
> +		goto err_pm;
> +
> +	pm_runtime_put(&pdev->dev);
> +
>  	ret = fpga_region_register(region);
>  	if (ret)
> -		goto eprobe_mgr_put;
> +		goto err_pm;

Just a drive-by comment: you have PM usage counter imbalance here
(double put).

>  	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
>  	platform_set_drvdata(pdev, region);
> @@ -422,6 +434,9 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +err_pm:
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  eprobe_mgr_put:
>  	fpga_mgr_put(mgr);
>  	return ret;

Johan

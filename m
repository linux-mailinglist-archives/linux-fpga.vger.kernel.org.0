Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9185D627803
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Nov 2022 09:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiKNIoP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Nov 2022 03:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbiKNIoO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Nov 2022 03:44:14 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65A81A80B;
        Mon, 14 Nov 2022 00:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668415453; x=1699951453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=20z4hjjoPZCyj4x4M9p7no1rjwPWwV6NdfTwt72mSys=;
  b=ZTS/HCho9aV+Yg/Zpp0WQMEA52uWza3trG0GcQyW8YD9nyW0yvCenEdP
   EIn5YgbSRm4ErD4RpiHXcXU8c+574PM6SmgvAB/FH87q+tZyukGxyorZA
   r2uSF0vmNhyX4W1Xr2CMRDm00Pk9wncGdOdMi9gIbJz0Wq3EsZ+VDKn1t
   7UxRgOXI79cYbQi/Gy3xcYLhAH6aMMdAy/W6zL5XuvYgVhyj4hdPod7AI
   j5JvuNCEDV1/Hl/gOcDBE7bYFWYoxOJR4JrEtTIDbBtGaNwhGcvoyr57a
   iUckja/rn/dnVlzAb7fKtmI4++jPe4/KszzyNEAFgeKlLM4tH1PAPJF5G
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="338700156"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="338700156"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 00:44:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="632723420"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="632723420"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 14 Nov 2022 00:44:10 -0800
Date:   Mon, 14 Nov 2022 16:34:47 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     ye.xingchen@zte.com.cn
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
Subject: Re: [PATCH] fpga-manager: use
 devm_platform_get_and_ioremap_resource()
Message-ID: <Y3H9p38pzqvpjkID@yilunxu-OptiPlex-7050>
References: <202211111441162412524@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211111441162412524@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-11-11 at 14:41:16 +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Please add your own SoB.

> ---
>  drivers/fpga/socfpga-a10.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> index ac8e89b8a5cc..dde2cb49e95d 100644
> --- a/drivers/fpga/socfpga-a10.c
> +++ b/drivers/fpga/socfpga-a10.c
> @@ -479,8 +479,7 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>  		return -ENOMEM;
> 
>  	/* First mmio base is for register access */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	reg_base = devm_ioremap_resource(dev, res);
> +	reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);

Why keep the variable res?

>  	if (IS_ERR(reg_base))
>  		return PTR_ERR(reg_base);

And please make all related changes, at least in driver/fpga.

Thanks,
Yilun

> 
> -- 
> 2.25.1

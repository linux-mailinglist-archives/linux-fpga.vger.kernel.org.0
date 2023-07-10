Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E674D006
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 10:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGJIcA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 04:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGJIcA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 04:32:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC4B9D;
        Mon, 10 Jul 2023 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688977919; x=1720513919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6NhvVYqsHEfigtx0YsZGpiHAjopC+ylj0l2HkwecxA4=;
  b=HlpHaShEZoBpyfrqOAV+jjhzvyp/1JsI8UTmnXWlzsqOJjxokuWH/ao4
   hFwWnG1EgtdULzefMmFCGXRd0HjqyuXz0rMFOXxS9YuJOlXUppIcc1Lpn
   UFQbnB4wPYIum6/TasX8t41zaYHrAveXRazKI+4QrN2QCjfXW6uKvyq5e
   jZm/ROHa3F7v7BxGeJOxU7+vEQNHIq46tWctT83G5LxRwsEFaFJezJjJo
   JfdtZv9kNXORfDymPp06C3M1VHmMvR6unj6brFGU47V93hyy8yPGXHaDP
   y49t/NOV4+cMm8zFk/LxV7CI4YjRBHlE9SEo1YcMwIEi+qoHY8/k4X0bA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="364323958"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364323958"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 01:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="834193498"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="834193498"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2023 01:31:41 -0700
Date:   Mon, 10 Jul 2023 16:30:14 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] fpga: fpga-mgr: altera-pr-ip: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZKvBlrCqzTnBP2S3@yilunxu-OptiPlex-7050>
References: <20230705094655.44753-1-frank.li@vivo.com>
 <20230705094655.44753-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705094655.44753-2-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-05 at 17:46:49 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/fpga/altera-pr-ip-core-plat.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera-pr-ip-core-plat.c
> index b008a6b8d2d3..fbeae6e68f60 100644
> --- a/drivers/fpga/altera-pr-ip-core-plat.c
> +++ b/drivers/fpga/altera-pr-ip-core-plat.c
> @@ -15,13 +15,8 @@ static int alt_pr_platform_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	void __iomem *reg_base;
> -	struct resource *res;
> -
> -	/* First mmio base is for register access */

Please don't drop the comments.

> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -
> -	reg_base = devm_ioremap_resource(dev, res);
>  
> +	reg_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(reg_base))
>  		return PTR_ERR(reg_base);
>  
> -- 
> 2.39.0
> 

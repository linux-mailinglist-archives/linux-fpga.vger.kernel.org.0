Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A366D9D60
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Apr 2023 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbjDFQRm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Apr 2023 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbjDFQRm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Apr 2023 12:17:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E8171B;
        Thu,  6 Apr 2023 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680797855; x=1712333855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BheIOBQvfp+BM3i8yAMZ/e171IUo4NjjXSX9/irNeMQ=;
  b=S5r1VmujncaVaJnec01Gmh7Je6UFK4MCNXpIh0djArk8moO1h4K6vpS8
   d7W2JdS8uyIetKP0eAlJxXfwKB+U0ZAj6UKkMphdlC/Hjhl1D/NCccsoX
   qf1xd/GuPkVynKlelBUxRlC8pavFrT8DmZ+xtX+3BwKwihGpDI5s0gSOs
   EFH0REDZC8suR5VqMkU5Zh3w60PdWIv5BzgBugTzr8t6H5Dfv15gwMYGm
   AReH2Ej0ekIqbpilMXrLZBLXl3Z3i3MvRxQMkJjKpeJHDGeeHzN9OB+yP
   4fgvEeud2V+d7nPXC/q2UKDs8OxEPHoNP4WtJHJ03vZ993r+7lt6/6lta
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="341510078"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="341510078"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 09:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="776522346"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="776522346"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2023 09:16:22 -0700
Date:   Fri, 7 Apr 2023 00:04:42 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     alexis.lothore@bootlin.com
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        russell.h.weight@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        nicolas.carrier@orolia.com
Subject: Re: [PATCH] fpga: bridge: properly initialize bridge device before
 populating children
Message-ID: <ZC7tmjwilC5mDzx+@yilunxu-OptiPlex-7050>
References: <20230404133102.2837535-1-alexis.lothore@bootlin.com>
 <20230404133102.2837535-2-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230404133102.2837535-2-alexis.lothore@bootlin.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-04 at 15:31:02 +0200, alexis.lothore@bootlin.com wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> The current code path can lead to warnings because of uninitialized device,
> which contains, as a consequence, uninitialized kobject. The uninitialized
> device is passed to of_platform_populate, which will at some point, while
> creating child device, try to get a reference on uninitialized parent,
> resulting in the following warning:
> 
> kobject: '(null)' ((ptrval)): is not initialized, yet kobject_get() is
> being called.
> 
> The warning is observed after migrating a kernel 5.10.x to 6.1.x.
> Reverting commit 0d70af3c2530 ("fpga: bridge: Use standard dev_release for
> class driver") seems to remove the warning.
> This commit aggregates device_initialize() and device_add() into
> device_register() but this new call is done AFTER of_platform_populate
> 
> Fixes: 0d70af3c2530 ("fpga: bridge: Use standard dev_release for class driver")
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> ---
>  drivers/fpga/fpga-bridge.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 727704431f61..13918c8c839e 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -360,7 +360,6 @@ fpga_bridge_register(struct device *parent, const char *name,
>  	bridge->dev.parent = parent;
>  	bridge->dev.of_node = parent->of_node;
>  	bridge->dev.id = id;
> -	of_platform_populate(bridge->dev.of_node, NULL, NULL, &bridge->dev);
>  
>  	ret = dev_set_name(&bridge->dev, "br%d", id);
>  	if (ret)
> @@ -372,6 +371,8 @@ fpga_bridge_register(struct device *parent, const char *name,
>  		return ERR_PTR(ret);
>  	}
>  
> +	of_platform_populate(bridge->dev.of_node, NULL, NULL, &bridge->dev);

It makes sense.

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied

> +
>  	return bridge;
>  
>  error_device:
> -- 
> 2.40.0
> 

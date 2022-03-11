Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3D4D63B6
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Mar 2022 15:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiCKOgP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 11 Mar 2022 09:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiCKOgO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 11 Mar 2022 09:36:14 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF221C8D8C;
        Fri, 11 Mar 2022 06:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647009311; x=1678545311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JlTOqI+h+WG8aKADoRW8mWa2X0Y8TfkTAAlyGRwmsq8=;
  b=T4S3rAaoRazPXVfIJzLbAz3g9FABFnpDs7Lh/i6xwONSt4hoXGaSu/ej
   hNxG1KyfP/8gg3R6XOVg7C/u3Q7jEvpkprtrclebugwy3BHJdC6F+Zk3E
   LPlTAa3fibdV2GSNK+PWEBMBxkTaZcxrJRVU0EeskWcJIUhcHRqxw4gyD
   JgaZuOHFYIgeGqXPzYTBUMRTOyKRTZso/DxpGfA9gidCzbrxm7xueVSCZ
   Lfnx9U1kU858t784RaNlZsAwsa/G9oY7d4zW9iKowOmdwjpsbUqOx3xUp
   68tFFlmfv/XPYCTe/wMUAqibp2qCXieUb+YWHH+9CKZ/eBkCmvO73H+kQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255769996"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="255769996"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 06:35:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="514519517"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga006.jf.intel.com with ESMTP; 11 Mar 2022 06:35:08 -0800
Date:   Fri, 11 Mar 2022 22:28:14 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] fpga: zynqmp: Initialized variables before using it
Message-ID: <20220311142814.GA97487@yilunxu-OptiPlex-7050>
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
 <20220308094519.1816649-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308094519.1816649-3-nava.manne@xilinx.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Mar 08, 2022 at 03:15:15PM +0530, Nava kishore Manne wrote:
> This patch initialized variables with the proper value.
> Addresses-Coverity: "uninit_use: Using uninitialized value"
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/zynqmp-fpga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index c60f20949c47..e931d69819a7 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -41,7 +41,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
>  				 const char *buf, size_t size)
>  {
>  	struct zynqmp_fpga_priv *priv;
> -	dma_addr_t dma_addr;
> +	dma_addr_t dma_addr = 0;

The first use of this variable is as an output parameter:

	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);

So I don't think it needs to be initialized as 0.

Thanks,
Yilun

>  	u32 eemi_flags = 0;
>  	char *kbuf;
>  	int ret;
> -- 
> 2.25.1

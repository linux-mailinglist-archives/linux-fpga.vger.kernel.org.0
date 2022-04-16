Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595765037A4
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 18:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiDPQ5f (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 12:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiDPQ5e (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 12:57:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B61D0DD;
        Sat, 16 Apr 2022 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650128101; x=1681664101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YmPk/I4BaAwjhGm7zGUIvQ+YLO5l4e35OMj+a0vLnZM=;
  b=SBkphYbR+VL5iRKIF8xab+zf+7NlTAcjv+jHcbJoPWuhkaioMPn10m+6
   30H/tDJREw7yny+r5BGiNfvVyi7b+puRB02JeBszW2z8FRNp6b5e+K4ln
   h57aZzaXhwcNfHhNZnqmpgM96Mkrtn6v1eaA5zUcfCQYRwr9ylAH8Gbm6
   jyq7FjcC6hVQtjaQ9ZlarK/FJljAw8C5LOxGVWt1B+vZFDl228BWVpoSI
   o8Rmhk8nAZsiyYqBmBSI39JELflyR7mfkoejRCyMekUpmPhRHxqVHAKey
   oNiQGJNW8Stp731qNtX3OmTfwyYB1giVHRhcwRGJn9GmNPcpQroAFCD05
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263481141"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="263481141"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 09:55:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="701369214"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 09:54:56 -0700
Date:   Sun, 17 Apr 2022 00:47:25 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v4 4/5] fpga: Use tab instead of space indentation
Message-ID: <20220416164725.GF301222@yilunxu-OptiPlex-7050>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
 <20220416133719.3382895-5-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416133719.3382895-5-nava.manne@xilinx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Apr 16, 2022 at 07:07:18PM +0530, Nava kishore Manne wrote:
> In FPGA Make file has both space and tab indentation to

          Makefile                         indentation, to

> make them align use tab instead of space indentation.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>

With the minor fixes, please add my Acked-by

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
> Changes for v2:
>                 -None.
> Changes for v3:
>                 -Updated commit description.
> Changes for v4:
>                 -None.
> 
>  drivers/fpga/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 0bff783d1b61..5935b3d0abd5 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -18,9 +18,9 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> -obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
> -obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
> -obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
> +obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
> +obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
> +obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
>  
>  # FPGA Bridge Drivers
>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
> -- 
> 2.25.1

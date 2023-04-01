Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF796D3134
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Apr 2023 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjDAOEm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 1 Apr 2023 10:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDAOEl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 1 Apr 2023 10:04:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44C1B76D;
        Sat,  1 Apr 2023 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680357862; x=1711893862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rN2te+wjttVhFgSe9IzLsk8u67wrPaGxd4Fr7MnntQc=;
  b=ZXOB5fDaYg9xYUBkGylcJvefvd7HE28Fmit/iHwwWfh0BDcWebbhUN8X
   Oy9paHFfF2Pd2I9CDLe4ryjkR8yIhDKT+VCPxuzech+n9L+lsp7KloWF9
   fN6kzCUlOZ5lIR3EH4MX8rjaDSlS5f7Z2b0Y+ZhxPir0ws0IW06h93MI7
   c9/YEEOuqI0iaMdE9c09T/BkQHUzk4dfuQTpFx6JeIC2BPeLKo8hsHyE/
   S5yAZUmgBI8zUxtosb0ZLkHkXG0ovDW0D5v/j8KpDHpDO9DSvt+SOLej3
   rnjtfV1GHckgSk7jRyX7K9lcAxMRLx0UoGHyRGzTBM5UEePq/lsof8ZpW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="322045496"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="322045496"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 07:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="715761416"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="715761416"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2023 07:04:20 -0700
Date:   Sat, 1 Apr 2023 21:52:45 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: select FPGA_BRIDGE for
 'Xilinx LogiCORE PR Decoupler'
Message-ID: <ZCg3LepdPRFtsAcb@yilunxu-OptiPlex-7050>
References: <20230327115103.106059-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327115103.106059-1-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-27 at 17:21:03 +0530, Nava kishore Manne wrote:
> The Xilinx LogiCORE PR Decoupler depends on the FPGA_BRIDGE always and
> hence select it explicitly to make sure that it will be available all
> the time when PR decoupler is enabled.

FPGA_BRIDGE is available all the time if XILINX_PR_DECOUPLER is selected
by user. What's the problem now?

Thanks,
Yilun

> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
>  drivers/fpga/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 0a00763b9f28..71003f256c60 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -115,8 +115,8 @@ config ALTERA_FREEZE_BRIDGE
>  
>  config XILINX_PR_DECOUPLER
>  	tristate "Xilinx LogiCORE PR Decoupler"
> -	depends on FPGA_BRIDGE
>  	depends on HAS_IOMEM
> +	select FPGA_BRIDGE
>  	help
>  	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler
>  	  or Xilinx Dynamic Function eXchange AIX Shutdown Manager.
> -- 
> 2.25.1
> 

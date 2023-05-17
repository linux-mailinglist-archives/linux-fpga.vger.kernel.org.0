Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062B7705C96
	for <lists+linux-fpga@lfdr.de>; Wed, 17 May 2023 03:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjEQBm2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 May 2023 21:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEQBm1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 May 2023 21:42:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EC52D73;
        Tue, 16 May 2023 18:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684287745; x=1715823745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dNLXGfcTk68qUW3tT7lzChzhmlwJWKez/B+xPK+1SB8=;
  b=BRJnQdWtpjZggblKtZV6IUKQCh6vbFRAXY/3k4SUf4EjSRJdW0r9vOlJ
   am7Ka2+V09zwCQfK+aa1kIcrl2iIu4L49S+X2WUCAkDMpe1mpIcaW1zEb
   VrUYCrxbwt1WkiFi9kq+U5CgWdE3gNYTENWd4bD841qWRxXovq+VKAPU7
   iijrE9jxVXyozZ9RIOOfps6keL2Q5X4unlIvjDNBosOTBFJjlyp8yxYpv
   ME7yHtvL5y9Gz5xhbvgL0Aea0Na629gxShNGmrOQB9SWk5pGUynsn0Ov4
   R2EOwdzax2ZUHcpz0AKRhbg70DlO3DO8+11txgpklfZqsono5ucmuDsO5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415045442"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="415045442"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 18:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="845895401"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="845895401"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 16 May 2023 18:42:22 -0700
Date:   Wed, 17 May 2023 17:42:17 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Wu Hao <hao.wu@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: xilinx: Switch Michal Simek's email to new one
Message-ID: <ZGSheQfInrIfeMaK@yilunxu-OptiPlex-7050>
References: <32514756730c7412018c26b0bb140647f9e9d414.1684244666.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32514756730c7412018c26b0bb140647f9e9d414.1684244666.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-16 at 15:44:30 +0200, Michal Simek wrote:
> @xilinx.com is still working but better to switch to new amd.com after
> AMD/Xilinx acquisition.

I think maybe not necessary to update the author.

BTW: Updating the maintainership is good, people tracks the info for
upstreaming process.

Thanks,
Yilun

> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  drivers/fpga/xilinx-pr-decoupler.c | 2 +-
>  drivers/fpga/zynq-fpga.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index b76d85449b8f..4d6ef2dd766e 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -184,5 +184,5 @@ module_platform_driver(xlnx_pr_decoupler_driver);
>  
>  MODULE_DESCRIPTION("Xilinx Partial Reconfiguration Decoupler");
>  MODULE_AUTHOR("Moritz Fischer <mdf@kernel.org>");
> -MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>");
> +MODULE_AUTHOR("Michal Simek <michal.simek@amd.com>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index ae0da361e6c6..730586b32c10 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -656,6 +656,6 @@ static struct platform_driver zynq_fpga_driver = {
>  module_platform_driver(zynq_fpga_driver);
>  
>  MODULE_AUTHOR("Moritz Fischer <moritz.fischer@ettus.com>");
> -MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>");
> +MODULE_AUTHOR("Michal Simek <michal.simek@amd.com>");
>  MODULE_DESCRIPTION("Xilinx Zynq FPGA Manager");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.36.1
> 

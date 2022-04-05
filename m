Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BCF4F223D
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Apr 2022 06:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiDEEta (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 Apr 2022 00:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiDEEtM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 5 Apr 2022 00:49:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B0A4D24A;
        Mon,  4 Apr 2022 21:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649133928; x=1680669928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0hqqbwNeu2yz8dmKtRKZAl3/4REEZAC489TeDYZhXgw=;
  b=nbBLOTxnKUGPMM7csjHAvNDhsfCnj8U+2AW99Fg4bOywwYQSo38AkJBf
   H0vBVn3sL1tZACk/Zbzpxl9Ip/L7gd0JOPlliv2bEowAOU2pT59HkE2LE
   nCTdz+CQGDLVgPSH2ClRV5gDx6At8KfcZ8f6GxWb+z5oMlYMwyVFR2b5A
   PwzHxHVdVI+AzqGH51au6hn923XfuBMF+dCthLZ0WcQAlvmwzuwgp7VbL
   yNq7o+qx2kPXYbRpb8DEL4A4tuz/sn7w9y3JBxwReM02fUdd69WzoXKZg
   OPVlfx+sL3jcZFSNBuLJF5GfpY2JwXtwOPSXmjWBLxyNjHDJNoiXDpBNC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="347103320"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="347103320"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 21:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="505144246"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga003.jf.intel.com with ESMTP; 04 Apr 2022 21:45:23 -0700
Date:   Tue, 5 Apr 2022 12:38:04 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v3 1/5] fpga: zynq: Fix incorrect variable type
Message-ID: <20220405043804.GA248628@yilunxu-OptiPlex-7050>
References: <20220403051641.3867610-1-nava.manne@xilinx.com>
 <20220403051641.3867610-2-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403051641.3867610-2-nava.manne@xilinx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Apr 03, 2022 at 10:46:37AM +0530, Nava kishore Manne wrote:
> zynq_fpga_has_sync () API is expecting "u8 *" but the
> formal parameter that was passed is of type "const char *".
> fixes this issue by changing the buf type to "const char *"

  Fix

> 
> This patch will also update zynq_fpga_has_sync () API description
> to align with API functionality.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
>                 -None.
> Changes for v3:
>                - Changed arg buf type to "const char *" as suggested by Tom.
> 
>  drivers/fpga/zynq-fpga.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 426aa34c6a0d..ada07eea64bc 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -235,11 +235,11 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -/* Sanity check the proposed bitstream. It must start with the sync word in
> - * the correct byte order, and be dword aligned. The input is a Xilinx .bin
> - * file with every 32 bit quantity swapped.
> +/* Sanity check the proposed bitstream. The sync word must be found in the
> + * correct byte order and it should be dword aligned. The input is a
> + * Xilinx.bin file with every 32 bit quantity swapped.

I didn't found these changes in v2, or in change logs. Please record it.

Sorry, as a foreign English user, I didn't find the necessity of the change.
The previous words are as clear as the current. Anyone could help?

And they are not for variable type fix. Please make a separate patch if
really needed.

Thanks,
Yilun

>   */
> -static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
> +static bool zynq_fpga_has_sync(const char *buf, size_t count)
>  {
>  	for (; count >= 4; buf += 4, count -= 4)
>  		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
> -- 
> 2.25.1

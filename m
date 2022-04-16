Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEDB503788
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 18:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiDPQdo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiDPQdn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 12:33:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF26E3B3E5;
        Sat, 16 Apr 2022 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650126669; x=1681662669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZYQl1xcsGRkBXqpNo+f5+Kf+37WBSRVnXdfWEXD1MKI=;
  b=RSPAlKGBBZlyFfTAzwnLyemryftyIa7hYb779vzQgaeCC+g3NwI0vFaU
   f4Ltu+1Y6MqjFKd3TvW9CUoC7y9nfUbbbigOu2gT+MFwMi1f5SgQg8w5L
   ICR/6i8d8/zpTM4+jjJjV6LIsGFmnD2alKnvc1/n+NUBGChCa29+yGu9r
   TSrxmeVtEUzHtIwYV1ZPLzUCHI6lFatX/vL7aR1y0xB++/cjhBkfYrNgP
   /uEP0d24Kwxvx5ddprjgZHHugcw4ccyb2237UUZUQfpy93kkq5iAcdXHj
   wdg/2Bo87fmbvCMQn1ncczB8BXATQ76pcB5onOVckkRCRlLVuQZSDPx+y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="263479615"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="263479615"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 09:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="574873330"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 16 Apr 2022 09:30:56 -0700
Date:   Sun, 17 Apr 2022 00:23:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v4 1/5] fpga: zynq: Fix incorrect variable type
Message-ID: <20220416162324.GD301222@yilunxu-OptiPlex-7050>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
 <20220416133719.3382895-2-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416133719.3382895-2-nava.manne@xilinx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Apr 16, 2022 at 07:07:15PM +0530, Nava kishore Manne wrote:
> zynq_fpga_has_sync () API is expecting "u8 *" but the
> formal parameter that was passed is of type "const char *".
> fixes this issue by changing the buf type to "const char *"
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
>                - update zynq_fpga_has_sync () API description to align with API
>                  functionality.
> Changes for v4:
>                - None.

There are some minor comments in v3, please check it.

Thanks,
Yilun

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
>   */
> -static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
> +static bool zynq_fpga_has_sync(const char *buf, size_t count)
>  {
>  	for (; count >= 4; buf += 4, count -= 4)
>  		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
> -- 
> 2.25.1

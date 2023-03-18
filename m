Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592796BF93D
	for <lists+linux-fpga@lfdr.de>; Sat, 18 Mar 2023 10:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCRJgu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 18 Mar 2023 05:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCRJgt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 18 Mar 2023 05:36:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED35628E4D;
        Sat, 18 Mar 2023 02:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679132207; x=1710668207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r0W9UKYuprj10+p5+Yv27m3EgFQcBynBmiZ7jx3w76s=;
  b=HpRJ7YlAdJn8b7wTIhYckiiPmI/HeflqOKLNQGckDmb2lxBvGwNwWsS0
   KgpLI6hLOoT5zLS1ZeE44rvYE01NGADB3EJV973CiZk7p9uV9Z8Yv8eba
   ajPKkgfqm28qZD7Wf+Wh3HySJhnmilBYSzzzrzryaSvjf+uV2k7N4C74k
   tnuysUQUhwUCo+0CPP8OcssEbjfPtaOJF1mqn6TB9poQHryZRQhdX/UZ6
   QmispIJOsgb/SsrB00oeIV4AZfUgLVYT2VYQhdUmbd3yqXLapMiwLuQqH
   8tLttgjARIEj8rCZIO67CsjODQJWdXO9akTuyaMZZiNAtDnr7hWK00tlf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="366129290"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="366129290"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 02:36:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="1009943224"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="1009943224"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2023 02:36:45 -0700
Date:   Sat, 18 Mar 2023 17:25:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: zynqmp: Make word align the configuration data
Message-ID: <ZBWDhAaavbrehAjh@yilunxu-OptiPlex-7050>
References: <20230314094222.66916-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314094222.66916-1-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-14 at 15:12:22 +0530, Nava kishore Manne wrote:
> To avoid unwanted copies at firmware(PMUFW) this patch provides a fix

The copy happens in firmware? Please help briefly describe the firmware
operations in commit message.

> to align programmable logic(PL) configuration data if the data is not
> word-aligned. To align the configuration data this patch adds a few
> padding bytes and these additional padding bytes will not create any
> functional impact on the PL configuration.
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
>  drivers/fpga/zynqmp-fpga.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index c60f20949c47..70a12dc6e15c 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -15,6 +15,9 @@
>  /* Constant Definitions */
>  #define IXR_FPGA_DONE_MASK	BIT(3)
>  
> +#define DUMMY_PAD_BYTE		0xFF
> +#define FPGA_WORD_SIZE		4
> +
>  /**
>   * struct zynqmp_fpga_priv - Private data structure
>   * @dev:	Device data structure
> @@ -41,18 +44,26 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
>  				 const char *buf, size_t size)
>  {
>  	struct zynqmp_fpga_priv *priv;
> +	int word_align, ret, index;
>  	dma_addr_t dma_addr;
>  	u32 eemi_flags = 0;
>  	char *kbuf;
> -	int ret;
>  
>  	priv = mgr->priv;
> +	word_align = size % FPGA_WORD_SIZE;
> +	if (word_align)
> +		word_align = FPGA_WORD_SIZE - word_align;
> +
> +	size = size + word_align;

Does the Macro ALIGN() help?

>  
>  	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
>  	if (!kbuf)
>  		return -ENOMEM;
>  
> -	memcpy(kbuf, buf, size);

This is historical, but why do the realloc & copy? Any better way?

> +	for (index = 0; index < word_align; index++)
> +		kbuf[index] = DUMMY_PAD_BYTE;
> +
> +	memcpy(&kbuf[index], buf, size - index);

Generally I object to massive copy in fpga_manager_ops::write if not
necessary. If there is an alignment requirement from HW, it should be
noticed to the caller in some way, before the buffer is created.

Thanks,
Yilun

>  
>  	wmb(); /* ensure all writes are done before initiate FW call */
>  
> -- 
> 2.25.1
> 

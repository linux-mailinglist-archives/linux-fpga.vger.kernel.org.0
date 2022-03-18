Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E924DD855
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Mar 2022 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiCRKnX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Mar 2022 06:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiCRKnT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Mar 2022 06:43:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD738908F;
        Fri, 18 Mar 2022 03:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647600121; x=1679136121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rjzHUXKaMYelhy/grqSbP+fUOQ01mEhxIDBfY5nDm6o=;
  b=lla4JEy+ax4+u/JJ1Up8yNYW+WXM/6CqCUc/1CD3/HRFftTqG+nxiN0d
   dhYRBXyqj+iYZ8Goh/p4S667nVp4Ahz+casi/h+5II/b3BZWN/QQHMI09
   IH5hUhkHZ7fSA3881cT0PdHvpZq+pRsqUZw69H3YkiKcy6H/PJSppsAhV
   TUpJho1IkI4N+jII3p69h3COQofypPZG6UVLVgfU1DnkQxLOX5v5EPmGe
   1D49PslfcuFot6u+58yhLZkmJR+N7TIsmKa605VhvbMZKbiqSQZ0YcPz2
   4A0yLeel/RvXIzJ7SBs3xfFitLtBmcHj2Z2Hi4JUbOxg510kI4hn3p4Ay
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237057339"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="237057339"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 03:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558370689"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2022 03:41:58 -0700
Date:   Fri, 18 Mar 2022 18:34:57 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     cgel.zte@gmail.com
Cc:     hao.wu@intel.com, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] fpga: dfl: pci: Remove useless DMA-32 fallback
 configuration
Message-ID: <20220318103457.GA139589@yilunxu-OptiPlex-7050>
References: <20220318005938.2142028-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318005938.2142028-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Mar 18, 2022 at 12:59:38AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.

The code change is good to me, but maybe the commit message could be
improved. The reference [1] is not the best to make things clear, maybe
[2] could be better undstood. It is even better if there is a brief
introduction of the DMA API change in the commit message. It saves a lot
of time for reviewers.

I see there are plenty of similar places to change, could you make a
patchset and change them in a batch?

[2]: https://lists.linuxfoundation.org/pipermail/iommu/2019-February/033674.html

Thanks,
Yilun

> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/fpga/dfl-pci.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 717ac9715970..42fdfa7a28d6 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -356,8 +356,6 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
>  	pci_set_master(pcidev);
>  
>  	ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64));
> -	if (ret)
> -		ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
>  	if (ret) {
>  		dev_err(&pcidev->dev, "No suitable DMA support available.\n");
>  		goto disable_error_report_exit;
> -- 
> 2.25.1

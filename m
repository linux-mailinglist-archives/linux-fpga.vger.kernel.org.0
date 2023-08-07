Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8010A771E08
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Aug 2023 12:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjHGK1O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Aug 2023 06:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjHGK1M (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Aug 2023 06:27:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E571410FA
        for <linux-fpga@vger.kernel.org>; Mon,  7 Aug 2023 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691404031; x=1722940031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JA5Bwg1V7A+LvA2KLTj1Q+Hf/kWCs6uXBYuOCOt/54w=;
  b=NSpFl1drm+U8EVCF85JmU8Bf1R7aEJwmJQHmFk6zwS8eZuAoHuiVOXAR
   3MRWr9KhT6yQ67yTJPsxTh+mJsu6NqNs8sz26OXEQGu8ok8TvAjquupzN
   Ei7O2AniR4JFBSmIzS++MxPkaZ2EHLx4xkOusrNIrJuAWUxirN/d3Fo3c
   IlHGwTxXFZfSzFQ0yLjA3aMH1xY6kXS+ellVbUjIqC/NCBdg+xi8YlZ4b
   CiZEdLBMMIljVZ11d+apdYhJKeSFEerjLGbgEJtUiTkDRTvr9iMxwUF6U
   2Yx7tqTNaDvBq6Hcizfm3Z6tmy+8miJziH1WrSKgESTqeNuzdZwB0X0/1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="367967949"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="367967949"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 03:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="680751663"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="680751663"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 07 Aug 2023 03:27:09 -0700
Date:   Mon, 7 Aug 2023 18:25:02 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        liwei391@huawei.com, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl-pci: Use pci_find_vsec_capability() to
 simplify the code
Message-ID: <ZNDGfgLX3u4Yrs3k@yilunxu-OptiPlex-7050>
References: <20230802080726.178194-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802080726.178194-1-wangxiongfeng2@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-08-02 at 16:07:26 +0800, Xiongfeng Wang wrote:
> PCI core add pci_find_vsec_capability() to query VSEC. We can use that
> core API to simplify the code.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

Thanks.

> ---
>  drivers/fpga/dfl-pci.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 1bc04378118c..98b8fd16183e 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -156,19 +156,12 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
>  
>  static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
>  {
> -	u32 bir, offset, vndr_hdr, dfl_cnt, dfl_res;
> -	int dfl_res_off, i, bars, voff = 0;
> +	u32 bir, offset, dfl_cnt, dfl_res;
> +	int dfl_res_off, i, bars, voff;
>  	resource_size_t start, len;
>  
> -	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
> -		vndr_hdr = 0;
> -		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
> -
> -		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS &&
> -		    pcidev->vendor == PCI_VENDOR_ID_INTEL)
> -			break;
> -	}
> -
> +	voff = pci_find_vsec_capability(pcidev, PCI_VENDOR_ID_INTEL,
> +					PCI_VSEC_ID_INTEL_DFLS);
>  	if (!voff) {
>  		dev_dbg(&pcidev->dev, "%s no DFL VSEC found\n", __func__);
>  		return -ENODEV;
> -- 
> 2.20.1
> 

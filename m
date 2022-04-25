Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ABB50DB2C
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Apr 2022 10:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiDYIa5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 04:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiDYIaz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 04:30:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA241D0FB
        for <linux-fpga@vger.kernel.org>; Mon, 25 Apr 2022 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650875270; x=1682411270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NE84QOXZy1e5nGVv6CztebdOwty/RqjHdmaJZOueXbw=;
  b=aZKtBOwM0/8p+XEdMn0bJUEXgf2aoe6YlJKBohfUW4zQKqpSuTH4X5jR
   HweW6mchlx8122GWZKuXoM/cjJLezDenuFPtJvT3b1qlls19vfAcSSdyi
   qZecXWHbsKuXr3GW2sgRuYP66S937DmxBPX84Iw8C0Y/qQNtPy4ZayAZE
   08ouY7vYi2ahhqAKQHwhbdWS8RgRznHVRoWL0Y17vgiqXnE3CAdJzP50P
   5zOV8xqpEDCZWfxZAXRYWaJNWdHCXyxiZyYXPIbS2bvHhaD8U8BLNNmUp
   EHjJElGQqyKRy1jqq2j3wEqBsEovS46BYhXCNi2umhhNwL45py8Jye/bA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="265348314"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="265348314"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 01:27:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="557615456"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga007.jf.intel.com with ESMTP; 25 Apr 2022 01:27:48 -0700
Date:   Mon, 25 Apr 2022 16:20:06 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v2] fpga: dfl: Allow Port to be linked to FME's DFL
Message-ID: <20220425082006.GD363795@yilunxu-OptiPlex-7050>
References: <20220419075224.430824-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419075224.430824-1-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Apr 19, 2022 at 03:52:24AM -0400, Tianfei Zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are not
> connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack device),
> PORT DFLs are connected to FME DFL directly, so we don't need to search
> PORT DFLs via PORTn_OFFSET again. If BAR value of PORTn_OFFSET is 0x7
> (FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL for that
> port. If BAR value is invalid, return -EINVAL.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
> v2: return -EINVAL if bar number invalid.
> ---
>  drivers/fpga/dfl-pci.c | 11 +++++++++++
>  drivers/fpga/dfl.h     |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 86ed9e4223d3..5bd6ef231ccc 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -263,6 +263,17 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>  			 */
>  			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>  			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> +			if (bar == FME_PORT_OFST_BAR_SKIP) {
> +				dev_dbg(&pcidev->dev, "skipping search DFL for port %d on BAR %d\n",
> +					i, bar);

I suggest we remove the dev_dbg, it's a normal case in DFL walking.

> +				continue;
> +			} else if (bar >= PCI_STD_NUM_BARS) {
> +				dev_err(&pcidev->dev, "bad BAR %d for port %d\n",
> +					bar, i);
> +				ret = -EINVAL;
> +				break;

The code is workable, but I suggest we use goto instead of break for
error out.

Thanks,
Yilun

> +			}
> +
>  			start = pci_resource_start(pcidev, bar) + offset;
>  			len = pci_resource_len(pcidev, bar) - offset;
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 53572c7aced0..e0f0abfbeb8c 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -91,6 +91,7 @@
>  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
>  #define FME_HDR_BITSTREAM_ID	0x60
>  #define FME_HDR_BITSTREAM_MD	0x68
> +#define FME_PORT_OFST_BAR_SKIP	7
>  
>  /* FME Fab Capability Register Bitfield */
>  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric version ID */
> -- 
> 2.26.2

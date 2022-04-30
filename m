Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF4515E25
	for <lists+linux-fpga@lfdr.de>; Sat, 30 Apr 2022 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbiD3OXN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 30 Apr 2022 10:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345418AbiD3OXN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 30 Apr 2022 10:23:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E04081491
        for <linux-fpga@vger.kernel.org>; Sat, 30 Apr 2022 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651328391; x=1682864391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DQaLcjYD3Zg/tr6eMKl+d0SYYmSJaOyqx95U294QemE=;
  b=IU68K+LYK/rbelv9HxWQX6Acniw0IlcCXUGTk8TrucLLDcJY7/AQSO9f
   n1y5i+XgSvu5ZOcJ2yA7lflFAsGukcPsX/2bsbc8vGoznonAuoEwVC2dv
   GamaXDdvogdAFqf1jkF924lNhnzXqcQduQMUMKtOPjnryMJnHG/AWQ1Pl
   0q8xOeFMIms/gSBChUFD/GRy5MxGJ0gpfs/5PcsZ3cspOBozGBLNn2OaM
   SVRtG9eyDNXbO6xh8GVubIk4kNDLDjZHXqBbK+bpe91ZjRh5nvzzy0MHA
   pqLuEehsGKqyWRKaRNviAnJCMcdqspCE8TNN4/CI8+xBfyDbY83Vo+wFR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="246800713"
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="246800713"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 07:19:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,188,1647327600"; 
   d="scan'208";a="582780627"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 30 Apr 2022 07:19:48 -0700
Date:   Sat, 30 Apr 2022 22:12:01 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v4] fpga: dfl: Allow Port to be linked to FME's DFL
Message-ID: <20220430141201.GA398931@yilunxu-OptiPlex-7050>
References: <20220427131656.588822-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427131656.588822-1-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Apr 27, 2022 at 09:16:56AM -0400, Tianfei Zhang wrote:
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

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
> v4: move the location of FME_PORT_OFST_BAR_SKIP definition.
> v3: remove dev_dbg and use goto instead of break.
> v2: return -EINVAL if bar number invalid.
> ---
>  drivers/fpga/dfl-pci.c | 10 ++++++++++
>  drivers/fpga/dfl.h     |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 86ed9e4223d3..dac45f96c326 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -263,6 +263,15 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>  			 */
>  			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>  			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> +			if (bar == FME_PORT_OFST_BAR_SKIP) {
> +				continue;
> +			} else if (bar >= PCI_STD_NUM_BARS) {
> +				dev_err(&pcidev->dev, "bad BAR %d for port %d\n",
> +					bar, i);
> +				ret = -EINVAL;
> +				goto unmap_exit;
> +			}
> +
>  			start = pci_resource_start(pcidev, bar) + offset;
>  			len = pci_resource_len(pcidev, bar) - offset;
>  
> @@ -277,6 +286,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>  		ret = -ENODEV;
>  	}
>  
> +unmap_exit:
>  	/* release I/O mappings for next step enumeration */
>  	pcim_iounmap_regions(pcidev, BIT(0));
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 53572c7aced0..06cfcd5e84bb 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -89,6 +89,7 @@
>  #define FME_HDR_NEXT_AFU	NEXT_AFU
>  #define FME_HDR_CAP		0x30
>  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> +#define FME_PORT_OFST_BAR_SKIP	7
>  #define FME_HDR_BITSTREAM_ID	0x60
>  #define FME_HDR_BITSTREAM_MD	0x68
>  
> -- 
> 2.26.2

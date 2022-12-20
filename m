Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8146D652509
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Dec 2022 17:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiLTQzJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Dec 2022 11:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTQzI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 20 Dec 2022 11:55:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5B81C126;
        Tue, 20 Dec 2022 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671555307; x=1703091307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=R6K/H5pO31FhA0um2GXBaKaif6nripCQw9ffL3vSoM0=;
  b=km7YHAzItsrZtUojWX0MH/LFVHiymSOSTwnnjFZy8OoX82oEJQJm50GN
   aIUXBROQhVpPlRWfbRT9CrE/FrQmJDEaeCNfbmErg5H5evMgyaw1WrPFA
   Dp5jCBwtjlhRBPw7rUe8EiNj7IVnuagMGLLzdDvzLCNkwvEnS1dyQuwaO
   x+LQ6TmeKQz3JydNpjnT0P4hLFqisH+5fsZkLtLOi9yRKj6tMzRk8xSlZ
   rKIfmF8Wn8+5bcRM6yvbvButz1s6iQHA/D0jYU40nGzV3XoYpeUAIS7/A
   xCmnx8rrewNsiHm2keJxAauFvpTDSANfBK/hSVdexM4rssbCGTCLDZ3i0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="319712525"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="319712525"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 08:54:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="653179514"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="653179514"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 20 Dec 2022 08:54:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7fsz-00D0rs-2Q;
        Tue, 20 Dec 2022 18:54:37 +0200
Date:   Tue, 20 Dec 2022 18:54:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v7 2/4] fpga: dfl: Add DFHv1 Register Definitions
Message-ID: <Y6HozWmkwElC8pUc@smile.fi.intel.com>
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com>
 <20221220163652.499831-3-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221220163652.499831-3-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Dec 20, 2022 at 08:36:50AM -0800, matthew.gerlach@linux.intel.com wrote:
> From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> 
> This patch adds the definitions for DFHv1 header and related register
> bitfields.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> v7: no change
> 
> v6: remove parameter definitions from include/linux/dfl.h
> 
> v5: consistently use fields for parameter data
>     s/EOL/EOP/ to match doc
>     remove unneeded mask
>     added Co-developed-by
> 
> v4: s/MSIX/MSI_X/g
>     move kerneldoc to implementation
>     don't change copyright date
> 
> v3:
>     keep DFHv1 definitions "hidden" in drivers/fpga/dfl.h
> 
> v2: clean up white space and one line comments
>     remove extra space in commit
>     use uniform number of digits in constants
>     don't change copyright date because of removed content
> ---
>  drivers/fpga/dfl.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 06cfcd5e84bb..fc59f33367ee 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -74,11 +74,43 @@
>  #define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
>  #define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
>  #define DFH_EOL			BIT_ULL(40)		/* End of list */
> +#define DFH_VERSION		GENMASK_ULL(59, 52)	/* DFH version */
>  #define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
>  #define DFH_TYPE_AFU		1
>  #define DFH_TYPE_PRIVATE	3
>  #define DFH_TYPE_FIU		4
>  
> +/*
> + * DFHv1 Register Offset definitons
> + * In DHFv1, DFH + GUID + CSR_START + CSR_SIZE_GROUP + PARAM_HDR + PARAM_DATA
> + * as common header registers
> + */
> +#define DFHv1_CSR_ADDR		0x18  /* CSR Register start address */
> +#define DFHv1_CSR_SIZE_GRP	0x20  /* Size of Reg Block and Group/tag */
> +#define DFHv1_PARAM_HDR		0x28  /* Optional First Param header */
> +
> +/*
> + * CSR Rel Bit, 1'b0 = relative (offset from feature DFH start),
> + * 1'b1 = absolute (ARM or other non-PCIe use)
> + */
> +#define DFHv1_CSR_ADDR_REL	BIT_ULL(0)
> +
> +/* CSR Header Register Bit Definitions */
> +#define DFHv1_CSR_ADDR_MASK       GENMASK_ULL(63, 1)  /* 63:1 of CSR address */
> +
> +/* CSR SIZE Goup Register Bit Definitions */
> +#define DFHv1_CSR_SIZE_GRP_INSTANCE_ID	GENMASK_ULL(15, 0)	/* Enumeration instantiated IP */
> +#define DFHv1_CSR_SIZE_GRP_GROUPING_ID	GENMASK_ULL(30, 16)	/* Group Features/interfaces */
> +#define DFHv1_CSR_SIZE_GRP_HAS_PARAMS	BIT_ULL(31)		/* Presence of Parameters */
> +#define DFHv1_CSR_SIZE_GRP_SIZE		GENMASK_ULL(63, 32)	/* Size of CSR Block in bytes */
> +
> +/* PARAM Header Register Bit Definitions */
> +#define DFHv1_PARAM_HDR_ID		GENMASK_ULL(15, 0) /* Id of this Param  */
> +#define DFHv1_PARAM_HDR_VER		GENMASK_ULL(31, 16) /* Version Param */
> +#define DFHv1_PARAM_HDR_NEXT_OFFSET	GENMASK_ULL(63, 35) /* Offset of next Param */
> +#define DFHv1_PARAM_HDR_NEXT_EOP	BIT_ULL(32)
> +#define DFHv1_PARAM_DATA		0x08  /* Offset of Param data from Param header */
> +
>  /* Next AFU Register Bitfield */
>  #define NEXT_AFU_NEXT_DFH_OFST	GENMASK_ULL(23, 0)	/* Offset to next AFU */
>  
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko



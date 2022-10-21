Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EFF6071B4
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Oct 2022 10:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJUIGS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 21 Oct 2022 04:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJUIGQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 21 Oct 2022 04:06:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5133E249884;
        Fri, 21 Oct 2022 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666339575; x=1697875575;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LrCEQpcLNEI0YFE1k8Q6HnH866BTswZ72JmMZMcO21g=;
  b=TON6GNZ4cHA8oyx1+/QXMDYe6F/wKM8ScDTvThRHcyKsVuv6M2/dgDZZ
   sk18QUORzRrppvGehP/pQkkWAmAdXp9TZnqrNNs1VUzOAHsSAFIQvi6PG
   P2jP9TGwxah3XL7EgrhzUcZ9WMSX6/76AqHf0Xbf3rJBe2NrdDxeFn+WU
   U0hfm+m4Cgtz/CJam6Z5c29dELaxFmhLJpRMY6tOuIJx2o0ItOEmUcnyh
   uTbWvy3pNryF6CDiwPQyNYT4mvmeJDzzPTPsg+0bPBzk9ZNF/vbmjQN36
   /af7uftG7J/PteY3lzRtPDHPjfD2BKZCCefHvzcnqKca8ruH0ar14NL9C
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="304559154"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="304559154"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:06:14 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="608236633"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="608236633"
Received: from lramir2-mobl1.ger.corp.intel.com ([10.252.44.179])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:06:08 -0700
Date:   Fri, 21 Oct 2022 11:06:02 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, geert+renesas@glider.be,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, Lukas Wunner <lukas@wunner.de>,
        marpagan@redhat.com,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v4 2/4] fpga: dfl: Add DFHv1 Register Definitions
In-Reply-To: <20221020212610.697729-3-matthew.gerlach@linux.intel.com>
Message-ID: <4d609218-508f-6025-e99-71aac2b01369@linux.intel.com>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com> <20221020212610.697729-3-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 20 Oct 2022, matthew.gerlach@linux.intel.com wrote:

> From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> 
> This patch adds the definitions for DFHv1 header and related register
> bitfields.
> 
> Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v4: s/MSIX/MSI_X/g
>     move kerneldoc to implementation
>     don't change copyright date
> 
> v3:
>     keep DFHv1 definitions "hidden" in drivers/fpga/dfl.h
> 
> v2: clean up whitespace and one line comments
>     remove extra space in commit
>     use uniform number of digits in constants
>     don't change copyright date because of removed content
> 
> dfl.h s/MSIX/MSI_X/g move kerneldoc
> ---
>  drivers/fpga/dfl.h  | 33 +++++++++++++++++++++++++++++++++
>  include/linux/dfl.h | 11 +++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 06cfcd5e84bb..45e6e1359a67 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -74,11 +74,44 @@
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

SIZE -> SZ would remove two letters w/o loss of info (remember to 
rename the offset too if you make this change).

> +/* PARAM Header Register Bit Definitions */
> +#define DFHv1_PARAM_HDR_ID		GENMASK_ULL(15, 0) /* Id of this Param  */
> +#define DFHv1_PARAM_HDR_VERSION		GENMASK_ULL(31, 16) /* Version Param */
> +#define DFHv1_PARAM_HDR_NEXT_OFFSET	GENMASK_ULL(63, 32) /* Offset of next Param */
> +#define DFHv1_PARAM_HDR_NEXT_EOL	BIT_ULL(0)
> +#define DFHv1_PARAM_HDR_NEXT_MASK	GENMASK_ULL(1, 0)
> +#define DFHv1_PARAM_DATA		0x08  /* Offset of Param data from Param header */
> +
>  /* Next AFU Register Bitfield */
>  #define NEXT_AFU_NEXT_DFH_OFST	GENMASK_ULL(23, 0)	/* Offset to next AFU */
>  
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 431636a0dc78..fea9e16d35b6 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -11,6 +11,17 @@
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  
> +#define DFHv1_PARAM_ID_MSI_X		0x1
> +#define DFHv1_PARAM_MSI_X_STARTV	0x0
> +#define DFHv1_PARAM_MSI_X_NUMV		0x4
> +
> +#define DFHv1_PARAM_ID_CLK_FRQ    0x2
> +#define DFHv1_PARAM_ID_FIFO_LEN   0x3
> +
> +#define DFHv1_PARAM_ID_REG_LAYOUT 0x4
> +#define DFHv1_PARAM_ID_REG_WIDTH  GENMASK_ULL(63, 32)
> +#define DFHv1_PARAM_ID_REG_SHIFT  GENMASK_ULL(31, 0)

Any particular reason why MSI_X parameters are given as offsets and 
these REG_LAYOUT ones as bitfields (both are 32-bit)?

The naming here would indicate that DFHv1_PARAM_ID_REG_WIDTH is one of the 
parameters but it's part of param data instead. I suppose you'd want 
DFHv1_PARAM_REG_LAYOUT_WIDTH instead.

-- 
 i.


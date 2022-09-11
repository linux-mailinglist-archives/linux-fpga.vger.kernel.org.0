Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFDF5B4CA8
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Sep 2022 10:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiIKIhY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Sep 2022 04:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIKIhX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Sep 2022 04:37:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5882D30560;
        Sun, 11 Sep 2022 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662885442; x=1694421442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uMf3K04xeQCNkmkTP8NTLrU3WiyufBIe+F2AtJ43V04=;
  b=VA/L7JBYE6UHEYhLhpxlsbLJM2EmHykYKN7HnqUYpZR6e/qTnWVRlUDI
   EGpygAlcSvOfuG72S3/mU3to9IFLeUne2asCzy77YiQCSyMya/JAhwlzV
   fvY0ew/wmdgWopPk859UZEgG0sVPAy2NukGbxets8MV9yC9Y4q+tN5jBc
   6n2v3IfYR79ImljLKdYsWIXJ+o3mlIJn17xWp2lv5xUKg810hTnrjeP2t
   +8SNH3ahAY7ifGMTMcvmUVlD7ZQUrlnBsquXwV9aDBKmq7dHAI5iLHTsq
   EwqXkrJ6AfAsjOkgOLXhV05slnrK+UVd8k2DTKT5uaa6OSYYEUOptjbRO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="280725885"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="280725885"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 01:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="566841440"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2022 01:37:16 -0700
Date:   Sun, 11 Sep 2022 16:27:45 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v1 3/5] fpga: dfl: Add DFHv1 Register Definitions
Message-ID: <Yx2cAaQ0HhPkYyC4@yilunxu-OptiPlex-7050>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906190426.3139760-4-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-06 at 12:04:24 -0700, matthew.gerlach@linux.intel.com wrote:
> From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> 
> This patch adds the definitions for DFHv1 header and related register
> bitfields.
> 
> Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  include/linux/dfl.h | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index b5accdcfa368..61bcf20c1bc8 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -23,6 +23,16 @@
>  #define GUID_H			0x10
>  #define NEXT_AFU		0x18
>  
> +/*
> + * DFHv1 Register Offset definitons
> + * In DHFv1, DFH + GUID + CSR_START + CSR_SIZE_GROUP + PARAM_HDR + PARAM_DATA
> + * as common header registers
> + */
> +#define DFHv1_CSR_ADDR		0x18  /* CSR Register start address */
> +#define DFHv1_CSR_SIZE_GRP	0x20  /* Size of Reg Block and Group/tag */
> +#define DFHv1_PARAM_HDR		0x28  /* Optional First Param header */
> +#define DFHv1_PARAM_DATA	0x8   /* Offset of Param data from Param header */
> +
>  #define DFH_SIZE		0x8
>  
>  /* Device Feature Header Register Bitfield */
> @@ -30,8 +40,35 @@
>  #define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
>  #define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
>  #define DFH_EOL			BIT_ULL(40)		/* End of list */
> +#define DFH_VERSION		GENMASK_ULL(59, 52)	/* DFH version */
>  #define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
>  
> +/*
> + *  CSR Rel Bit, 1'b0 = relative (offset from feature DFH start),

Reduce one whitespace indent.

> + * 1'b1 = absolute (ARM or other non-PCIe use)
> + */
> +#define DFHv1_CSR_ADDR_REL	BIT_ULL(0)
> +
> +/*
> + * CSR Header Register Bit Definitions
> + */

Use oneline style comment should be OK?

> +#define DFHv1_CSR_ADDR_MASK       GENMASK_ULL(63, 1)  /* 63:1 of CSR address */
> +
> +/*
> + * CSR SIZE Goup Register Bit Definitions
> + */

Same concern

> +#define DFHv1_CSR_SIZE_GRP_INSTANCE_ID	GENMASK_ULL(15, 0)	/* Enumeration instantiated IP */
> +#define DFHv1_CSR_SIZE_GRP_GROUPING_ID	GENMASK_ULL(30, 16)	/* Group Features/interfaces */
> +#define DFHv1_CSR_SIZE_GRP_HAS_PARAMS	BIT_ULL(31)		/* Presence of Parameters */
> +#define DFHv1_CSR_SIZE_GRP_SIZE		GENMASK_ULL(63, 32)	/* Size of CSR Block in bytes */
> +
> +/*
> + * PARAM Header Register Bit Definitions
> + */

Same

> +#define DFHv1_PARAM_HDR_ID		GENMASK_ULL(15, 0) /* Id of this Param  */
> +#define DFHv1_PARAM_HDR_VERSION		GENMASK_ULL(31, 16) /* Version Param */
> +#define DFHv1_PARAM_HDR_NEXT_OFFSET	GENMASK_ULL(63, 32) /* Offset of next Param */
> +
>  /**
>   * enum dfl_id_type - define the DFL FIU types
>   */
> -- 
> 2.25.1
> 

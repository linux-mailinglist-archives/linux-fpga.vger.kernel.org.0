Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB12607327
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Oct 2022 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiJUI6y (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 21 Oct 2022 04:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiJUI6j (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 21 Oct 2022 04:58:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682BD2514CD;
        Fri, 21 Oct 2022 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666342717; x=1697878717;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MFsSrj3k9MJQ1OZ5lW1BWstRBTlDnFaSJtvAoGYuQ5w=;
  b=S4MlOm+f6brUzutaM9+SxCRtmzbyuEJA5AizMbf5QZ8CX+qjD5jQMSk2
   yjBRQZQF2KAyHd5hBhB4so7mls5Q3pbQXjW54vyFvJ9/6HYs8CpzlFlG+
   XXURwi2iyzERDQrlKnoNxGUdG93hgu3XPP4x/qygR/12mn9vDmyEQsXL7
   XHV5o35bHyC6r4Xd1w9Xh10CZY7LVx7tQK9vvpvG2VmzPjsAmcWTKUnWe
   6l9UJcNlPcYrWRcbD1b1chyllryM4W5nLtYw9bjAM2LI6ubUkcKRDvEYB
   ksIfvzQr189vHWo8nRhgER1nkQbGJ38H8eSd7wBW9VTa+OLK4D6qdhgF8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="371167243"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="371167243"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:58:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="755697464"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="755697464"
Received: from lramir2-mobl1.ger.corp.intel.com ([10.252.44.179])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:58:17 -0700
Date:   Fri, 21 Oct 2022 11:58:14 +0300 (EEST)
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
        marpagan@redhat.com
Subject: Re: [PATCH v4 3/4] fpga: dfl: add basic support DFHv1
In-Reply-To: <20221020212610.697729-4-matthew.gerlach@linux.intel.com>
Message-ID: <97f6047-e364-8ae7-195c-4cf33c4b3ec7@linux.intel.com>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com> <20221020212610.697729-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 20 Oct 2022, matthew.gerlach@linux.intel.com wrote:

> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add generic support for MSI-X interrupts for DFL devices.
> 
> The location of a feature's registers is explicitly
> described in DFHv1 and can be relative to the base of the DFHv1
> or an absolute address.  Parse the location and pass the information
> to DFL driver.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v4: s/MSIX/MSI_X
>     move kernel doc to implementation
>     use structure assignment
>     fix decode of absolute address
>     clean up comment in parse_feature_irqs
>     remove use of csr_res
> 
> v3: remove unneeded blank line
>     use clearer variable name
>     pass finfo into parse_feature_irqs()
>     refactor code for better indentation
>     use switch statement for irq parsing
>     squash in code parsing register location
> 
> v2: fix kernel doc
>     clarify use of DFH_VERSION field
> ---

> +static int dfh_get_psize(void __iomem *dfh_base, resource_size_t max)
> +{
> +	int size = 0;
> +	u64 v, next;
> +
> +	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS,
> +		       readq(dfh_base + DFHv1_CSR_SIZE_GRP)))
> +		return 0;
> +
> +	while (size + DFHv1_PARAM_HDR < max) {
> +		v = readq(dfh_base + DFHv1_PARAM_HDR + size);
> +
> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> +		if (!(next & ~DFHv1_PARAM_HDR_NEXT_MASK))

In general, try to not use inverse logic for defining masks. However here, 
just change DFHv1_PARAM_HDR_NEXT_OFFSET to not include any extra bits 
(no rsvd nor eop) and you no longer need this extra masking.

> +			return -EINVAL;
> +
> +		size += next & ~DFHv1_PARAM_HDR_NEXT_MASK;

...Then you can drop this anding too.

> +
> +		if (next & DFHv1_PARAM_HDR_NEXT_EOL)

Your docs say EOP, but here you use EOL.

Change DFHv1_PARAM_HDR_NEXT_EOL such that this is extracted directly from 
v.

-- 
 i.

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58F4653086
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Dec 2022 13:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiLUL6w (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Dec 2022 06:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLUL6t (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Dec 2022 06:58:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867C41DDD4;
        Wed, 21 Dec 2022 03:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671623927; x=1703159927;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vuvqp9h4DCIvi1CInAtWcyWKHnHzHhWwtOqIGpdnhoY=;
  b=E75RYedKqDRRieJhvQIPOr5pnAbugiaMkYgT7bmsXj1HbSMO0iWKeI0Q
   o2jN/RtusKuuNrhSGdAn2vgW0Ey4lobgpjfuH5ccaN0GdOA80rqBt+//9
   IQApCXnCn+6vS5OJitZImVfMxheSZftfAiE8/BdC/FnDb1yTN+iBRY7fY
   0Vz2FTjXz233D0x1a6wY8S3Huj5mEZVs42N0INWvdaqpDlqYs3nA8vUlC
   K0rYmC+SHnrMM+shKu34FKnmIeaxP/vnXW81+tl6tez4/J2IEPBaJeF5A
   6gCEFxkS5ioOxSyQQUgIZNXyl1pyPq5p6+wydcKgm0A+ys5/zWfcuI2Lq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="384201859"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="384201859"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 03:58:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="644815655"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="644815655"
Received: from bpopa-mobl.ger.corp.intel.com ([10.249.40.226])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 03:58:40 -0800
Date:   Wed, 21 Dec 2022 13:58:37 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com,
        Russ Weight <russell.h.weight@intel.com>,
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
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v7 3/4] fpga: dfl: add basic support for DFHv1
In-Reply-To: <20221220163652.499831-4-matthew.gerlach@linux.intel.com>
Message-ID: <c041442c-fb78-e1a0-c67-a5c2ee947@linux.intel.com>
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com> <20221220163652.499831-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1507487464-1671623926=:2459"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1507487464-1671623926=:2459
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 20 Dec 2022, matthew.gerlach@linux.intel.com wrote:

> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Version 1 of the Device Feature Header (DFH) definition adds
> functionality to the DFL bus.
> 
> A DFHv1 header may have one or more parameter blocks that
> further describes the HW to SW.  Add support to the DFL bus
> to parse the MSI-X parameter.
> 
> The location of a feature's register set is explicitly
> described in DFHv1 and can be relative to the base of the DFHv1
> or an absolute address.  Parse the location and pass the information
> to DFL driver.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> v7: no change
> 
> v6: move MSI_X parameter definitions to drivers/fpga/dfl.h
> 
> v5: update field names
>     fix find_param/dfh_get_psize
>     clean up mmio_res assignments
>     use u64* instead of void*
>     use FIELD_GET instead of masking
> 
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

> +static u64 *find_param(u64 *params, resource_size_t max, int param_id)
> +{
> +	u64 *end = params + max / sizeof(u64);
> +	u64 v, next;
> +
> +	while (params < end) {
> +		v = *params;
> +		if (param_id == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
> +			return params;
> +
> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> +		params += next;
> +		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
> +			break;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * dfh_find_param() - find data for the given parameter id
> + * @dfl_dev: dfl device
> + * @param: id of dfl parameter
> + *
> + * Return: pointer to parameter header on success, NULL otherwise.
> + */
> +u64 *dfh_find_param(struct dfl_device *dfl_dev, int param_id)
> +{
> +	return find_param(dfl_dev->params, dfl_dev->param_size, param_id);
> +}
> +EXPORT_SYMBOL_GPL(dfh_find_param);

BTW, should there be a way for the caller to ensure the parameter is long 
enough?

All callers probably want to ensure the length of the parameter is valid 
so it would perhaps make sense to add a parameter for the required 
(minimum) length?


-- 
 i.

--8323329-1507487464-1671623926=:2459--

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024B46596D7
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Dec 2022 10:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiL3Jdk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Dec 2022 04:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiL3Jdf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Dec 2022 04:33:35 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1B71A805;
        Fri, 30 Dec 2022 01:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672392813; x=1703928813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XdS5Dd/0uhgJq64+Z+wNIhmKRBaUrp9HvGQaq5MZXWU=;
  b=Q5INskIHEIFJbY3g0wqNExb7FG6pdNd7Gec56E9jvPUkQxTKrhdLpmXp
   LhvJrqLvfZx+uWak/JSjtMdCsyJGzeQWogqfPEAdOkzSho14GBBLaP3iv
   eaJJueDu8kG3qCBPkmDeCxeW7O6jjLmA8HRVPOC10D6/YP4BloBEJdO4D
   0Hau+1ChyhuWUGueUqtWWJV/wNvY87QV1qY9s6UoyfzZs9RKP1tg+0r7R
   Bd4+o0TqtjFPw8/CRW2F1j21eVS1X+Gg9V+qfML72xEnXXrOLwO2nshev
   jKgJmdVGl3xs/GSwKqkZjefr6sZFlg5S03vh0NbBKdHbbSzIqJlgYmhM3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="385612361"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="385612361"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 01:33:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="647262116"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="647262116"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 30 Dec 2022 01:33:27 -0800
Date:   Fri, 30 Dec 2022 17:23:19 +0800
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
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v8 3/4] fpga: dfl: add basic support for DFHv1
Message-ID: <Y66uB8/xj+YF4oEr@yilunxu-OptiPlex-7050>
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com>
 <20221228181624.1793433-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221228181624.1793433-4-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-28 at 10:16:23 -0800, matthew.gerlach@linux.intel.com wrote:
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
> v8: use struct_size() from overflow.h
>     add dfh_get_u64_param_vals()

Could you help check my comments?
https://lore.kernel.org/linux-fpga/alpine.DEB.2.22.394.2212211421210.570436@rhweight-WRK1/T/#md86e3836130ebacd3c088f5c512ba741aac8a4d1

[...]

> 
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
> + * dfh_find_param() - find parameter block for the given parameter id
> + * @dfl_dev: dfl device
> + * @param: id of dfl parameter
> + *
> + * Return: pointer to start of parameter block, NULL otherwise.
> + */
> +u64 *dfh_find_param(struct dfl_device *dfl_dev, int param_id)
> +{
> +	return find_param(dfl_dev->params, dfl_dev->param_size, param_id);
> +}
> +EXPORT_SYMBOL_GPL(dfh_find_param);

Didn't find where to use it?

> +
> +/**
> + * dfh_get_u64_param_vals() - get array of u64 param values for given parameter id

There is no rule to say one u64 for each property in the parameter block.
So I don't see the reason for DFL core to provide u64 array for the API,
And the size of the parameter block is decided by HW, why make the user
input the value?

As we discussed before, dfl core doesn't try to look into the parameter
block. So please just provide the const void *data & data_size for drivers.
This is the most common way to represent a data block.

Thanks,
Yilun

> + * @dfl_dev: dfl device
> + * @param: id of dfl parameter
> + * @pval: location of parameter data destination
> + * @nvals: number of u64 elements of parameter data
> + *
> + * Return: pointer to start of parameter block, PTR_ERR otherwise
> + */
> +u64 *dfh_get_u64_param_vals(struct dfl_device *dfl_dev, int param_id, u64 *pval, int nvals)
> +{
> +	u64 *param = find_param(dfl_dev->params, dfl_dev->param_size, param_id);
> +	u64 next;
> +	int i;
> +
> +	if (!param)
> +		return ERR_PTR(-ENOENT);
> +
> +	next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, *param);
> +
> +	if (nvals >= next)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < nvals; i++)
> +		*pval++ = param[i + 1];
> +
> +	return param;
> +}
> +EXPORT_SYMBOL_GPL(dfh_get_u64_param_vals);
> +

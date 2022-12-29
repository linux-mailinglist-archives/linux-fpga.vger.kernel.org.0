Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E38658B5C
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Dec 2022 11:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiL2J7w (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 04:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiL2J5j (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 04:57:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EED13DEC;
        Thu, 29 Dec 2022 01:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672307831; x=1703843831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SzEg0OuwipAhPLjhu/IPNR3tniKbgjURcg8IVyCKM8w=;
  b=b3d91Y7MXwHm81/d6mEpFCvWSTMjI5oX5yQ3QQGVj433RoUjC/+im1So
   P/h5xkCbbim0eHjR9XBMBT5tJKud8smwvy/MPDHq0+0q0vOrfZmK7OaIs
   jzY/RD6OHFiycJ1XB6fkhUTBBoKMNR8HcBfHHeHKlobAWm1hGw+2LRi0p
   MhGMsBhfUO0fYWPfEkHGb28LUjxi20BTudytyt/thSlT4IplximpUDHY5
   AOICS/550aNHYNmsOo74MJVqlQg3K2dqMN72gkNyU2WqJo+Bjt4WiIAE6
   vNikNtflheLuHqOaOlRNd1VagB/EWnu7HiThZ4p6TXL9UzS+TmHHwq4Se
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="318699580"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="318699580"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 01:57:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="742258811"
X-IronPort-AV: E=Sophos;i="5.96,283,1665471600"; 
   d="scan'208";a="742258811"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Dec 2022 01:57:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pApep-0015L3-2R;
        Thu, 29 Dec 2022 11:57:03 +0200
Date:   Thu, 29 Dec 2022 11:57:03 +0200
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
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v8 3/4] fpga: dfl: add basic support for DFHv1
Message-ID: <Y61kb9OGikxLvAcr@smile.fi.intel.com>
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com>
 <20221228181624.1793433-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228181624.1793433-4-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Dec 28, 2022 at 10:16:23AM -0800, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Version 1 of the Device Feature Header (DFH) definition adds
> functionality to the DFL bus.
> 
> A DFHv1 header may have one or more parameter blocks that
> further describes the HW to SW.  Add support to the DFL bus

Single space is enough.

> to parse the MSI-X parameter.
> 
> The location of a feature's register set is explicitly
> described in DFHv1 and can be relative to the base of the DFHv1
> or an absolute address.  Parse the location and pass the information
> to DFL driver.

I'm wondering what DFL states for.

...

> +/**
> + * dfh_get_u64_param_vals() - get array of u64 param values for given parameter id
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

ENODATA ?

> +	for (i = 0; i < nvals; i++)
> +		*pval++ = param[i + 1];

memcpy() ?

> +	return param;
> +}

...

> +	finfo = kzalloc(struct_size(finfo, params, dfh_psize/sizeof(u64)), GFP_KERNEL);

' / ' (mind the spaces)

Also, perhaps better to use sizeof(*params) or what is the member of that
structure. So it will be more robust against possible changes.

>  	if (!finfo)
>  		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko



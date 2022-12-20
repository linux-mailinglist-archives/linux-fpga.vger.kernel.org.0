Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD5D652521
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Dec 2022 18:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiLTRFg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Dec 2022 12:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLTRFf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 20 Dec 2022 12:05:35 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609D42C3;
        Tue, 20 Dec 2022 09:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671555934; x=1703091934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3isG2zOAi0PziSEV0If0SpVV/rOxtU3UD81BMRi9gFw=;
  b=eZjHZ8OQo61q9G+VHuhi67Q3/6Pk+GeRn6bH3Sjp1pPSIQCMi+6g/3ln
   h8CwSBewkRyePrxgB/wVdpWwHX/aSCh7qgg7DAE+IKQ23W5sh5lLYBepo
   KTcx51aZ/fRKRD731oaP01y3gwu2u1x5mAGaIYahDBUjC1buFuvSD4olb
   8eHSg0ULXe1qiexjBvAQRGcVGv4DdKuLfy4140UKpN5utqaC+l/iBglJJ
   5j1X751KeE+v9P0IjMug3PubErVco/Eiy0FqEOJ/mRUZ45b1tio6K0hZH
   iooaWlEsYZA1n5A+mNDdHL0uh2ecFjyXVbvj7TvOqlB54uh4oH5DCnOAR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="307341447"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="307341447"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 09:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="825338877"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="825338877"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 20 Dec 2022 09:03:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7g1D-00D198-0j;
        Tue, 20 Dec 2022 19:03:07 +0200
Date:   Tue, 20 Dec 2022 19:03:06 +0200
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
Subject: Re: [PATCH v7 3/4] fpga: dfl: add basic support for DFHv1
Message-ID: <Y6HqyjFkiUDeNmH1@smile.fi.intel.com>
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com>
 <20221220163652.499831-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220163652.499831-4-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Dec 20, 2022 at 08:36:51AM -0800, matthew.gerlach@linux.intel.com wrote:
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

...

> +/**
> + * dfh_find_param() - find data for the given parameter id
> + * @dfl_dev: dfl device
> + * @param: id of dfl parameter
> + *
> + * Return: pointer to parameter header on success, NULL otherwise.

header is a bit confusing here, does it mean we give and ID and we got
something more than just a data as summary above suggests?

In such case summary and this text should clarify what exactly we get
and layout of the data. Since this is a pointer, who is responsible of
checking out-of-boundary accesses? For instance, if the parameters are
variadic by length the length should be returned as well. Otherwise it
should be specified as a constant somewhere, right?

> + */
> +u64 *dfh_find_param(struct dfl_device *dfl_dev, int param_id)
> +{
> +	return find_param(dfl_dev->params, dfl_dev->param_size, param_id);
> +}
> +EXPORT_SYMBOL_GPL(dfh_find_param);

...

> +	finfo = kzalloc(sizeof(*finfo) + dfh_psize, GFP_KERNEL);

It sounds like a candidate for struct_size() from overflow.h.
I.o.w. check that header and come up with the best what can
suit your case.

>  	if (!finfo)
>  		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko



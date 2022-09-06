Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC15AF5B7
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Sep 2022 22:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiIFUTG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Sep 2022 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiIFUSr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Sep 2022 16:18:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2F4B7EC2;
        Tue,  6 Sep 2022 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662495368; x=1694031368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rTEJdLWeNY+AFkZlSJeReaA9D1yKDOK0j+qthok/Uk4=;
  b=PrSq6mkskcGdBrOhilswqesftWhqxqJjSCY7EnXWQTtCHPtoQX7nZhm2
   nPDXm+0HObNadQ4C40ZPzcdagGKt5Vkpoejt4648iyt+XC7XnX+p8HG0Q
   yhxyEsUv/DblPeXrfjTcPRh2kvhee92IE43Jp0DM22Mh4Yz/4NJGsZoXQ
   9TxHFeUy87p0yduUyWtj84w5zMuHhb/QYOsppXqTzjIlaf7PJ8Kgwe8mc
   N3K0/8Uyjt8TrkRreu3w776siMnxkXjN5OBN10TwNXM4jccksILRBQBmZ
   15lNF8B0kEUbfPHg/TPpJsuvcAvLB027SuQAoavpu4Ev4hckg3Iqf1P8E
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="298009994"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="298009994"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 13:15:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="756500327"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 13:15:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVeyU-009MNA-0C;
        Tue, 06 Sep 2022 23:15:10 +0300
Date:   Tue, 6 Sep 2022 23:15:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v1 4/5] fpga: dfl: add generic support for MSIX interrupts
Message-ID: <YxeqTdny7Nu7LzZo@smile.fi.intel.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906190426.3139760-5-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 06, 2022 at 12:04:25PM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Define and use a DFHv1 parameter to add generic support for MSIX
> interrupts for DFL devices.

...

> +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
> +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
> +		v = readq(base);
> +		v = FIELD_GET(DFH_VERSION, v);
> +
> +		if (v == 1) {
> +			v =  readq(base + DFHv1_CSR_SIZE_GRP);

I am already lost what v keeps...

Perhaps

		v = readq(base);
		switch (FIELD_GET(DFH_VERSION, v)) {
		case 1:
			...
			break;
		}

> +			if (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {

				void __iomem *v1hdr = base + DFHv1_PARAM_HDR;

> +				off = dfl_find_param(base + DFHv1_PARAM_HDR, ofst,
> +						     DFHv1_PARAM_ID_MSIX);

				off = dfl_find_param(v1hdr, ofst, DFHv1_PARAM_ID_MSIX);

> +				if (off >= 0) {
> +					ibase = readl(base + DFHv1_PARAM_HDR +
> +						      off + DFHv1_PARAM_MSIX_STARTV);
> +					inr = readl(base + DFHv1_PARAM_HDR +
> +						    off + DFHv1_PARAM_MSIX_NUMV);

					ibase = readl(v1hdr + off + DFHv1_PARAM_MSIX_STARTV);
					inr = readl(v1hdr + off + DFHv1_PARAM_MSIX_NUMV);

> +					dev_dbg(binfo->dev, "%s start %d num %d fid 0x%x\n",
> +						__func__, ibase, inr, fid);

No __func__ for dev_dbg(). Dynamic debug has this feature at runtime!

> +				}
> +			}
> +		}
> +	}

...

> +/*

If it's a kernel doc, make it to be parsable as a such.

> + * dfl_find_param() - find the offset of the given parameter
> + * @base: base pointer to start of dfl parameters in DFH
> + * @max: maximum offset to search
> + * @param: id of dfl parameter
> + *
> + * Return: positive offset on success, negative error code otherwise.
> + */
> +int dfl_find_param(void __iomem *base, resource_size_t max, int param);

+ blank line.

>  #endif /* __LINUX_DFL_H */

-- 
With Best Regards,
Andy Shevchenko



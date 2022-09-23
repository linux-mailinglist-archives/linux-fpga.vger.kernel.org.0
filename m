Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC61E5E7E47
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 17:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiIWPVz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 11:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiIWPVd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 11:21:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9393DF192C;
        Fri, 23 Sep 2022 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663946491; x=1695482491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=knBQ7zAmYT9oqE/HB/kSwqI8AwDgZ/tNqaN2kNiG/Dc=;
  b=FM8izTCSgK6EaEHmAAemZhpfH8bVe4mwHrWxO9B2ZYdnV4UHQY830Qjt
   S8eTJlsB1ypbsuK33Neg2AMZzr6BkwIVeH2KlhsU1q63lNUgZSle5b1uy
   /dkQITGYQFUaMIC23jaC7p0WH8JChmzfhQJoYlpLTkdM9OHPYg5cjiWWC
   69uKUO4ohlqQNuUiewNi2+kI7sReHeKh4FI2jmT146zMjf8CJDqoOrwyh
   olJkKh2iMHiXEySu0bKgLjFG3nRlhYU0r3plgBep/wVuBHIqTctOmat0D
   iJSrAAH2ayaKd28i8Q3ieiEy8/jtg5lMXzdHFt0emNFQ5/tK7CtTvK1fw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="283713146"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="283713146"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="762647111"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2022 08:21:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obkUH-006WBG-0B;
        Fri, 23 Sep 2022 18:21:09 +0300
Date:   Fri, 23 Sep 2022 18:21:08 +0300
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
Subject: Re: [PATCH v2 4/6] fpga: dfl: add generic support for MSIX interrupts
Message-ID: <Yy3O5OeDjJ99g/M2@smile.fi.intel.com>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
 <20220923121745.129167-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923121745.129167-5-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Sep 23, 2022 at 05:17:43AM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Define and use a DFHv1 parameter to add generic support for MSIX
> interrupts for DFL devices.

...

> +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
> +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {

> +

Unneeded blank line.

> +		v = FIELD_GET(DFH_VERSION, readq(base));
> +		switch (v) {

This v...

> +		case 0:
> +			break;
> +
> +		case 1:
> +			v =  readq(base + DFHv1_CSR_SIZE_GRP);

Extra space.

...and this v are semantically different. It's quite hard to deduce their
semantics.

> +			if (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
> +				off = dfl_find_param(base + DFHv1_PARAM_HDR, ofst,
> +						     DFHv1_PARAM_ID_MSIX);

I guess I have suggested to use temporary variable(s) here.

			void __iomem *dfhv1 = base + DFHv1...;
			void __iomem *nth;

> +				if (off >= 0) {

					nth = dfhv1 + off;

> +					ibase = readl(base + DFHv1_PARAM_HDR +
> +						      off + DFHv1_PARAM_MSIX_STARTV);
> +					inr = readl(base + DFHv1_PARAM_HDR +
> +						    off + DFHv1_PARAM_MSIX_NUMV);

					ibase = readl(nth + DFHv1_PARAM_MSIX_STARTV);
					inr = readl(nth + DFHv1_PARAM_MSIX_NUMV);

> +					dev_dbg(binfo->dev, "start %d num %d fid 0x%x\n",
> +						ibase, inr, fid);
> +				}
> +			}
> +			break;
> +
> +		default:
> +			dev_warn(binfo->dev, "unexpected DFH version %lld\n", v);
> +			break;
> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko



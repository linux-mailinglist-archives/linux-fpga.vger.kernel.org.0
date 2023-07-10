Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A2974CF00
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjGJHr3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 03:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjGJHr2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 03:47:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E1B12E;
        Mon, 10 Jul 2023 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688975243; x=1720511243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xPztZ+J8MBfqfmjx7KsUl5UggWWY3LTfkcDk9EsYdp4=;
  b=kx0nVSR10GaI3H6a2Ly69+cAI5ngdqdicRDp6tVgyc/eQ2P+aT/aEsiu
   d+UeVMgBFUhe6qHafqHh2VNIiheVe4656Trj0NxYU2PQ9TWtU5F51JO0O
   h/LLDTDKBWIAbTBGJfgYWKP1nolCIC2qBD/XfPDt3WmJnewlaFvpUkJ0A
   JGSomsfQftXXmKeQuvk+R3UowWNSEsNsXoN1askv5L7WenLjGFtWYX028
   J+RiXidb7Dt30RNYpy/JxOjYgPKGs7Pxq7qh+DacpFa1aq5zg/UudwWl6
   pwboG91IdYzIVa84zG4d0EUm6/ZQiwpTLTgmvP39luHqTC3qAesaYf/96
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="354138667"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="354138667"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 00:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="1051272913"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="1051272913"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jul 2023 00:47:19 -0700
Date:   Mon, 10 Jul 2023 15:45:52 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Peter Colberg <peter.colberg@intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tianfei.zhang@intel.com, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        lgoncalv@redhat.com
Subject: Re: [PATCH 1/2] fpga: dfl: use sysfs_emit() to format sysfs values
Message-ID: <ZKu3MIfEyIBqg2g1@yilunxu-OptiPlex-7050>
References: <cover.1687301688.git.peter.colberg@intel.com>
 <a80ad13ad82ff294e706bb87e5b62793c5d195f5.1687301688.git.peter.colberg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80ad13ad82ff294e706bb87e5b62793c5d195f5.1687301688.git.peter.colberg@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-04 at 22:54:50 -0400, Peter Colberg wrote:
> Use sysfs_emit() to format sysfs values, which wraps vscnprintf() for a
> PAGE_SIZE buffer. Remove explicit casts in favour of using the printk()
> format specifier corresponding to the type of the formatted value.
> 
> These changes are cosmetic only; no functional changes.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/fpga/dfl-afu-error.c |  7 +++----
>  drivers/fpga/dfl-afu-main.c  | 17 ++++++++---------
>  drivers/fpga/dfl-fme-error.c | 19 ++++++++-----------
>  drivers/fpga/dfl-fme-main.c  | 26 ++++++++++----------------
>  drivers/fpga/dfl-fme-perf.c  | 16 +++++++---------
>  drivers/fpga/dfl.c           |  4 ++--
>  drivers/fpga/fpga-bridge.c   |  2 +-
>  drivers/fpga/fpga-mgr.c      |  4 ++--
>  drivers/fpga/fpga-region.c   |  5 ++---
>  9 files changed, 43 insertions(+), 57 deletions(-)
>
[...]
 
> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> index 7422d2bc6f37..1b072416069b 100644
> --- a/drivers/fpga/dfl-fme-perf.c
> +++ b/drivers/fpga/dfl-fme-perf.c
> @@ -524,20 +524,18 @@ static ssize_t fme_perf_event_show(struct device *dev,
>  {
>  	struct dev_ext_attribute *eattr;
>  	unsigned long config;
> -	char *ptr = buf;
>  
>  	eattr = container_of(attr, struct dev_ext_attribute, attr);
>  	config = (unsigned long)eattr->var;
>  
> -	ptr += sprintf(ptr, "event=0x%02x", (unsigned int)get_event(config));
> -	ptr += sprintf(ptr, ",evtype=0x%02x", (unsigned int)get_evtype(config));
> +	if (!is_portid_root(get_portid(config)))
> +		return sysfs_emit(buf,
> +				  "event=0x%02llx,evtype=0x%02llx,portid=?\n",
                                              ^               ^
why llx, should be lx?

> +				  get_event(config), get_evtype(config));
>  
> -	if (is_portid_root(get_portid(config)))
> -		ptr += sprintf(ptr, ",portid=0x%02x\n", FME_PORTID_ROOT);
> -	else
> -		ptr += sprintf(ptr, ",portid=?\n");
> -
> -	return (ssize_t)(ptr - buf);
> +	return sysfs_emit(buf, "event=0x%02llx,evtype=0x%02llx,portid=0x%02x\n",

same

> +			  get_event(config), get_evtype(config),
> +			  FME_PORTID_ROOT);

BTW, have you ever tested with perf tool? The perf sysfs is a little
tricky to make perf work. I'm not sure everything is fine with naked
eyes.

Thanks,
Yilun


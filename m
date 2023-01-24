Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35CC679D43
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Jan 2023 16:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjAXPS4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 24 Jan 2023 10:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjAXPSo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 24 Jan 2023 10:18:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D7CBB98;
        Tue, 24 Jan 2023 07:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674573523; x=1706109523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=//VSMjNdevkRsXA1LhVyGUuUXQy2F2dme5uYujX+xQ8=;
  b=COYI/bj3Lfj3b10EyZZNnGmJETzkqFiz8i4D9vK3eEQIyLtp2DUi+/Xk
   6I4TKqh3Rv1rjrqYhCeJ/ijl80QIz9JZngRgImwBsZ7ncn4EzHnus8I++
   EkrI+Xz99mu8heTNjHvyE4NGNRAwkEgYf3BEmfCeHR7pMlUKfHfWf/wIa
   D/pRc5Wd9QkIKUr1ktM1qvI8AeDNKKvA/EBhwSdA0KMxqFYSN8kQXejMF
   Z1PPqNPg3cE6py2izqtApPB1f+jDgjS0dy1IS91Ktb9RrmVk774HdjvnA
   AIAqx92rS2wG5V3WzZKW9MwqQNZOHYQDJvEMnSQ1WygxR0jp/fXagoiHG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328404091"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="328404091"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:18:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="804639402"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="804639402"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2023 07:18:40 -0800
Date:   Tue, 24 Jan 2023 23:08:09 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: bridge: return errors in the show() method of
 the "state" attribute
Message-ID: <Y8/0WRFLTh5p/BfN@yilunxu-OptiPlex-7050>
References: <20230124113050.117645-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124113050.117645-1-marpagan@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-01-24 at 12:30:50 +0100, Marco Pagani wrote:
> This patch changes the show() method of the "state" sysfs attribute to
> return an error if the bridge's enable_show() op returns an error code.
> In this way, the userspace can distinguish between when the bridge is
> actually "enabled" (i.e., allowing signals to pass) or "disabled"
> (i.e., gating signals), or when there is an error (e.g., the state of
> the bridge cannot be determined).

Maybe we remove the example for "error" here. This patch is just to
propagate the errors from low level drivers.

> 
> Currently, enable_show() returns an integer representing the bridge's
> state (enabled or disabled) or an error code. However, this integer
> value is interpreted in state_show() as a bool, resulting in the method
> printing "enabled" (i.e., the bridge allows signals to pass), without
> propagating the error, even when enable_show() returns an error code.
> 
> Another possibility could be to change the signature of enable_show()
> to return a bool for symmetry with the enable_set() "setter" method.
> However, this would prevent enable_show() from returning error codes

Returning error codes is good to me.

> and may break the HPS bridge driver (altera-hps2fpga.c +53).
> 
> Thanks
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/fpga-bridge.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 727704431f61..5cd40acab5bf 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -293,12 +293,15 @@ static ssize_t state_show(struct device *dev,
>  			  struct device_attribute *attr, char *buf)
>  {
>  	struct fpga_bridge *bridge = to_fpga_bridge(dev);
> -	int enable = 1;
> +	int state = 1;
>  
> -	if (bridge->br_ops && bridge->br_ops->enable_show)
> -		enable = bridge->br_ops->enable_show(bridge);
> +	if (bridge->br_ops && bridge->br_ops->enable_show) {
> +		state = bridge->br_ops->enable_show(bridge);
> +		if (state < 0)
> +			return state;
> +	}
>  
> -	return sprintf(buf, "%s\n", enable ? "enabled" : "disabled");
> +	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");

The code looks good to me. You may remove RFC prefix in next version.

Thanks,
Yilun

>  }
>  
>  static DEVICE_ATTR_RO(name);
> -- 
> 2.39.1
> 

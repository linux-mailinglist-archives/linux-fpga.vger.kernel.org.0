Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F2867E7F3
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jan 2023 15:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjA0OOu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Jan 2023 09:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjA0OOO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Jan 2023 09:14:14 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C196083240;
        Fri, 27 Jan 2023 06:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674828853; x=1706364853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V/aLgXJKIE4z7GbNofbLspnRLjn991/limoiiqttpus=;
  b=RejHXVjcUs6R/AQkYS55d3M8RqH6lQ3BVdpj6tjSTGgPvct2VAG0DcK1
   hvRKd8+pMAAxjyhwtZu2vOAfBR6StEEQSfJnuCywbGaT6zMCVkfFpx6h0
   yhI8vCvq9WUW2mKjQnrNJV8zKUN1NeOGsj818cVE8TOcVeh5XN2NsxGce
   FHFW01S18x/L+qk/csr2S2b5LOd+40vDjKyz/vUB5WuldQX/9RYGc9alR
   GhBi4TK4HJhtsEK/qyEHeaqMIZPAz2q69haLb/NFReaA2ddpCgSjpKWly
   qD6/PPkFhEE0cEaYgLjpG1PKHEcD/uHaCJG7m84/b3WNQ0TjRP3nR6W1f
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="389467525"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="389467525"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 06:14:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="771596987"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="771596987"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jan 2023 06:14:11 -0800
Date:   Fri, 27 Jan 2023 22:03:37 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: bridge: return errors in the show() method of the
 "state" attribute
Message-ID: <Y9PZuWcfAZrV7SZm@yilunxu-OptiPlex-7050>
References: <20230125140622.176870-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125140622.176870-1-marpagan@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-01-25 at 15:06:22 +0100, Marco Pagani wrote:
> This patch changes the show() method of the "state" sysfs attribute to
> propagate errors returned by the enable_show() op. In this way,
> userspace can distinguish between when the bridge is actually "enabled"
> (i.e., allowing signals) or "disabled" (i.e., gating signals), or when
> there is an error.
> 
> Currently, enable_show() returns an integer representing the bridge's
> state (enabled or disabled) or an error code. However, this integer
> value is interpreted in state_show() as a bool, resulting in the method
> printing "enabled" (i.e., the bridge allows signals to pass), without
> propagating the error, even when enable_show() returns an error code.
> 
> Thanks

Removed this line, and applied to for-next.

Acked-by: Xu Yilun <yilun.xu@intel.com>

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
>  }
>  
>  static DEVICE_ATTR_RO(name);
> -- 
> 2.39.1
> 

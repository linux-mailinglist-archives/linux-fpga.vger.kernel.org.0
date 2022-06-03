Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE52B53C928
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Jun 2022 13:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiFCLIn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Jun 2022 07:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiFCLIj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 3 Jun 2022 07:08:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66E93BFB8;
        Fri,  3 Jun 2022 04:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654254517; x=1685790517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QPNgQ2od7l/+/tdrZY8laHxgx7ge6gu2BOh+jIuNMAA=;
  b=WvIlskhSYDt854viZTb51M5+zT+hi/90XZFPySPp34lzcBclIpvOhLmN
   oUl/wpx9CHQ44VNfkbXfpJyXvshvfShkS8DXjbudajX5E83s2D031hlOC
   QUselFdXPYZI8+pzgGd8c46YOWnWPD6Z1reWhbocI+mFnfDN73xxOITJD
   nWLuVatIq9v69DD5pyzRbMu4w1Lfswx+tRVjLd0UGb0rGJy/Wt5FXoI/I
   fqzmHQunSLsJmUNK51uMqam5f8kZ/dBwjoRBbyla7ZLzLUmR8sxufNtPi
   wuz4dkTeYIqc3rPPCuUaIi6bAZh90foM/xHpyDgXaE6Dbq3e8utBAUAjB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="275967159"
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="275967159"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 04:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,274,1647327600"; 
   d="scan'208";a="707985886"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga004.jf.intel.com with ESMTP; 03 Jun 2022 04:08:35 -0700
Date:   Fri, 3 Jun 2022 19:00:46 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     tien.sung.ang@intel.com
Cc:     hao.wu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org, trix@redhat.com,
        dinh.nguyen@intel.com
Subject: Re: [PATCH v2] fpga: altera-cvp: allow interrupt to continue next
 time
Message-ID: <20220603110046.GC238410@yilunxu-OptiPlex-7050>
References: <20220528120503.GB175058@yilunxu-OptiPlex-7050>
 <20220601014027.2547481-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601014027.2547481-1-tien.sung.ang@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 01, 2022 at 09:40:27AM +0800, tien.sung.ang@intel.com wrote:
> From: Dinh Nguyen <dinh.nguyen@intel.com>
> 
> The main objective of this change is to perform error handling
> if the CvP firmware becomes unresponsive. The error_path flow
> resets the CvP mode and HIP_CLK_SEL bit.
> 
> CFG_READY signal/bit may time-out due to firmware not responding
> within the given time-out. This time varies due to numerous
> factors like size of bitstream and others.
> This time-out error may or may not impact the result of the CvP
> previous transactions. The CvP driver shall then, respond with
> EAGAIN instead Time out error.
> 
> Signed-off-by: Dinh Nguyen <dinh.nguyen@intel.com>
> Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> ---
> 
> changelog v2:
> * Amend the commit message
> 
> ---
>  drivers/fpga/altera-cvp.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4ffb9da537d8..d74ff63c61e8 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -309,10 +309,22 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
>  	/* STEP 15 - poll CVP_CONFIG_READY bit for 0 with 10us timeout */
>  	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
>  				     conf->priv->poll_time_us);
> -	if (ret)
> +	if (ret) {
>  		dev_err(&mgr->dev, "CFG_RDY == 0 timeout\n");
> +		goto error_path;

I assume the error handling is specific to CFG_RDY timeout, is it? Then it
could be embedded in this code block.

And also the -EAGAIN ret, please only return it in this code block.

Usually the goto error path is for common fail out.

> +	}
>  
>  	return ret;
> +
> +error_path:
> +	/* reset CVP_MODE and HIP_CLK_SEL bit */
> +	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
> +	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
> +	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
> +	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
> +
> +	return -EAGAIN;

Please still specify the reason for -EAGAIN rather than timeout.

Thanks,
Yilun

> +
>  }
>  
>  static int altera_cvp_write_init(struct fpga_manager *mgr,
> -- 
> 2.25.1

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3310F70B31C
	for <lists+linux-fpga@lfdr.de>; Mon, 22 May 2023 04:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjEVCSC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 21 May 2023 22:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEVCSB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 21 May 2023 22:18:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F6E3;
        Sun, 21 May 2023 19:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684721879; x=1716257879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cb+tkTOwk6ACz8AEthYEQ+drS7DUI2DfrzIjLGdBbPM=;
  b=gTH1hwH8f+W1bLdCqrYzuhogrA3ZpI24txkCesY0CuWJtf1hYlxGGPTv
   svscGG+opfYQ93nRHk6GSZq9PUX087hEiNt9KQOzy8CgFPC0hF21TSc2c
   +hLNx1qJEiwOW6HTLQH7zT7isfrJhWUr2ynvnXNYWD7+6HMmnqt+TBVAh
   Mw731bVCUeJ1UgYtjmAw95bFHxmX6jBGF+7/m9MPk1jJcfriQsItvAJAo
   9Iw4tlSN4eL6iIpoijw4Mb5oY6cKMskgAMU0/yAqAjZGpadmcZJ7TGPFZ
   jiQZDurpX7jz/5Ph9fiYn6xIz+fPuknMLMIcVSo8mQbs29Ce+s/2LPjDe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="416270332"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="416270332"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 19:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="768336093"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="768336093"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 21 May 2023 19:17:57 -0700
Date:   Mon, 22 May 2023 18:17:44 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@amd.com, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
Subject: Re: [PATCH] fpga: zynq-fpga: Ensure proper xCAP interface switch
Message-ID: <ZGtBSGpPX3tK6mWY@yilunxu-OptiPlex-7050>
References: <20230519103232.3009096-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519103232.3009096-1-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-19 at 16:02:32 +0530, Nava kishore Manne wrote:
> From: Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
> 
> Ensure that the low-level fpga-manager driver for Zynq-7000 devices
> switches between reconfiguration interfaces as specified in the TRM
> (section 6.5.1: "Ensure that all outstanding transactions are completed
> before changing interfaces"); device (re)configuration may fail otherwise

Please briefly describe how the change conforms to the Doc in changelog,
rather than just leave the Doc for reviewers.

And please provide the Link to documentation.

> 
> Signed-off-by: Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
> Tested-by: Nava kishore Manne <nava.kishore.manne@amd.com>

Please add your own SOB as you are handling the patch.

Thanks,
Yilun

> ---
>  drivers/fpga/zynq-fpga.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index ae0da361e6c6..88db9ac36887 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -493,15 +493,16 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
>  	if (err)
>  		return err;
>  
> -	/* Release 'PR' control back to the ICAP */
> -	zynq_fpga_write(priv, CTRL_OFFSET,
> -		zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
> -
>  	err = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, intr_status,
>  				     intr_status & IXR_PCFG_DONE_MASK,
>  				     INIT_POLL_DELAY,
>  				     INIT_POLL_TIMEOUT);
>  
> +	/* Release 'PR' control back to the ICAP */
> +	zynq_fpga_write(priv, CTRL_OFFSET,
> +			zynq_fpga_read(priv, CTRL_OFFSET)
> +			& ~CTRL_PCAP_PR_MASK);
> +
>  	clk_disable(priv->clk);
>  
>  	if (err)
> -- 
> 2.25.1
> 

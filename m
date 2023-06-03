Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B386720EEC
	for <lists+linux-fpga@lfdr.de>; Sat,  3 Jun 2023 11:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjFCJ1z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 3 Jun 2023 05:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFCJ1z (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 3 Jun 2023 05:27:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3F9E48;
        Sat,  3 Jun 2023 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685784473; x=1717320473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pdvmuC2wyW2a7AD5zT1/NjQSBP98ch0K0/460XXGMZU=;
  b=nlUSMCNMMY0ehLsukjtWCFfY6oPBtq533ee84WI6/bp5JYwF0kxJBVpZ
   8SVvqwTLkA/DtaZ2KpdxOcXBbvLKQbZXqQ1khnkrYYJ+Wo+xY/LR1Dhxq
   vJYC69zkx8/YBMaceq1zigpulxl76sgBkuYi6gcNV+RHDkPA4xD1KTict
   zf4ZyBLtTqRY4r0nAXSIro7AATMsT64RI1iRo2o5GnJ61FDLPARB3BHMM
   F/vAvNyt3Cq/liOrraBvpaj0GI/RmzIqr45S11zTYCElr07Qqc4y8Kbjb
   jOcD6Pp5xGvUOEMlUjfHB7LA4SWoN5/aHp5N4Tt2TvQyD6TpGp1+1HxW+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="419591916"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="419591916"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 02:27:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="658529048"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="658529048"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2023 02:27:51 -0700
Date:   Sun, 4 Jun 2023 01:27:21 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@amd.com, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
Subject: Re: [PATCH v2] fpga: zynq-fpga: Ensure proper xCAP interface switch
Message-ID: <ZHt3+XSvmTnk1Xno@yilunxu-OptiPlex-7050>
References: <20230531095624.1802757-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531095624.1802757-1-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-31 at 15:26:24 +0530, Nava kishore Manne wrote:
> From: Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
> 
> The Zynq platform has PCAP, ICAP and JTAG interfaces for configuring
> programmable logic (PL). The existing driver implementation uses the
> PCAP interface to configure the PL. Before switching the PL configuration
> interface from PCAP to ICAP make sure that all outstanding Transactions
> relevant to the PL configuration should be completed by the PCAP interface
> otherwise it may lead to PL configuration issues.
> 
> This patch provides a required fix to ensure that all existing PL
> transactions are completed before switching from PCAP to ICAP.
> 
> For detailed information relevant to PL configuration interfaces refer
> Zynq 7000 TRM (section 6.5.1).
> Link: https://docs.xilinx.com/v/u/en-US/ug585-Zynq-7000-TRM
> 
> Signed-off-by: Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v2:
>               - Updated commit message and added Doc link as suggested by Yilun.
> 
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

Don't put the & at the beginning of the line:

	zynq_fpga_read(priv, CTRL_OFFSET) &
	~CTRL_PCAP_PR_MASK);

or just:
	zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);

80 lines is not a must now.

Others look good to me.

Thanks,
Yilun

> +
>  	clk_disable(priv->clk);
>  
>  	if (err)
> -- 
> 2.25.1
> 

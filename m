Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E267355D963
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Jun 2022 15:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiF1IkS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Jun 2022 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343897AbiF1IkR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 28 Jun 2022 04:40:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517E227CFB;
        Tue, 28 Jun 2022 01:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656405616; x=1687941616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HyBPeVMcLYtcvySQ5xAMJcjvoa1PQDR0FQGJvt+N3Cg=;
  b=eHSjZ60BEZoNF04AQi7pQundgrx6z28TxcC+mH8Pr4DwEfb9ssg6q3PB
   /tpfL3xqT1TCIK5TvViPsnSM1Cozvkp6LGmIpfIzYeDbqUIXU1IFVMhE7
   oKcy5ASEcLiEmCTW4UUndKWiTRZhFvDczUUiwfyilUQglqQrfoTFmoEGN
   zY2OLlrAA4IXnOFd2W+6ku/T+ktxnce3HO53O7uMv6vaggey/C0YKwqF0
   HUD5dpjhIVvFe07ShOt8KAQzaC+x8eqhybHaylZ1beOx1rvpKk4bTp0z9
   R9TshbNU1WxNZkREOITFNhrUj958iBH6jMglCGTEfFGrnP2LMHeAy9Gog
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="307156649"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="307156649"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="658045495"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2022 01:40:12 -0700
Date:   Tue, 28 Jun 2022 16:31:58 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     michal.simek@xilinx.com, hao.wu@intel.com, trix@redhat.com,
        mdf@kernel.org, gregkh@linuxfoundation.org, ronak.jain@xilinx.com,
        rajan.vaja@xilinx.com, abhyuday.godhasara@xilinx.com,
        piyush.mehta@xilinx.com, harsha.harsha@xilinx.com,
        lakshmi.sai.krishna.potthuri@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com
Subject: Re: [PATCH v2 1/3] fpga: manager: change status api prototype, don't
 use older
Message-ID: <20220628083158.GA2442728@yilunxu-OptiPlex-7050>
References: <20220621092833.1057408-1-nava.manne@xilinx.com>
 <20220621092833.1057408-2-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621092833.1057408-2-nava.manne@xilinx.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 21, 2022 at 02:58:31PM +0530, Nava kishore Manne wrote:
> Different vendors have different error sets defined by Hardware.
> If we always define the new bits when we cannot find an exact 1:1
> mapping in the core the 64 bits would soon be used out. Also, it's
> hard to understand the mixture of different error sets.
> 
> To address these issues updated the status interface to handle the
> vendor-specific messages in a generic way. With the updated status
> interface the vendor-specific driver files can independently handle
> the error messages.

I think we don't have to provide the vendor specific HW errors in a
generic way, maybe the vendor specific drivers could handle them by its
own device attributes.

Since the output value set of the interface is specific to each driver,
users should still interpret them in specific manners. So doesn't see
much value for a class interface.

Thanks,
Yilun

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
>               - New patch.
> 
>  drivers/fpga/dfl-fme-mgr.c    | 20 ++++++++++----------
>  drivers/fpga/fpga-mgr.c       | 24 +++++-------------------
>  include/linux/fpga/fpga-mgr.h |  2 +-
>  3 files changed, 16 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index af0785783b52..5a8e6a41c85c 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -72,22 +72,22 @@ struct fme_mgr_priv {
>  	u64 pr_error;
>  };
>  
> -static u64 pr_error_to_mgr_status(u64 err)
> +static ssize_t pr_error_to_mgr_status(u64 err, char *buf)
>  {
> -	u64 status = 0;
> +	ssize_t len = 0;
>  
>  	if (err & FME_PR_ERR_OPERATION_ERR)
> -		status |= FPGA_MGR_STATUS_OPERATION_ERR;
> +		len += sprintf(buf + len, "reconfig operation error\n");
>  	if (err & FME_PR_ERR_CRC_ERR)
> -		status |= FPGA_MGR_STATUS_CRC_ERR;
> +		len += sprintf(buf + len, "reconfig CRC error\n");
>  	if (err & FME_PR_ERR_INCOMPATIBLE_BS)
> -		status |= FPGA_MGR_STATUS_INCOMPATIBLE_IMAGE_ERR;
> +		len += sprintf(buf + len, "reconfig incompatible image\n");
>  	if (err & FME_PR_ERR_PROTOCOL_ERR)
> -		status |= FPGA_MGR_STATUS_IP_PROTOCOL_ERR;
> +		len += sprintf(buf + len, "reconfig IP protocol error\n");
>  	if (err & FME_PR_ERR_FIFO_OVERFLOW)
> -		status |= FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR;
> +		len += sprintf(buf + len, "reconfig fifo overflow error\n");
>  
> -	return status;
> +	return len;
>  }
>  
>  static u64 fme_mgr_pr_error_handle(void __iomem *fme_pr)
> @@ -252,11 +252,11 @@ static int fme_mgr_write_complete(struct fpga_manager *mgr,
>  	return 0;
>  }
>  
> -static u64 fme_mgr_status(struct fpga_manager *mgr)
> +static ssize_t fme_mgr_status(struct fpga_manager *mgr, char *buf)
>  {
>  	struct fme_mgr_priv *priv = mgr->priv;
>  
> -	return pr_error_to_mgr_status(priv->pr_error);
> +	return pr_error_to_mgr_status(priv->pr_error, buf);
>  }
>  
>  static const struct fpga_manager_ops fme_mgr_ops = {
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 08dc85fcd511..ae8de13a482e 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -38,10 +38,11 @@ static inline enum fpga_mgr_states fpga_mgr_state(struct fpga_manager *mgr)
>  	return FPGA_MGR_STATE_UNKNOWN;
>  }
>  
> -static inline u64 fpga_mgr_status(struct fpga_manager *mgr)
> +static inline ssize_t fpga_mgr_status(struct fpga_manager *mgr, char *buf)
>  {
>  	if (mgr->mops->status)
> -		return mgr->mops->status(mgr);
> +		return mgr->mops->status(mgr, buf);
> +
>  	return 0;
>  }
>  
> @@ -460,23 +461,8 @@ static ssize_t status_show(struct device *dev,
>  			   struct device_attribute *attr, char *buf)
>  {
>  	struct fpga_manager *mgr = to_fpga_manager(dev);
> -	u64 status;
> -	int len = 0;
> -
> -	status = fpga_mgr_status(mgr);
> -
> -	if (status & FPGA_MGR_STATUS_OPERATION_ERR)
> -		len += sprintf(buf + len, "reconfig operation error\n");
> -	if (status & FPGA_MGR_STATUS_CRC_ERR)
> -		len += sprintf(buf + len, "reconfig CRC error\n");
> -	if (status & FPGA_MGR_STATUS_INCOMPATIBLE_IMAGE_ERR)
> -		len += sprintf(buf + len, "reconfig incompatible image\n");
> -	if (status & FPGA_MGR_STATUS_IP_PROTOCOL_ERR)
> -		len += sprintf(buf + len, "reconfig IP protocol error\n");
> -	if (status & FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR)
> -		len += sprintf(buf + len, "reconfig fifo overflow error\n");
> -
> -	return len;
> +
> +	return fpga_mgr_status(mgr, buf);
>  }
>  
>  static DEVICE_ATTR_RO(name);
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 0f9468771bb9..42c24426fb7f 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -154,7 +154,7 @@ struct fpga_manager_info {
>  struct fpga_manager_ops {
>  	size_t initial_header_size;
>  	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
> -	u64 (*status)(struct fpga_manager *mgr);
> +	ssize_t (*status)(struct fpga_manager *mgr, char *buf);
>  	int (*write_init)(struct fpga_manager *mgr,
>  			  struct fpga_image_info *info,
>  			  const char *buf, size_t count);
> -- 
> 2.25.1

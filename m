Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A77536D87
	for <lists+linux-fpga@lfdr.de>; Sat, 28 May 2022 17:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiE1P3R (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 May 2022 11:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiE1P3Q (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 May 2022 11:29:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC3813F1F;
        Sat, 28 May 2022 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653751755; x=1685287755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kVYNnfGX5hHOEUJRrkwZvAzV0mNlGMAMNLdCH/RNBVE=;
  b=iguF0B7/UgwrT7JHoTPWWFJhopPD9snuOFk6NuFwALzv4x/5ho+AW/qc
   7hjsUwRRuhZ/mH5kazFclHLIQ5lx8pBciqJS7Jip2UUxVLMi0+gvukNgV
   OtbrRo0eZBPINomS+eIgUM1iBRf/7cogsFR84fO77bGriyvSfhXqPygTv
   JT3KEI3DBInB2Q3irGlMpq4bqPDfLOlgbM4g2scsyJqPN5jKWAenuz047
   hrWqX+VzOAxhmBc7NUzILT+R0AVDTEBNEYsLe3iDUkgCmaeo2boEnqnJW
   kPIxJxj4xe2q6RMIYpy/DzYCJDt9oqvJXOcC7yc/18gqsJ0BFw/hK/Xpy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="335336484"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="335336484"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 08:29:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="575284993"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2022 08:29:11 -0700
Date:   Sat, 28 May 2022 23:21:27 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        trix@redhat.com, gregkh@linuxfoundation.org, ronak.jain@xilinx.com,
        abhyuday.godhasara@xilinx.com, rajan.vaja@xilinx.com,
        lakshmi.sai.krishna.potthuri@xilinx.com, piyush.mehta@xilinx.com,
        harsha.harsha@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH 3/3] fpga: zynqmp-fpga: Adds status interface
Message-ID: <20220528152127.GA181580@yilunxu-OptiPlex-7050>
References: <20220524094745.287002-1-nava.manne@xilinx.com>
 <20220524094745.287002-4-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524094745.287002-4-nava.manne@xilinx.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, May 24, 2022 at 03:17:45PM +0530, Nava kishore Manne wrote:
> Adds status interface for zynqmp-fpga, It's a read only
> interface which allows the user to get the PL status.
> 
> Usage:
> To read the PL configuration status
>         cat /sys/class/fpga_manager/<fpga>/status
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/zynqmp-fpga.c | 52 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index c60f20949c47..07c7b7326726 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -14,6 +14,19 @@
>  
>  /* Constant Definitions */
>  #define IXR_FPGA_DONE_MASK	BIT(3)
> +#define READ_DMA_SIZE		256U
> +
> +/* Error Register */
> +#define IXR_FPGA_ERR_CRC_ERR		BIT(0)
> +#define IXR_FPGA_ERR_SECURITY_ERR	BIT(16)
> +
> +/* Signal Status Register. For details refer ug570 */
> +#define IXR_FPGA_END_OF_STARTUP		BIT(4)
> +#define IXR_FPGA_GST_CFG_B		BIT(5)
> +#define IXR_FPGA_INIT_B_INTERNAL	BIT(11)
> +#define IXR_FPGA_DONE_INTERNAL_SIGNAL	BIT(13)
> +
> +#define IXR_FPGA_CONFIG_STAT_OFFSET	7U
>  
>  /**
>   * struct zynqmp_fpga_priv - Private data structure
> @@ -77,8 +90,47 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
>  	return FPGA_MGR_STATE_UNKNOWN;
>  }
>  
> +static u64 zynqmp_fpga_ops_status(struct fpga_manager *mgr)
> +{
> +	unsigned int *buf, reg_val;
> +	dma_addr_t dma_addr;
> +	u64 status = 0;
> +	int ret;
> +
> +	buf = dma_alloc_coherent(mgr->dev.parent, READ_DMA_SIZE,
> +				 &dma_addr, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = zynqmp_pm_fpga_read(IXR_FPGA_CONFIG_STAT_OFFSET, dma_addr,
> +				  PM_FPGA_READ_CONFIG_REG, &reg_val);
> +	if (ret) {
> +		status = FPGA_MGR_STATUS_FIRMWARE_REQ_ERR;
> +		goto free_dmabuf;
> +	}
> +
> +	if (reg_val & IXR_FPGA_ERR_CRC_ERR)
> +		status |= FPGA_MGR_STATUS_CRC_ERR;
> +	if (reg_val & IXR_FPGA_ERR_SECURITY_ERR)
> +		status |= FPGA_MGR_STATUS_SECURITY_ERR;
> +	if (!(reg_val & IXR_FPGA_INIT_B_INTERNAL))
> +		status |= FPGA_MGR_STATUS_DEVICE_INIT_ERR;
> +	if (!(reg_val & IXR_FPGA_DONE_INTERNAL_SIGNAL))
> +		status |= FPGA_MGR_STATUS_SIGNAL_ERR;
> +	if (!(reg_val & IXR_FPGA_GST_CFG_B))
> +		status |= FPGA_MGR_STATUS_HIGH_Z_STATE_ERR;
> +	if (!(reg_val & IXR_FPGA_END_OF_STARTUP))
> +		status |= FPGA_MGR_STATUS_EOS_ERR;

I have concern about the status interface. Different vendors have
differnt error sets defined by Hardwares. If we always define the
new bits when we cannot find an exact 1:1 mapping. A 64 bits would
soon be used out. Also it's hard to understand the mixture of
different error sets.

I'd rather suggest that each driver define its own error reading
interface.

Thanks,
Yilun

> +
> +free_dmabuf:
> +	dma_free_coherent(mgr->dev.parent, READ_DMA_SIZE, buf, dma_addr);
> +
> +	return status;
> +}
> +
>  static const struct fpga_manager_ops zynqmp_fpga_ops = {
>  	.state = zynqmp_fpga_ops_state,
> +	.status = zynqmp_fpga_ops_status,
>  	.write_init = zynqmp_fpga_ops_write_init,
>  	.write = zynqmp_fpga_ops_write,
>  };
> -- 
> 2.25.1

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81D55C2D5
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Jun 2022 14:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbiF1Isv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Jun 2022 04:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239151AbiF1Iso (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 28 Jun 2022 04:48:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324C02E9FA;
        Tue, 28 Jun 2022 01:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656406123; x=1687942123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ErLlCdyFcGPrWBqJpelBqlWZkqPma1a3SBE5gm7ZPk=;
  b=nwi6Wwz1DFXTNEfOYuU9E9ESaAn3mDy65/IypDlO15KXvnvSC9mOV3rF
   r5tI1D0Htn3l5QqxabbJBfXpLeraC7aUJavHpPHqmoDh/m0wzSr+Mqb75
   h72jdQNuus50bkiQAReeaW4F/JtVopfv7dXz/nYQUAoF4V0Po6173mt0t
   NmLCxjt2E0dvuVxXBP0h4pWQCGW8DMpNHTkL7pD2p3992RLcQgbfLQxsi
   hhpdEEviv66h52V9Q4GXjJh4u8WOyF0jnaMvdlhXKYgpnwGPKjm+z7eUN
   UO1gKHLceI7jaau/qFZtCJqZDtWyg6tUZ/jhXGVJzHoSAgWqFIEYanAjK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="264719526"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="264719526"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="594697752"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2022 01:48:38 -0700
Date:   Tue, 28 Jun 2022 16:40:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     michal.simek@xilinx.com, hao.wu@intel.com, trix@redhat.com,
        mdf@kernel.org, gregkh@linuxfoundation.org, ronak.jain@xilinx.com,
        rajan.vaja@xilinx.com, abhyuday.godhasara@xilinx.com,
        piyush.mehta@xilinx.com, harsha.harsha@xilinx.com,
        lakshmi.sai.krishna.potthuri@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com
Subject: Re: [PATCH v2 3/3] fpga: zynqmp-fpga: Adds status interface
Message-ID: <20220628084024.GB2442728@yilunxu-OptiPlex-7050>
References: <20220621092833.1057408-1-nava.manne@xilinx.com>
 <20220621092833.1057408-4-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621092833.1057408-4-nava.manne@xilinx.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 21, 2022 at 02:58:33PM +0530, Nava kishore Manne wrote:
> Adds status interface for zynqmp-fpga, It's a read only
> interface which allows the user to get the PL status.
> 
> Usage:
> To read the PL configuration status
>         cat /sys/class/fpga_manager/<fpga>/status
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
>               - Updated status messages handling logic as suggested by Xu Yilun.
> 
>  drivers/fpga/zynqmp-fpga.c | 53 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index c60f20949c47..e194bba91d3f 100644
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
> @@ -77,8 +90,48 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
>  	return FPGA_MGR_STATE_UNKNOWN;
>  }
>  
> +static ssize_t zynqmp_fpga_ops_status(struct fpga_manager *mgr, char *buf)
> +{
> +	unsigned int *kbuf, reg_val;
> +	dma_addr_t dma_addr;
> +	ssize_t len = 0;
> +	int ret;
> +
> +	kbuf = dma_alloc_coherent(mgr->dev.parent, READ_DMA_SIZE,
> +				  &dma_addr, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	ret = zynqmp_pm_fpga_read(IXR_FPGA_CONFIG_STAT_OFFSET, dma_addr,
> +				  PM_FPGA_READ_CONFIG_REG, &reg_val);
> +	if (ret) {
> +		len += sprintf(buf + len, "firmware error\n");
> +		goto free_dmabuf;
> +	}
> +
> +	if (reg_val & IXR_FPGA_ERR_CRC_ERR)
> +		len += sprintf(buf + len, "reconfig CRC error\n");
> +	if (reg_val & IXR_FPGA_ERR_SECURITY_ERR)
> +		len += sprintf(buf + len, "reconfig security error\n");
> +	if (!(reg_val & IXR_FPGA_INIT_B_INTERNAL))
> +		len += sprintf(buf + len, "Device Initialization error\n");
> +	if (!(reg_val & IXR_FPGA_DONE_INTERNAL_SIGNAL))
> +		len += sprintf(buf + len, "Device internal signal error\n");
> +	if (!(reg_val & IXR_FPGA_GST_CFG_B))
> +		len += sprintf(buf + len,
> +			       "All I/Os are placed in High-Z state\n");
> +	if (!(reg_val & IXR_FPGA_END_OF_STARTUP))
> +		len += sprintf(buf + len, "Device sequence error\n");

Expressing multiple lines of data is discouraged, one value or an array
of values is OK. For more details, see
Documentation/filesystems/sysfs.rst

Thanks,
Yilun

> +
> +free_dmabuf:
> +	dma_free_coherent(mgr->dev.parent, READ_DMA_SIZE, buf, dma_addr);
> +
> +	return len;
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

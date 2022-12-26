Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5AF656050
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 07:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLZGS1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 01:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiLZGSV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 01:18:21 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66781D44;
        Sun, 25 Dec 2022 22:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672035499; x=1703571499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qfu14WkIiuZfo4zU64RGaAgof8CDTKmbyj8//bXWVr0=;
  b=Sr18OcO/70QDfaIGQ82PGMHCSEe0K82T0yOf090lRU1nsCoiW0WyIvzY
   u5aTKiFrCGwef+YKRjIOe6ZRPrnokcobkhQ2z8EKxkv7wAy3M7Nc9m773
   pz4c+FaeI3WOZE11AbNhtIS9C1m315h2fJGIk4WMBsCdhAz07I/BZdUB+
   /7YnkGksaQltJUYU3swoTkK+QT0q88PIGNOVKfErtSjEQE3n8+8iCwJ51
   IyTW/ECA25RSJqX9S+Ihdh5sR1Hm/P48kdrAAkZs5pTwdoOSHhFrQ7vz8
   +j2okRQbUmEzusSYjDWnRBCF+AeEHHDHyOA1mrBc5E1URoSzSwOoW1FyO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="384947829"
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="384947829"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 22:18:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="646089660"
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="646089660"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 25 Dec 2022 22:18:13 -0800
Date:   Mon, 26 Dec 2022 14:08:10 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        trix@redhat.com, ronak.jain@xilinx.com, gregkh@linuxfoundation.org,
        tanmay.shah@xilinx.com, ben.levinsky@amd.com,
        harsha.harsha@xilinx.com, rajan.vaja@xilinx.com,
        mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v4 2/2] fpga: zynqmp-fpga: Adds status interface
Message-ID: <Y6k6ShPtAFYzmDIy@yilunxu-OptiPlex-7050>
References: <20221223115850.2572573-1-nava.kishore.manne@amd.com>
 <20221223115850.2572573-3-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223115850.2572573-3-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-23 at 17:28:50 +0530, Nava kishore Manne wrote:
> Adds status interface for zynqmp-fpga, It's a read only interface
> which allows the user to get the Programmable Logic(PL) configuration
> status.
> 
> Usage:
> To read the Programmable Logic(PL) configuration status
>         cat /sys/class/fpga_manager/<fpga>/device/status
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v2:
>               - Updated status messages handling logic as suggested by Xu Yilun.
> 
> Changes for v3:
>               - Updated status interface handling logic (Restrict the status
>                 interface to the device-specific instead of handled by the core)
>                 as suggested by Xu Yilun.
> 
> Changes for v4:
>               - Limit the error strings to one word for each as suggested by
>                 Xu Yilun

Please fix the comments from Greg,

https://lore.kernel.org/all/Y0fYjyXrMEo6M76k@kroah.com/

> 
>  drivers/fpga/zynqmp-fpga.c | 87 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index c60f20949c47..81d3e18527ee 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -15,6 +15,37 @@
>  /* Constant Definitions */
>  #define IXR_FPGA_DONE_MASK	BIT(3)
>  
> +/* Error Register */
> +#define IXR_FPGA_ERR_CRC_ERR		BIT(0)
> +#define IXR_FPGA_ERR_SECURITY_ERR	BIT(16)
> +
> +/* Signal Status Register */
> +#define IXR_FPGA_END_OF_STARTUP		BIT(4)
> +#define IXR_FPGA_GST_CFG_B		BIT(5)
> +#define IXR_FPGA_INIT_B_INTERNAL	BIT(11)
> +#define IXR_FPGA_DONE_INTERNAL_SIGNAL	BIT(13)
> +
> +/* FPGA error status. */
> +enum {
> +	ZYNQMP_FPGA_STATUS_CRC_ERR,
> +	ZYNQMP_FPGA_STATUS_SECURITY_ERR,
> +	ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR,
> +	ZYNQMP_FPGA_STATUS_SIGNAL_ERR,
> +	ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR,
> +	ZYNQMP_FPGA_STATUS_EOS_ERR,
> +	ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR,
> +};
> +
> +static const char * const zynqmp_fpga_error_statuses[] = {
> +	[ZYNQMP_FPGA_STATUS_CRC_ERR] = "CRC-Error",
> +	[ZYNQMP_FPGA_STATUS_SECURITY_ERR] = "Security-Error",
> +	[ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR] = "Initialization-Error",
> +	[ZYNQMP_FPGA_STATUS_SIGNAL_ERR] = "Internal-Signal-Error",
> +	[ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR] = "I/Os-High-Z-state",
> +	[ZYNQMP_FPGA_STATUS_EOS_ERR] = "Sequence-Error",
> +	[ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR] = "Firmware-Error",
> +};
> +
>  /**
>   * struct zynqmp_fpga_priv - Private data structure
>   * @dev:	Device data structure
> @@ -77,6 +108,54 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
>  	return FPGA_MGR_STATE_UNKNOWN;
>  }
>  
> +static ssize_t status_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	unsigned long status = 0;
> +	ssize_t len = 0;
> +	u32 reg_val;
> +	int ret;
> +	u8 i;
> +
> +	ret = zynqmp_pm_fpga_get_config_status(&reg_val);
> +	if (!ret) {
> +		if (reg_val & IXR_FPGA_ERR_CRC_ERR)
> +			status |= ZYNQMP_FPGA_STATUS_CRC_ERR;
> +		if (reg_val & IXR_FPGA_ERR_SECURITY_ERR)
> +			status |= ZYNQMP_FPGA_STATUS_SECURITY_ERR;
> +		if (!(reg_val & IXR_FPGA_INIT_B_INTERNAL))
> +			status |= ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR;
> +		if (!(reg_val & IXR_FPGA_DONE_INTERNAL_SIGNAL))
> +			status |= ZYNQMP_FPGA_STATUS_SIGNAL_ERR;
> +		if (!(reg_val & IXR_FPGA_GST_CFG_B))
> +			status |= ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR;
> +		if (!(reg_val & IXR_FPGA_END_OF_STARTUP))
> +			status |= ZYNQMP_FPGA_STATUS_EOS_ERR;
> +	} else {
> +		status = ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR;
> +	}
> +
> +	for_each_set_bit(i, &status, ARRAY_SIZE(zynqmp_fpga_error_statuses))
> +		len += sysfs_emit_at(buf, len, "%s ",
> +				     zynqmp_fpga_error_statuses[i]);
> +
> +	if (len)
> +		buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RO(status);
> +
> +static struct attribute *zynqmp_fpga_device_attrs[] = {
> +	&dev_attr_status.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group zynqmp_fpga_attr_group = {
> +	.attrs = zynqmp_fpga_device_attrs,
> +};
> +
>  static const struct fpga_manager_ops zynqmp_fpga_ops = {
>  	.state = zynqmp_fpga_ops_state,
>  	.write_init = zynqmp_fpga_ops_write_init,
> @@ -88,6 +167,7 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct zynqmp_fpga_priv *priv;
>  	struct fpga_manager *mgr;
> +	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -95,6 +175,13 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
>  
>  	priv->dev = dev;
>  
> +	/* Add the device attributes */
> +	ret = sysfs_create_group(&dev->kobj, &zynqmp_fpga_attr_group);
> +	if (ret) {
> +		dev_err(dev, "Error creating sysfs files\n");
> +		return ret;
> +	}
> +
>  	mgr = devm_fpga_mgr_register(dev, "Xilinx ZynqMP FPGA Manager",
>  				     &zynqmp_fpga_ops, priv);
>  	return PTR_ERR_OR_ZERO(mgr);
> -- 
> 2.25.1
> 

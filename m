Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDEA1897B5
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Mar 2020 10:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgCRJPe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Mar 2020 05:15:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:7367 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgCRJPd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Mar 2020 05:15:33 -0400
IronPort-SDR: h80wbmJgEQtgY3IiJrR6+dCI6CeVDscX7tQdrsaFnU+Zq8Bm72nlP4iMsolie90nHopLvu7Io1
 J2EQn/YdDEpg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 02:15:32 -0700
IronPort-SDR: t0n0N9Rb6hjyZ/6StG8DNDrxu56ikUlGASs8jBOdg/hug7WIbn1+S/vbj2nmnPMY4pVQtussNN
 48tFJTyUoXJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; 
   d="scan'208";a="391378387"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga004.jf.intel.com with ESMTP; 18 Mar 2020 02:15:30 -0700
Date:   Wed, 18 Mar 2020 16:54:26 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v2 4/7] fpga: dfl: afu: add interrupt support for error
 reporting
Message-ID: <20200318085426.GA12088@hao-dev>
References: <1584332222-26652-1-git-send-email-yilun.xu@intel.com>
 <1584332222-26652-5-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584332222-26652-5-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Mar 16, 2020 at 12:16:59PM +0800, Xu Yilun wrote:
> Error reporting interrupt is very useful to notify users that some
> errors are detected by the hardware. Once users are notified, they
> could query hardware logged error states, no need to continuously
> poll on these states.
> 
> This patch follows the common DFL interrupt notification and handling
> mechanism, implements two ioctl commands below for user to query
> number of irqs supported, and set/unset interrupt triggers.
> 
>  Ioctls:
>  * DFL_FPGA_PORT_ERR_GET_IRQ_NUM
>    get the number of irqs, which is used to determine whether/how many
>    interrupts error reporting feature supports.
> 
>  * DFL_FPGA_PORT_ERR_SET_IRQ
>    set/unset given eventfds as error interrupt triggers.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ----
> v2: use DFL_FPGA_PORT_ERR_GET_IRQ_NUM instead of
>     DFL_FPGA_PORT_ERR_GET_INFO
>     Delete flag field for DFL_FPGA_PORT_ERR_SET_IRQ param
> ---
>  drivers/fpga/dfl-afu-error.c  | 64 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl-afu-main.c   |  4 +++
>  include/uapi/linux/fpga-dfl.h | 29 ++++++++++++++++++++
>  3 files changed, 97 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index c1467ae..4d478b2f 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include <linux/uaccess.h>
> +#include <linux/fpga-dfl.h>
>  
>  #include "dfl-afu.h"
>  
> @@ -219,6 +220,68 @@ static void port_err_uinit(struct platform_device *pdev,
>  	afu_port_err_mask(&pdev->dev, true);
>  }
>  
> +static long
> +port_err_get_num_irqs(struct platform_device *pdev,
> +		      struct dfl_feature *feature, unsigned long arg)
> +{
> +	if (copy_to_user((void __user *)arg, &feature->nr_irqs,
> +			 sizeof(feature->nr_irqs)))
> +		return -EFAULT;

maybe use put_user is simpler here.

> +
> +	return 0;
> +}
> +
> +static long port_err_set_irq(struct platform_device *pdev,
> +			     struct dfl_feature *feature, unsigned long arg)
> +{
> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct dfl_fpga_irq_set hdr;
> +	s32 *fds;
> +	long ret;
> +
> +	if (!feature->nr_irqs)
> +		return -ENOENT;
> +
> +	if (copy_from_user(&hdr, (void __user *)arg, sizeof(hdr)))
> +		return -EFAULT;
> +
> +	if (!hdr.count || (hdr.start + hdr.count > feature->nr_irqs) ||
> +	    (hdr.start + hdr.count < hdr.start))
> +		return -EINVAL;
> +
> +	fds = memdup_user((void __user *)(arg + sizeof(hdr)),
> +			  hdr.count * sizeof(s32));
> +	if (IS_ERR(fds))
> +		return PTR_ERR(fds);
> +
> +	mutex_lock(&pdata->lock);
> +	ret = dfl_fpga_set_irq_triggers(feature, hdr.start, hdr.count, fds);
> +	mutex_unlock(&pdata->lock);
> +
> +	kfree(fds);
> +	return ret;
> +}
> +
> +static long
> +port_err_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
> +	       unsigned int cmd, unsigned long arg)
> +{
> +	long ret = -ENODEV;
> +
> +	switch (cmd) {
> +	case DFL_FPGA_PORT_ERR_GET_IRQ_NUM:
> +		ret = port_err_get_num_irqs(pdev, feature, arg);
> +		break;
> +	case DFL_FPGA_PORT_ERR_SET_IRQ:
> +		ret = port_err_set_irq(pdev, feature, arg);
> +		break;
> +	default:
> +		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +	}
> +
> +	return ret;
> +}
> +
>  const struct dfl_feature_id port_err_id_table[] = {
>  	{.id = PORT_FEATURE_ID_ERROR,},
>  	{0,}
> @@ -227,4 +290,5 @@ const struct dfl_feature_id port_err_id_table[] = {
>  const struct dfl_feature_ops port_err_ops = {
>  	.init = port_err_init,
>  	.uinit = port_err_uinit,
> +	.ioctl = port_err_ioctl,
>  };
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 435bde4..fc8b9cf 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -577,6 +577,7 @@ static int afu_release(struct inode *inode, struct file *filp)
>  {
>  	struct platform_device *pdev = filp->private_data;
>  	struct dfl_feature_platform_data *pdata;
> +	struct dfl_feature *feature;
>  
>  	dev_dbg(&pdev->dev, "Device File Release\n");
>  
> @@ -586,6 +587,9 @@ static int afu_release(struct inode *inode, struct file *filp)
>  	dfl_feature_dev_use_end(pdata);
>  
>  	if (!dfl_feature_dev_use_count(pdata)) {
> +		dfl_fpga_dev_for_each_feature(pdata, feature)
> +			dfl_fpga_set_irq_triggers(feature, 0,
> +						  feature->nr_irqs, NULL);
>  		__port_reset(pdev);
>  		afu_dma_region_destroy(pdata);
>  	}
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> index ec70a0746..ced859d 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -151,6 +151,35 @@ struct dfl_fpga_port_dma_unmap {
>  
>  #define DFL_FPGA_PORT_DMA_UNMAP		_IO(DFL_FPGA_MAGIC, DFL_PORT_BASE + 4)
>  
> +/**
> + * DFL_FPGA_PORT_ERR_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC, DFL_PORT_BASE + 5,
> + *								__u32 num_irqs)
> + *
> + * Get the number of irqs supported by the fpga port error reporting private
> + * feature.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_PORT_ERR_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,	\
> +					     DFL_PORT_BASE + 5, __u32)
> +
> +/**
> + * DFL_FPGA_PORT_ERR_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_PORT_BASE + 6,
> + *						struct dfl_fpga_irq_set)
> + *
> + * Set fpga port error reporting interrupt trigger if evtfds[n] is valid.
> + * Unset related interrupt trigger if evtfds[n] is a NULL or negative value.

Looks like the code only unset trigger if fd < 0, right?

> + * Return: 0 on success, -errno on failure.
> + */
> +struct dfl_fpga_irq_set {
> +	__u32 start;		/* First irq number */

Sounds a little confusing, what about index of the first irq?


Thanks
Hao

> +	__u32 count;		/* The number of eventfd handler */
> +	__s32 evtfds[];		/* Eventfd handler */
> +};
> +
> +#define DFL_FPGA_PORT_ERR_SET_IRQ	_IOW(DFL_FPGA_MAGIC,	\
> +					     DFL_PORT_BASE + 6,	\
> +					     struct dfl_fpga_irq_set)
> +
>  /* IOCTLs for FME file descriptor */
>  
>  /**
> -- 
> 2.7.4

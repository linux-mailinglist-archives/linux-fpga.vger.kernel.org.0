Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3530118984F
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Mar 2020 10:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgCRJp5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Mar 2020 05:45:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:45501 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbgCRJp5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Mar 2020 05:45:57 -0400
IronPort-SDR: Qc4Y89vwvpIC0vCgvBNc2s1V7BL/xNMxHEfoXtEgXW5kcFDcwwZqK5tQOFwy8UOKl6X/t4ckQZ
 Corccu82C3xg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 02:45:56 -0700
IronPort-SDR: OxdqrP/2H6YOzj6Ef1yxaKxBJR/PhT1/9RETQqlGCJmxwtgUSR7b0JWE5hqy4IxPCyfcbEHUl1
 Fv1dtK9QWMOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; 
   d="scan'208";a="238147863"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2020 02:45:54 -0700
Date:   Wed, 18 Mar 2020 17:24:51 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v2 5/7] fpga: dfl: fme: add interrupt support for global
 error reporting
Message-ID: <20200318092450.GA8501@hao-dev>
References: <1584332222-26652-1-git-send-email-yilun.xu@intel.com>
 <1584332222-26652-6-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584332222-26652-6-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Mar 16, 2020 at 12:17:00PM +0800, Xu Yilun wrote:
> Error reporting interrupt is very useful to notify users that some
> errors are detected by the hardware. Once users are notified, they
> could query hardware logged error states, no need to continuously
> poll on these states.
> 
> This patch follows the common DFL interrupt notification and handling
> mechanism. And it implements two ioctls below for user to query
> number of irqs supported, and set/unset interrupt triggers.
> 
>  Ioctls:
>  * DFL_FPGA_FME_ERR_GET_IRQ_NUM
>    get the number of irqs, which is used to determine whether/how many
>    interrupts fme error reporting feature supports.
> 
>  * DFL_FPGA_FME_ERR_SET_IRQ
>    set/unset given eventfds as fme error reporting interrupt triggers.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ----
> v2: use DFL_FPGA_FME_ERR_GET_IRQ_NUM instead of
>     DFL_FPGA_FME_ERR_GET_INFO
>     Delete flags field for DFL_FPGA_FME_ERR_SET_IRQ
> ---
>  drivers/fpga/dfl-fme-error.c  | 66 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl-fme-main.c   |  6 ++++
>  include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
> index f897d41..42853e6 100644
> --- a/drivers/fpga/dfl-fme-error.c
> +++ b/drivers/fpga/dfl-fme-error.c
> @@ -16,6 +16,7 @@
>   */
>  
>  #include <linux/uaccess.h>
> +#include <linux/fpga-dfl.h>
>  
>  #include "dfl.h"
>  #include "dfl-fme.h"
> @@ -348,6 +349,70 @@ static void fme_global_err_uinit(struct platform_device *pdev,
>  	fme_err_mask(&pdev->dev, true);
>  }
>  
> +static long
> +fme_global_err_get_num_irqs(struct platform_device *pdev,
> +			    struct dfl_feature *feature, unsigned long arg)
> +{
> +	if (copy_to_user((void __user *)arg, &feature->nr_irqs,
> +			 sizeof(feature->nr_irqs)))
> +		return -EFAULT;

Per my understanding, if it returns more than 1 to userspace, then how should
userspce deal with it? or we can add some code (maybe in framework parsing code)
to support 1 interrupt only for now, as all existing hardwares only use 1 irq
for error reporing?

Hao

> +
> +	return 0;
> +}
> +
> +static long
> +fme_global_err_set_irq(struct platform_device *pdev,
> +		       struct dfl_feature *feature, unsigned long arg)
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
> +fme_global_error_ioctl(struct platform_device *pdev,
> +		       struct dfl_feature *feature,
> +		       unsigned int cmd, unsigned long arg)
> +{
> +	long ret = -ENODEV;
> +
> +	switch (cmd) {
> +	case DFL_FPGA_FME_ERR_GET_IRQ_NUM:
> +		ret = fme_global_err_get_num_irqs(pdev, feature, arg);
> +		break;
> +	case DFL_FPGA_FME_ERR_SET_IRQ:
> +		ret = fme_global_err_set_irq(pdev, feature, arg);
> +		break;
> +	default:
> +		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +	}
> +
> +	return ret;
> +}
> +
>  const struct dfl_feature_id fme_global_err_id_table[] = {
>  	{.id = FME_FEATURE_ID_GLOBAL_ERR,},
>  	{0,}
> @@ -356,4 +421,5 @@ const struct dfl_feature_id fme_global_err_id_table[] = {
>  const struct dfl_feature_ops fme_global_err_ops = {
>  	.init = fme_global_err_init,
>  	.uinit = fme_global_err_uinit,
> +	.ioctl = fme_global_error_ioctl,
>  };
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 56d720c..ab3722d 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -616,11 +616,17 @@ static int fme_release(struct inode *inode, struct file *filp)
>  {
>  	struct dfl_feature_platform_data *pdata = filp->private_data;
>  	struct platform_device *pdev = pdata->dev;
> +	struct dfl_feature *feature;
>  
>  	dev_dbg(&pdev->dev, "Device File Release\n");
>  
>  	mutex_lock(&pdata->lock);
>  	dfl_feature_dev_use_end(pdata);
> +
> +	if (!dfl_feature_dev_use_count(pdata))
> +		dfl_fpga_dev_for_each_feature(pdata, feature)
> +			dfl_fpga_set_irq_triggers(feature, 0,
> +						  feature->nr_irqs, NULL);
>  	mutex_unlock(&pdata->lock);
>  
>  	return 0;
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> index ced859d..dc8d370 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -223,4 +223,27 @@ struct dfl_fpga_fme_port_pr {
>   */
>  #define DFL_FPGA_FME_PORT_ASSIGN     _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 2, int)
>  
> +/**
> + * DFL_FPGA_FME_ERR_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC, DFL_FME_BASE + 3,
> + *							__u32 num_irqs)
> + *
> + * Get the number of irqs supported by the fpga fme error reporting private
> + * feature.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_FME_ERR_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,	\
> +					     DFL_FME_BASE + 3, __u32)
> +
> +/**
> + * DFL_FPGA_FME_ERR_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 4,
> + *						struct dfl_fpga_irq_set)
> + *
> + * Set fpga fme error reporting interrupt trigger if evtfds[n] is valid.
> + * Unset related interrupt trigger if evtfds[n] is a NULL or negative value.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_FME_ERR_SET_IRQ	_IOW(DFL_FPGA_MAGIC,	\
> +					     DFL_FME_BASE + 4,	\
> +					     struct dfl_fpga_irq_set)
> +
>  #endif /* _UAPI_LINUX_FPGA_DFL_H */
> -- 
> 2.7.4

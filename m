Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA1C198BC3
	for <lists+linux-fpga@lfdr.de>; Tue, 31 Mar 2020 07:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCaFhK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 31 Mar 2020 01:37:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:53458 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgCaFhK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 31 Mar 2020 01:37:10 -0400
IronPort-SDR: UKCIs8ZDTQJMdR3SA3OIPM4MX+7Bm8PjNR6KacFKA7LGPQejE53bUiuOB+ZN5xfS8LOWVZyX4u
 8CZbxUWGVsIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 22:37:09 -0700
IronPort-SDR: TXGEI3hxGd5bYIrxUwKqjAN1IWb/WolMsgW5slK7TTzDOvE+L0hDjPNYt2eTORXaFifU70Anzy
 Qfr8xIcucoEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="267163647"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2020 22:37:07 -0700
Date:   Tue, 31 Mar 2020 13:15:50 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v3 6/7] fpga: dfl: afu: add user interrupt support
Message-ID: <20200331051550.GE8468@hao-dev>
References: <1585038763-22944-1-git-send-email-yilun.xu@intel.com>
 <1585038763-22944-7-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585038763-22944-7-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Mar 24, 2020 at 04:32:42PM +0800, Xu Yilun wrote:
> AFU (Accelerated Function Unit) is dynamic region of the DFL based FPGA,
> and always defined by users. Some DFL based FPGA cards allow users to
> implement their own interrupts in AFU. In order to support this,
> hardware implements a new UINT (User Interrupt) private feature with

User Interrupt seems a little confusing, maybe we can just call it
AFU Interrupt whenever possible. How do you think?

Thanks
Hao

> related capability register which describes the number of supported
> user interrupts as well as the local index of the interrupts for
> software enumeration, and from software side, driver follows the common
> DFL interrupt notification and handling mechanism, and it implements
> two ioctls below for user to query number of irqs supported and set/unset
> interrupt triggers.
> 
>  Ioctls:
>  * DFL_FPGA_PORT_UINT_GET_IRQ_NUM
>    get the number of irqs, which is used to determine how many interrupts
>    UINT feature supports.
> 
>  * DFL_FPGA_PORT_UINT_SET_IRQ
>    set/unset eventfds as AFU user interrupt triggers.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ----
> v2: use DFL_FPGA_PORT_UINT_GET_IRQ_NUM instead of
>     DFL_FPGA_PORT_UINT_GET_INFO
>     Delete flags field for DFL_FPGA_PORT_UINT_SET_IRQ
> v3: put_user() instead of copy_to_user()
>     improves comments
> ---
>  drivers/fpga/dfl-afu-main.c   | 70 +++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fpga-dfl.h | 23 ++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 357cd5d..d2db5b6 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -529,6 +529,72 @@ static const struct dfl_feature_ops port_stp_ops = {
>  	.init = port_stp_init,
>  };
>  
> +static long
> +port_uint_get_num_irqs(struct platform_device *pdev,
> +		       struct dfl_feature *feature, unsigned long arg)
> +{
> +	return put_user(feature->nr_irqs, (__u32 __user *)arg);
> +}
> +
> +static long port_uint_set_irq(struct platform_device *pdev,
> +			      struct dfl_feature *feature, unsigned long arg)
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
> +port_uint_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
> +		unsigned int cmd, unsigned long arg)
> +{
> +	long ret = -ENODEV;
> +
> +	switch (cmd) {
> +	case DFL_FPGA_PORT_UINT_GET_IRQ_NUM:
> +		ret = port_uint_get_num_irqs(pdev, feature, arg);
> +		break;
> +	case DFL_FPGA_PORT_UINT_SET_IRQ:
> +		ret = port_uint_set_irq(pdev, feature, arg);
> +		break;
> +	default:
> +		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +	}
> +	return ret;
> +}
> +
> +static const struct dfl_feature_id port_uint_id_table[] = {
> +	{.id = PORT_FEATURE_ID_UINT,},
> +	{0,}
> +};
> +
> +static const struct dfl_feature_ops port_uint_ops = {
> +	.ioctl = port_uint_ioctl,
> +};
> +
>  static struct dfl_feature_driver port_feature_drvs[] = {
>  	{
>  		.id_table = port_hdr_id_table,
> @@ -547,6 +613,10 @@ static struct dfl_feature_driver port_feature_drvs[] = {
>  		.ops = &port_stp_ops,
>  	},
>  	{
> +		.id_table = port_uint_id_table,
> +		.ops = &port_uint_ops,
> +	},
> +	{
>  		.ops = NULL,
>  	}
>  };
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> index 206bad9..5f885a8 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -180,6 +180,29 @@ struct dfl_fpga_irq_set {
>  					     DFL_PORT_BASE + 6,	\
>  					     struct dfl_fpga_irq_set)
>  
> +/**
> + * DFL_FPGA_PORT_UINT_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC, DFL_PORT_BASE + 7,
> + *								__u32 num_irqs)
> + *
> + * Get the number of irqs supported by the fpga AFU user interrupt private
> + * feature.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_PORT_UINT_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,	\
> +					     DFL_PORT_BASE + 7, __u32)
> +
> +/**
> + * DFL_FPGA_PORT_UINT_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_PORT_BASE + 8,
> + *						struct dfl_fpga_irq_set)
> + *
> + * Set fpga afu user interrupt trigger if evtfds[n] is valid.
> + * Unset related interrupt trigger if evtfds[n] is a negative value.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_PORT_UINT_SET_IRQ	_IOW(DFL_FPGA_MAGIC,	\
> +					     DFL_PORT_BASE + 8,	\
> +					     struct dfl_fpga_irq_set)
> +
>  /* IOCTLs for FME file descriptor */
>  
>  /**
> -- 
> 2.7.4

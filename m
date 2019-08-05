Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB5E820D4
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Aug 2019 17:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfHEPyl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Aug 2019 11:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbfHEPyl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Aug 2019 11:54:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED53B208C3;
        Mon,  5 Aug 2019 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565020479;
        bh=Ge2ufb/SX7rcBiIlGvKHNvollR0zNguSF20IS9RQzHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xJmRRMK6IIx7SdNrlzC3u6VrU8phCkOK2GsFAC62yEhqnkqlq/G7VnoNiU2j1UyJc
         UUOzu2pMy4SK/pBSS343gzFDwoMT4Ha9QvnsV3xsv6AkapCIy/k7WckcGsIBzSWMSC
         EKKTdgbwiSu69Jym6fXHuZSGjvj503Xr0WfVqrI4=
Date:   Mon, 5 Aug 2019 17:54:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v4 07/12] fpga: dfl: afu: add error reporting support.
Message-ID: <20190805155437.GC8107@kroah.com>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
 <1564914022-3710-8-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564914022-3710-8-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Aug 04, 2019 at 06:20:17PM +0800, Wu Hao wrote:
> Error reporting is one important private feature, it reports error
> detected on port and accelerated function unit (AFU). It introduces
> several sysfs interfaces to allow userspace to check and clear
> errors detected by hardware.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: switch to device_add/remove_group for sysfs.
> v3: update kernel version and date in sysfs doc
> v4: remove dev_dbg in init/uinit callback function.
> ---
>  Documentation/ABI/testing/sysfs-platform-dfl-port |  39 ++++
>  drivers/fpga/Makefile                             |   1 +
>  drivers/fpga/dfl-afu-error.c                      | 221 ++++++++++++++++++++++
>  drivers/fpga/dfl-afu-main.c                       |   4 +
>  drivers/fpga/dfl-afu.h                            |   4 +
>  5 files changed, 269 insertions(+)
>  create mode 100644 drivers/fpga/dfl-afu-error.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
> index 5663441..3b6580b 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-port
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
> @@ -81,3 +81,42 @@ KernelVersion:	5.4
>  Contact:	Wu Hao <hao.wu@intel.com>
>  Description:	Read-only. Read this file to get the status of issued command
>  		to userclck_freqcntrcmd.
> +
> +What:		/sys/bus/platform/devices/dfl-port.0/errors/revision
> +Date:		August 2019
> +KernelVersion:	5.4
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. Read this file to get the revision of this error
> +		reporting private feature.

Same revision question here that I had on an earlier patch.


> +
> +What:		/sys/bus/platform/devices/dfl-port.0/errors/errors
> +Date:		August 2019
> +KernelVersion:	5.4
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. Read this file to get errors detected on port and
> +		Accelerated Function Unit (AFU).
> +
> +What:		/sys/bus/platform/devices/dfl-port.0/errors/first_error
> +Date:		August 2019
> +KernelVersion:	5.4
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. Read this file to get the first error detected by
> +		hardware.
> +
> +What:		/sys/bus/platform/devices/dfl-port.0/errors/first_malformed_req
> +Date:		August 2019
> +KernelVersion:	5.4
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. Read this file to get the first malformed request
> +		captured by hardware.
> +
> +What:		/sys/bus/platform/devices/dfl-port.0/errors/clear
> +Date:		August 2019
> +KernelVersion:	5.4
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Write-only. Write error code to this file to clear errors.
> +		Write fails with -EINVAL if input parsing fails or input error
> +		code doesn't match.
> +		Write fails with -EBUSY or -ETIMEDOUT if error can't be cleared
> +		as hardware is in low power state (-EBUSY) or not responding
> +		(-ETIMEDOUT).
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 312b937..7255891 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_FPGA_DFL_AFU)		+= dfl-afu.o
>  
>  dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
>  dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
> +dfl-afu-objs += dfl-afu-error.o
>  
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> new file mode 100644
> index 0000000..c5e0efa
> --- /dev/null
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for FPGA Accelerated Function Unit (AFU) Error Reporting
> + *
> + * Copyright 2019 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Wu Hao <hao.wu@linux.intel.com>
> + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + *   Joseph Grecco <joe.grecco@intel.com>
> + *   Enno Luebbers <enno.luebbers@intel.com>
> + *   Tim Whisonant <tim.whisonant@intel.com>
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + *   Mitchel Henry <henry.mitchel@intel.com>
> + */
> +
> +#include <linux/uaccess.h>
> +
> +#include "dfl-afu.h"
> +
> +#define PORT_ERROR_MASK		0x8
> +#define PORT_ERROR		0x10
> +#define PORT_FIRST_ERROR	0x18
> +#define PORT_MALFORMED_REQ0	0x20
> +#define PORT_MALFORMED_REQ1	0x28
> +
> +#define ERROR_MASK		GENMASK_ULL(63, 0)
> +
> +/* mask or unmask port errors by the error mask register. */
> +static void __port_err_mask(struct device *dev, bool mask)
> +{
> +	void __iomem *base;
> +
> +	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +
> +	writeq(mask ? ERROR_MASK : 0, base + PORT_ERROR_MASK);
> +}
> +
> +/* clear port errors. */
> +static int __port_err_clear(struct device *dev, u64 err)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	void __iomem *base_err, *base_hdr;
> +	int ret;
> +	u64 v;
> +
> +	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +	base_hdr = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> +
> +	/*
> +	 * clear Port Errors
> +	 *
> +	 * - Check for AP6 State
> +	 * - Halt Port by keeping Port in reset
> +	 * - Set PORT Error mask to all 1 to mask errors
> +	 * - Clear all errors
> +	 * - Set Port mask to all 0 to enable errors
> +	 * - All errors start capturing new errors
> +	 * - Enable Port by pulling the port out of reset
> +	 */
> +
> +	/* if device is still in AP6 power state, can not clear any error. */
> +	v = readq(base_hdr + PORT_HDR_STS);
> +	if (FIELD_GET(PORT_STS_PWR_STATE, v) == PORT_STS_PWR_STATE_AP6) {
> +		dev_err(dev, "Could not clear errors, device in AP6 state.\n");
> +		return -EBUSY;
> +	}
> +
> +	/* Halt Port by keeping Port in reset */
> +	ret = __port_disable(pdev);
> +	if (ret)
> +		return ret;
> +
> +	/* Mask all errors */
> +	__port_err_mask(dev, true);
> +
> +	/* Clear errors if err input matches with current port errors.*/
> +	v = readq(base_err + PORT_ERROR);
> +
> +	if (v == err) {
> +		writeq(v, base_err + PORT_ERROR);
> +
> +		v = readq(base_err + PORT_FIRST_ERROR);
> +		writeq(v, base_err + PORT_FIRST_ERROR);
> +	} else {
> +		ret = -EINVAL;
> +	}
> +
> +	/* Clear mask */
> +	__port_err_mask(dev, false);
> +
> +	/* Enable the Port by clear the reset */
> +	__port_enable(pdev);
> +
> +	return ret;
> +}
> +
> +static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	void __iomem *base;
> +
> +	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +
> +	return sprintf(buf, "%u\n", dfl_feature_revision(base));
> +}
> +static DEVICE_ATTR_RO(revision);
> +
> +static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +	void __iomem *base;
> +	u64 error;
> +
> +	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +
> +	mutex_lock(&pdata->lock);
> +	error = readq(base + PORT_ERROR);
> +	mutex_unlock(&pdata->lock);
> +
> +	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
> +}
> +static DEVICE_ATTR_RO(errors);
> +
> +static ssize_t first_error_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +	void __iomem *base;
> +	u64 error;
> +
> +	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +
> +	mutex_lock(&pdata->lock);
> +	error = readq(base + PORT_FIRST_ERROR);
> +	mutex_unlock(&pdata->lock);
> +
> +	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
> +}
> +static DEVICE_ATTR_RO(first_error);
> +
> +static ssize_t first_malformed_req_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +	void __iomem *base;
> +	u64 req0, req1;
> +
> +	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> +
> +	mutex_lock(&pdata->lock);
> +	req0 = readq(base + PORT_MALFORMED_REQ0);
> +	req1 = readq(base + PORT_MALFORMED_REQ1);
> +	mutex_unlock(&pdata->lock);
> +
> +	return sprintf(buf, "0x%016llx%016llx\n",
> +		       (unsigned long long)req1, (unsigned long long)req0);
> +}
> +static DEVICE_ATTR_RO(first_malformed_req);
> +
> +static ssize_t clear_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buff, size_t count)
> +{
> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
> +	u64 value;
> +	int ret;
> +
> +	if (kstrtou64(buff, 0, &value))
> +		return -EINVAL;
> +
> +	mutex_lock(&pdata->lock);
> +	ret = __port_err_clear(dev, value);
> +	mutex_unlock(&pdata->lock);
> +
> +	return ret ? ret : count;
> +}
> +static DEVICE_ATTR_WO(clear);
> +
> +static struct attribute *port_err_attrs[] = {
> +	&dev_attr_revision.attr,
> +	&dev_attr_errors.attr,
> +	&dev_attr_first_error.attr,
> +	&dev_attr_first_malformed_req.attr,
> +	&dev_attr_clear.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group port_err_attr_group = {
> +	.attrs = port_err_attrs,
> +	.name = "errors",
> +};
> +
> +static int port_err_init(struct platform_device *pdev,
> +			 struct dfl_feature *feature)
> +{
> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +
> +	mutex_lock(&pdata->lock);
> +	__port_err_mask(&pdev->dev, false);
> +	mutex_unlock(&pdata->lock);

Locking one data structure and then modifying another one is up there
with "things never to do in the kernel unless you want a huge
headache!".

> +
> +	return device_add_group(&pdev->dev, &port_err_attr_group);

You raced userspace and lost :(

thanks,

greg k-h

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595DF28A340
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Oct 2020 01:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390467AbgJJW5T (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 10 Oct 2020 18:57:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbgJJVWC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 10 Oct 2020 17:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602364914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxt26sTm5PuU4vYueez9r5s7BdXKovxCvnzsJs9O6RI=;
        b=F8oYLntoclnxaWsP28zUlRBwdU6yt53HbcHglN9TY9vn4vjupvf4GJE/L7zmH/qT+I4+9s
        eUcc1ukqjHI+bEoytKz2V4u1mQbyYzH/zUiiyzl4fEoG04WIWDvoAt5Q0LsUw2zMjm1WOU
        JJj2Z8urQb/K/AQDSl9nnFqHmGZ61tI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-QgYqNlgCO0em9ijoWq9dKw-1; Sat, 10 Oct 2020 17:21:50 -0400
X-MC-Unique: QgYqNlgCO0em9ijoWq9dKw-1
Received: by mail-oi1-f198.google.com with SMTP id b22so5926511oib.8
        for <linux-fpga@vger.kernel.org>; Sat, 10 Oct 2020 14:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oxt26sTm5PuU4vYueez9r5s7BdXKovxCvnzsJs9O6RI=;
        b=ZvPDvlJfirDsB0caOboUKlMi8vO4g9bpjoPzcPTXm6uYgJByaZctkzyDs152iwh6o9
         fxZ/QKSJAXG7bEj3tutpoduR4wI+UyCaXygMZcaHcpMvHgq/B8iPddc77529eGcYw7d5
         bMyOhqDmOfrKDbHLzSmmF4RQQ/G4jnrw8eaASQrQt73wQ0c27oWW54LBrfzVWlGgnOx4
         o+TRQKS73J6CiGDqxmwKuqr45rAy1Z/h+xx2cr1MBQZ3k/7je5gd20xgMXvxZJYwjDFz
         In6KEqEtMmESgKX8Y8iZ3gnmF5K5bqXvWrIEGZ13uI+F7u6W+kEKrDB7G44OjtmyUnd+
         KM9w==
X-Gm-Message-State: AOAM531lWi8tdVjVj5GyOXm1lfB93nWAAZ6VMw7IdFPL503HyA7uch2K
        +DeaSOWo/YzCkU1oToY0O3UyqPTKZ/DHirAdq2wTsvSmn4qqtA67W3VtannoDoCrP8UftDFeuyg
        0KWHiT62kKzKN7JTWoUW5KA==
X-Received: by 2002:a05:6830:1151:: with SMTP id x17mr11237132otq.302.1602364908971;
        Sat, 10 Oct 2020 14:21:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEHT9T4TY+zdDKxym8YjLYe1uI8vmiS00KmNKDesTQsmLhjm60k+FRcB1KJ16thPTIMlGdFg==
X-Received: by 2002:a05:6830:1151:: with SMTP id x17mr11237113otq.302.1602364908482;
        Sat, 10 Oct 2020 14:21:48 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g124sm8513847oia.58.2020.10.10.14.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 14:21:47 -0700 (PDT)
Subject: Re: [PATCH v9 5/6] fpga: dfl: add support for N3000 Nios private
 feature
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, krzk@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
 <1602313793-21421-6-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a45712ea-7891-344b-4fd8-d583968949f2@redhat.com>
Date:   Sat, 10 Oct 2020 14:21:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1602313793-21421-6-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/10/20 12:09 AM, Xu Yilun wrote:
> This patch adds support for the Nios handshake private feature on Intel
> PAC (Programmable Acceleration Card) N3000.
>
> The Nios is the embedded processor on the FPGA card. This private feature
> provides a handshake interface to FPGA Nios firmware, which receives
> retimer configuration command from host and executes via an internal SPI
> master (spi-altera). When Nios finishes the configuration, host takes over
> the ownership of the SPI master to control an Intel MAX10 BMC (Board
> Management Controller) Chip on the SPI bus.
>
> For Nios firmware handshake part, this driver requests the retimer
> configuration for Nios firmware on probe, and adds some sysfs nodes for
> user to query the onboard retimer's working mode and Nios firmware
> version.
>
> For SPI part, this driver adds a spi-altera platform device as well as
> the MAX10 BMC spi slave info. A spi-altera driver will be matched to
> handle the following SPI work.
>
> [mdf@kernel.org: Fixed up MAINTAINERS file to include added ABI doc]
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v3: add the doc for this driver
>     minor fixes for comments from Tom
> v4: move the err log in regmap implementation, and delete
>      n3000_nios_writel/readl(), they have nothing to wrapper now.
>     some minor fixes and comments improvement.
> v5: fix the output of fec_mode sysfs inf to "no" on 10G configuration,
>      cause no FEC mode could be configured for 10G.
>     rename the dfl_n3000_nios_* to n3000_nios_*
>     improves comments.
> v6: fix the output of fec_mode sysfs inf to "not supported" if in 10G,
>      or the firmware version major < 3.
>     minor fixes and improves comments.
> v7: improves comments.
> v8: add sysfs interfaces for retimer mode, also doc update.
>     delete duplicated sysfs interfaces description in doc.
>     minor fixes.
> v9: delete the retimer FEC mode configuration via module_parameter.
>     update the kernel version of the sysfs interfaces in Doc.
>     merge the patch "Make m10_n3000_info static" (https://lore.kernel.org/linux-fpga/52d8411e-13d8-1e91-756d-131802f5f445@huawei.com/T/#t)
>     remove the tags of Maintainers, this implementation is changed.
> ---
>  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  47 ++
>  MAINTAINERS                                        |   2 +-
>  drivers/fpga/Kconfig                               |  11 +
>  drivers/fpga/Makefile                              |   2 +
>  drivers/fpga/dfl-n3000-nios.c                      | 566 +++++++++++++++++++++
>  5 files changed, 627 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
>  create mode 100644 drivers/fpga/dfl-n3000-nios.c
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> new file mode 100644
> index 0000000..f2f6e5e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> @@ -0,0 +1,47 @@
> +What:		/sys/bus/dfl/devices/dfl_dev.X/fec_mode
> +Date:		Oct 2020
> +KernelVersion:	5.11
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns the FEC mode of the 25G links of the
Could drop the 'It' and start with 'Returns'  here and similar
> +		ethernet retimers configured by Nios firmware. "rs" for Reed
> +		Solomon FEC, "kr" for Fire Code FEC, "no" for NO FEC.
> +		"not supported" if the FEC mode setting is not supported, this
setting ? the description says 'Read-only'
> +		happens when the Nios firmware version major < 3, or no link is
> +		configured to 25G.
> +		Format: string
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/retimer_A_mode
> +Date:		Oct 2020
> +KernelVersion:	5.11
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns the enumeration value of the working mode
> +		of the retimer A configured by the Nios firmware. The value is
> +		read out from shared registers filled by the Nios firmware. Now
> +		the values could be:
> +
> +		- "0": Reset
> +		- "1": 4x10G
> +		- "2": 4x25G
> +		- "3": 2x25G
> +		- "4": 2x25G+2x10G
> +		- "5": 1x25G
> +
> +		If the Nios firmware is updated in future to support more
> +		retimer modes, more enumeration value is expected. 
> +		Format: 0x%x
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/retimer_B_mode
> +Date:		Oct 2020
> +KernelVersion:	5.11
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns the enumeration value of the working mode
> +		of the retimer B configured by the Nios firmware. The value
> +		format is the same as retimer_A_mode.
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/nios_fw_version
> +Date:		Oct 2020
> +KernelVersion:	5.11
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. It returns the version of the Nios firmware in FPGA.
Can drop 'in FPGA'.
> +		Its format is "major.minor.patch".
> +		Format: %x.%x.%x
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d46097..3a81cac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6881,7 +6881,7 @@ M:	Wu Hao <hao.wu@intel.com>
>  R:	Tom Rix <trix@redhat.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/ABI/testing/sysfs-bus-dfl
> +F:	Documentation/ABI/testing/sysfs-bus-dfl*
>  F:	Documentation/fpga/dfl.rst
>  F:	drivers/fpga/dfl*
>  F:	include/linux/fpga/dfl.h
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 7cd5a29..38c7130 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -191,6 +191,17 @@ config FPGA_DFL_AFU
>  	  to the FPGA infrastructure via a Port. There may be more than one
>  	  Port/AFU per DFL based FPGA device.
>  
> +config FPGA_DFL_NIOS_INTEL_PAC_N3000
> +        tristate "FPGA DFL NIOS Driver for Intel PAC N3000"
> +        depends on FPGA_DFL
Would 'depends on FPGA_DFL_PCI' be better ?
> +        select REGMAP
> +        help
Last 3 lines have whitespace issues, need to convert spaces to tabs
> +	  This is the driver for the N3000 Nios private feature on Intel
> +	  PAC (Programmable Acceleration Card) N3000. It communicates
> +	  with the embedded Nios processor to configure the retimers on
> +	  the card. It also instantiates the SPI master (spi-altera) for
> +	  the card's BMC (Board Management Controller) control.

can drop 'control'

If you read out 'card's board mangement controller control' it sounds awkward.

> +
>  config FPGA_DFL_PCI
>  	tristate "FPGA DFL PCIe Device Driver"
>  	depends on PCI && FPGA_DFL
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index d8e21df..18dc9885 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -44,5 +44,7 @@ dfl-fme-objs += dfl-fme-perf.o
>  dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
>  dfl-afu-objs += dfl-afu-error.o
>  
> +obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
> +
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
> new file mode 100644
> index 0000000..e7c3862
> --- /dev/null
> +++ b/drivers/fpga/dfl-n3000-nios.c
> @@ -0,0 +1,566 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DFL device driver for Nios private feature on Intel PAC (Programmable
> + * Acceleration Card) N3000
> + *
> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Wu Hao <hao.wu@intel.com>
> + *   Xu Yilun <yilun.xu@intel.com>
> + */
> +#include <linux/bitfield.h>
> +#include <linux/errno.h>
> +#include <linux/fpga/dfl.h>
> +#include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/stddef.h>
> +#include <linux/spi/altera.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +
> +/* N3000 Nios private feature registers */
> +#define NIOS_SPI_PARAM			0x8

The #defines should have a consistent prefix that is unlikely to conflict.

Maybe N3000_NIOS_

> +#define PARAM_SHIFT_MODE_MSK		BIT_ULL(1)
> +#define PARAM_SHIFT_MODE_MSB		0
> +#define PARAM_SHIFT_MODE_LSB		1
> +#define PARAM_DATA_WIDTH		GENMASK_ULL(7, 2)
> +#define PARAM_NUM_CS			GENMASK_ULL(13, 8)
> +#define PARAM_CLK_POL			BIT_ULL(14)
> +#define PARAM_CLK_PHASE			BIT_ULL(15)
> +#define PARAM_PERIPHERAL_ID		GENMASK_ULL(47, 32)
> +
> +#define NIOS_SPI_CTRL			0x10
> +#define CTRL_WR_DATA			GENMASK_ULL(31, 0)
> +#define CTRL_ADDR			GENMASK_ULL(44, 32)
> +#define CTRL_CMD_MSK			GENMASK_ULL(63, 62)
> +#define CTRL_CMD_NOP			0
> +#define CTRL_CMD_RD			1
> +#define CTRL_CMD_WR			2
> +
> +#define NIOS_SPI_STAT			0x18
> +#define STAT_RD_DATA			GENMASK_ULL(31, 0)
> +#define STAT_RW_VAL			BIT_ULL(32)
> +
> +/* Nios handshake registers, indirect access */
> +#define NIOS_INIT			0x1000
> +#define NIOS_INIT_DONE			BIT(0)
> +#define NIOS_INIT_START			BIT(1)
> +/* Mode for retimer A, link 0, the same below */
> +#define REQ_FEC_MODE_A0_MSK		GENMASK(9, 8)
> +#define REQ_FEC_MODE_A1_MSK		GENMASK(11, 10)
> +#define REQ_FEC_MODE_A2_MSK		GENMASK(13, 12)
> +#define REQ_FEC_MODE_A3_MSK		GENMASK(15, 14)
> +#define REQ_FEC_MODE_B0_MSK		GENMASK(17, 16)
> +#define REQ_FEC_MODE_B1_MSK		GENMASK(19, 18)
> +#define REQ_FEC_MODE_B2_MSK		GENMASK(21, 20)
> +#define REQ_FEC_MODE_B3_MSK		GENMASK(23, 22)
> +#define REQ_FEC_MODE_NO			0x0
> +#define REQ_FEC_MODE_KR			0x1
> +#define REQ_FEC_MODE_RS			0x2
> +
> +#define NIOS_FW_VERSION			0x1004
> +#define NIOS_FW_VERSION_PATCH		GENMASK(23, 20)
> +#define NIOS_FW_VERSION_MINOR		GENMASK(27, 24)
> +#define NIOS_FW_VERSION_MAJOR		GENMASK(31, 28)
> +
> +/* The retimers we use on Intel PAC N3000 is Parkvale, abbreviated to PKVL */
Parkvale is codename, why not just RETIMER_ ?
> +#define PKVL_A_MODE_STS			0x1020
> +#define PKVL_B_MODE_STS			0x1024
> +#define PKVL_MODE_STS_GROUP_MSK		GENMASK(15, 8)
> +#define PKVL_MODE_STS_GROUP_OK		0x0
> +#define PKVL_MODE_STS_ID_MSK		GENMASK(7, 0)
> +/* When GROUP MASK field == GROUP_OK  */
> +#define PKVL_MODE_ID_RESET		0x0
> +#define PKVL_MODE_ID_4X10G		0x1
> +#define PKVL_MODE_ID_4X25G		0x2
> +#define PKVL_MODE_ID_2X25G		0x3
> +#define PKVL_MODE_ID_2X25G_2X10G	0x4
> +#define PKVL_MODE_ID_1X25G		0x5
> +
> +#define NS_REGBUS_WAIT_TIMEOUT		10000		/* loop count */

NS ? Expand.

'WAIT_TIMEOUT' should be changed to 'RETRY_COUNT' to reflect its use

> +#define NIOS_INIT_TIMEOUT		10000000	/* usec */
> +#define NIOS_INIT_TIME_INTV		100000		/* usec */
> +
> +struct n3000_nios {
> +	void __iomem *base;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct platform_device *altera_spi;
> +};
> +
> +static ssize_t nios_fw_version_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct n3000_nios *ns = dev_get_drvdata(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(ns->regmap, NIOS_FW_VERSION, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%x.%x.%x\n",
> +		       (u8)FIELD_GET(NIOS_FW_VERSION_MAJOR, val),
> +		       (u8)FIELD_GET(NIOS_FW_VERSION_MINOR, val),
> +		       (u8)FIELD_GET(NIOS_FW_VERSION_PATCH, val));
> +}
> +static DEVICE_ATTR_RO(nios_fw_version);
> +
> +#define IS_MODE_STATUS_OK(mode_stat)				\
> +	(FIELD_GET(PKVL_MODE_STS_GROUP_MSK, (mode_stat)) ==	\
> +	 PKVL_MODE_STS_GROUP_OK)
> +
> +#define IS_RETIMER_FEC_SUPPORTED(retimer_mode)	\
> +	((retimer_mode) != PKVL_MODE_ID_RESET &&	\
> +	 (retimer_mode) != PKVL_MODE_ID_4X10G)
> +
> +static int get_retimer_mode(struct n3000_nios *ns, unsigned int mode_stat_reg,
> +			    unsigned int *retimer_mode)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(ns->regmap, mode_stat_reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (!IS_MODE_STATUS_OK(val))
> +		return -EFAULT;
> +
> +	*retimer_mode = FIELD_GET(PKVL_MODE_STS_ID_MSK, val);
> +
> +	return 0;
> +}
> +
> +static ssize_t retimer_A_mode_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct n3000_nios *ns = dev_get_drvdata(dev);
> +	unsigned int mode;
> +	int ret;
> +
> +	ret = get_retimer_mode(ns, PKVL_A_MODE_STS, &mode);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "0x%x\n", mode);
> +}
> +static DEVICE_ATTR_RO(retimer_A_mode);
> +
> +static ssize_t retimer_B_mode_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct n3000_nios *ns = dev_get_drvdata(dev);
> +	unsigned int mode;
> +	int ret;
> +
> +	ret = get_retimer_mode(ns, PKVL_B_MODE_STS, &mode);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "0x%x\n", mode);
> +}
> +static DEVICE_ATTR_RO(retimer_B_mode);
> +
> +static ssize_t fec_mode_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	unsigned int val, retimer_a_mode, retimer_b_mode, fec_mode;
> +	struct n3000_nios *ns = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* FEC mode setting is not supported in early FW versions */
> +	ret = regmap_read(ns->regmap, NIOS_FW_VERSION, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(NIOS_FW_VERSION_MAJOR, val) < 3)
> +		return sprintf(buf, "not supported\n");
> +
> +	/* If no 25G links, FEC mode setting is not supported either */
> +	ret = get_retimer_mode(ns, PKVL_A_MODE_STS, &retimer_a_mode);
> +	if (ret)
> +		return ret;
> +
> +	ret = get_retimer_mode(ns, PKVL_B_MODE_STS, &retimer_b_mode);
> +	if (ret)
> +		return ret;
> +
> +	if (!IS_RETIMER_FEC_SUPPORTED(retimer_a_mode) &&
> +	    !IS_RETIMER_FEC_SUPPORTED(retimer_b_mode))
> +		return sprintf(buf, "not supported\n");
> +
> +	/* get the valid FEC mode for 25G links */
> +	ret = regmap_read(ns->regmap, NIOS_INIT, &val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * FEC mode should always be the same for all links, as we set them
> +	 * in this way.
> +	 */
> +	fec_mode = FIELD_GET(REQ_FEC_MODE_A0_MSK, val);
> +	if (fec_mode != FIELD_GET(REQ_FEC_MODE_A1_MSK, val) ||
> +	    fec_mode != FIELD_GET(REQ_FEC_MODE_A2_MSK, val) ||
> +	    fec_mode != FIELD_GET(REQ_FEC_MODE_A3_MSK, val) ||
> +	    fec_mode != FIELD_GET(REQ_FEC_MODE_B0_MSK, val) ||
> +	    fec_mode != FIELD_GET(REQ_FEC_MODE_B1_MSK, val) ||
> +	    fec_mode != FIELD_GET(REQ_FEC_MODE_B2_MSK, val) ||
> +	    fec_mode != FIELD_GET(REQ_FEC_MODE_B3_MSK, val))
> +		return -EFAULT;

a precomputed table setting the fields would reduce the this to a lookup and 1 check.

similar table could be used below for the setting.

> +
> +	switch (fec_mode) {
> +	case REQ_FEC_MODE_NO:
> +		return sprintf(buf, "no\n");
> +	case REQ_FEC_MODE_KR:
> +		return sprintf(buf, "kr\n");
> +	case REQ_FEC_MODE_RS:
> +		return sprintf(buf, "rs\n");
> +	}
> +
> +	return -EFAULT;
> +}
> +static DEVICE_ATTR_RO(fec_mode);
> +
> +static struct attribute *n3000_nios_attrs[] = {
> +	&dev_attr_nios_fw_version.attr,
> +	&dev_attr_retimer_A_mode.attr,
> +	&dev_attr_retimer_B_mode.attr,
> +	&dev_attr_fec_mode.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(n3000_nios);
> +
> +static bool init_error_detected(struct n3000_nios *ns)
> +{
> +	unsigned int val;
> +
> +	if (regmap_read(ns->regmap, PKVL_A_MODE_STS, &val))
> +		return true;
> +
> +	if (!IS_MODE_STATUS_OK(val))
> +		return true;
> +
> +	if (regmap_read(ns->regmap, PKVL_B_MODE_STS, &val))
> +		return true;
> +
> +	if (!IS_MODE_STATUS_OK(val))
> +		return true;
> +
> +	return false;
> +}
> +
> +static void dump_error_stat(struct n3000_nios *ns)
> +{
> +	unsigned int val;
> +
> +	if (regmap_read(ns->regmap, PKVL_A_MODE_STS, &val))
> +		return;
> +
> +	dev_err(ns->dev, "PKVL_A_MODE_STS 0x%x\n", val);
> +
> +	if (regmap_read(ns->regmap, PKVL_B_MODE_STS, &val))
> +		return;
> +
> +	dev_err(ns->dev, "PKVL_B_MODE_STS 0x%x\n", val);
> +}
> +
> +static int n3000_nios_init_done_check(struct n3000_nios *ns)
> +{
> +	struct device *dev = ns->dev;
> +	unsigned int val, mode;
> +	int ret;
> +
> +	/*
> +	 * this SPI is shared by Nios core inside FPGA, Nios will use this SPI
'by the Nios core inside the FPGA ... '
> +	 * master to do some one time initialization after power up, and then
> +	 * release the control to OS. driver needs to poll on INIT_DONE to
'The driver..'
> +	 * see when driver could take the control.
> +	 *
> +	 * Please note that after Nios firmware version 3.0.0, INIT_START is
> +	 * introduced, so driver needs to trigger START firstly and then check
> +	 * INIT_DONE.
> +	 */
> +
> +	ret = regmap_read(ns->regmap, NIOS_FW_VERSION, &val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If Nios version register is totally uninitialized(== 0x0), then the
> +	 * Nios firmware is missing. So host could take control of SPI master
> +	 * safely, but initialization work for Nios is not done. To restore the
> +	 * card, we need to reprogram a new Nios firmware via the BMC chip on
> +	 * SPI bus. So the driver doesn't error out, it continues to create the
> +	 * spi controller device and spi_board_info for BMC.
> +	 */
> +	if (val == 0) {
> +		dev_err(dev, "Nios version reg = 0x%x, skip INIT_DONE check, but the retimer may be uninitialized\n",
> +			val);
> +		return 0;
> +	}
> +
> +	if (FIELD_GET(NIOS_FW_VERSION_MAJOR, val) >= 3) {
> +		/* read NIOS_INIT to check if retimer initialization is done */
> +		ret = regmap_read(ns->regmap, NIOS_INIT, &val);
> +		if (ret)
> +			return ret;
> +
> +		/* check if retimers are initialized already */
> +		if (val & NIOS_INIT_DONE || val & NIOS_INIT_START)
val & (NIOS_INIT_DONE | NIOS_INIT_START)
> +			goto nios_init_done;
> +
> +		/* configure FEC mode per module param */
> +		val = NIOS_INIT_START;
> +
> +		/*
> +		 * When the retimer is to be set to 10G mode, there is no FEC
> +		 * mode setting, so the REQ_FEC_MODE field will be ignored by
> +		 * Nios firmware in this case. But we should still fill the FEC
> +		 * mode field cause host could not get the retimer working mode
> +		 * until the Nios init is done.
> +		 *
> +		 * For now the driver doesn't support the retimer FEC mode
> +		 * switching per user's request. It is always set to Reed
> +		 * Solomon FEC.
> +		 */
> +		mode = REQ_FEC_MODE_RS;
> +
> +		/* set the same FEC mode for all links */
> +		val |= FIELD_PREP(REQ_FEC_MODE_A0_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_A1_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_A2_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_A3_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_B0_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_B1_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_B2_MSK, mode) |
> +		       FIELD_PREP(REQ_FEC_MODE_B3_MSK, mode);
> +
> +		ret = regmap_write(ns->regmap, NIOS_INIT, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +nios_init_done:
> +	/* polls on NIOS_INIT_DONE */
> +	ret = regmap_read_poll_timeout(ns->regmap, NIOS_INIT, val,
> +				       val & NIOS_INIT_DONE,
> +				       NIOS_INIT_TIME_INTV,
> +				       NIOS_INIT_TIMEOUT);
> +	if (ret) {
> +		dev_err(dev, "NIOS_INIT_DONE %s\n",
> +			(ret == -ETIMEDOUT) ? "timed out" : "check error");
> +		goto dump_sts;
> +	}
> +
> +	/*
> +	 * After INIT_DONE is detected, it still needs to check if any error
> +	 * detected.
> +	 */
> +	if (init_error_detected(ns)) {
> +		/*
> +		 * If the retimer configuration is failed, the Nios firmware
> +		 * will still release the spi controller for host to
> +		 * communicate with the BMC. It makes possible for people to
> +		 * reprogram a new Nios firmware and restore the card. So the
> +		 * driver doesn't error out, it continues to create the spi
> +		 * controller device and spi_board_info for BMC.
> +		 */
> +		dev_err(dev, "NIOS_INIT_DONE OK, but err found during init\n");
> +		goto dump_sts;
> +	}
> +	return 0;
> +
> +dump_sts:
> +	dump_error_stat(ns);
Could init_error_detected and dump_error_stat be combined ?
> +
> +	return ret;
> +}
> +
> +static struct spi_board_info m10_n3000_info = {
> +	.modalias = "m10-n3000",
> +	.max_speed_hz = 12500000,
> +	.bus_num = 0,
> +	.chip_select = 0,
> +};
> +
> +static int create_altera_spi_controller(struct n3000_nios *ns)
> +{
> +	struct altera_spi_platform_data pdata = { 0 };
> +	struct platform_device_info pdevinfo = { 0 };
> +	void __iomem *base = ns->base;
> +	u64 v;
> +
> +	v = readq(base + NIOS_SPI_PARAM);
> +
> +	pdata.mode_bits = SPI_CS_HIGH;
> +	if (FIELD_GET(PARAM_CLK_POL, v))
> +		pdata.mode_bits |= SPI_CPOL;
> +	if (FIELD_GET(PARAM_CLK_PHASE, v))
> +		pdata.mode_bits |= SPI_CPHA;
> +
> +	pdata.num_chipselect = FIELD_GET(PARAM_NUM_CS, v);
> +	pdata.bits_per_word_mask =
> +		SPI_BPW_RANGE_MASK(1, FIELD_GET(PARAM_DATA_WIDTH, v));
> +
> +	pdata.num_devices = 1;
> +	pdata.devices = &m10_n3000_info;
> +
> +	dev_dbg(ns->dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
> +		pdata.num_chipselect, pdata.bits_per_word_mask,
> +		pdata.mode_bits);
> +
> +	pdevinfo.name = "subdev_spi_altera";
> +	pdevinfo.id = PLATFORM_DEVID_AUTO;
> +	pdevinfo.parent = ns->dev;
> +	pdevinfo.data = &pdata;
> +	pdevinfo.size_data = sizeof(pdata);
> +
> +	ns->altera_spi = platform_device_register_full(&pdevinfo);
> +	return PTR_ERR_OR_ZERO(ns->altera_spi);
> +}
> +
> +static void destroy_altera_spi_controller(struct n3000_nios *ns)
> +{
> +	platform_device_unregister(ns->altera_spi);
> +}
> +
> +/* ns is the abbreviation of nios_spi */
> +static int ns_poll_stat_timeout(void __iomem *base, u64 *v)
> +{
> +	int loops = NS_REGBUS_WAIT_TIMEOUT;
> +
> +	/*
> +	 * We don't use the time based timeout here for performance.
> +	 *
> +	 * The regbus read/write is on the critical path of Intel PAC N3000
> +	 * image programing. The time based timeout checking will add too much
> +	 * overhead on it. Usually the state changes in 1 or 2 loops on the
> +	 * test server, and we set 10000 times loop here for safety.
> +	 */
> +	do {
> +		*v = readq(base + NIOS_SPI_STAT);
> +		if (*v & STAT_RW_VAL)
> +			break;
> +		cpu_relax();
> +	} while (--loops);
This becomes an infinite loop if loops <= 0
> +
> +	return loops ? 0 : -ETIMEDOUT;
> +}
> +
> +static int ns_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct n3000_nios *ns = context;
> +	u64 v = 0;
> +	int ret;
> +
> +	v |= FIELD_PREP(CTRL_CMD_MSK, CTRL_CMD_WR);
> +	v |= FIELD_PREP(CTRL_ADDR, reg);
> +	v |= FIELD_PREP(CTRL_WR_DATA, val);
> +	writeq(v, ns->base + NIOS_SPI_CTRL);
> +
> +	ret = ns_poll_stat_timeout(ns->base, &v);
> +	if (ret)
> +		dev_err(ns->dev, "fail to write reg 0x%x val 0x%x: %d\n",
> +			reg, val, ret);
> +
> +	return ret;
> +}
> +
> +static int ns_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct n3000_nios *ns = context;
> +	u64 v = 0;
> +	int ret;
> +
> +	v |= FIELD_PREP(CTRL_CMD_MSK, CTRL_CMD_RD);

v = , and save the intialiation

or v = ( ... | ... )

> +	v |= FIELD_PREP(CTRL_ADDR, reg);
> +	writeq(v, ns->base + NIOS_SPI_CTRL);
> +
> +	ret = ns_poll_stat_timeout(ns->base, &v);
> +	if (ret)
> +		dev_err(ns->dev, "fail to read reg 0x%x: %d\n", reg, ret);
> +	else
> +		*val = FIELD_GET(STAT_RD_DATA, v);
> +
> +	return ret;
> +}
> +
> +static const struct regmap_config ns_regbus_cfg = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +
> +	.reg_write = ns_reg_write,
> +	.reg_read = ns_reg_read,
> +};
> +
> +static int n3000_nios_probe(struct dfl_device *ddev)
> +{
> +	struct device *dev = &ddev->dev;
> +	struct n3000_nios *ns;
> +	int ret;
> +
> +	ns = devm_kzalloc(dev, sizeof(*ns), GFP_KERNEL);
> +	if (!ns)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&ddev->dev, ns);
> +
> +	ns->dev = dev;
> +
> +	ns->base = devm_ioremap_resource(&ddev->dev, &ddev->mmio_res);
> +	if (IS_ERR(ns->base))
> +		return PTR_ERR(ns->base);
> +
> +	ns->regmap = devm_regmap_init(dev, NULL, ns, &ns_regbus_cfg);
> +	if (IS_ERR(ns->regmap))
> +		return PTR_ERR(ns->regmap);
> +
> +	ret = n3000_nios_init_done_check(ns);
> +	if (ret)
> +		return ret;
> +
> +	ret = create_altera_spi_controller(ns);
> +	if (ret)
> +		dev_err(dev, "altera spi controller create failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void n3000_nios_remove(struct dfl_device *ddev)
> +{
> +	struct n3000_nios *ns = dev_get_drvdata(&ddev->dev);
> +
> +	destroy_altera_spi_controller(ns);
> +}
> +
> +#define FME_FEATURE_ID_N3000_NIOS	0xd
> +
> +static const struct dfl_device_id n3000_nios_ids[] = {
> +	{ FME_ID, FME_FEATURE_ID_N3000_NIOS },
> +	{ }
> +};
> +
> +static struct dfl_driver n3000_nios_driver = {
> +	.drv	= {
> +		.name       = "n3000-nios",

"dfl-n3000-nios" ?

Tom

> +		.dev_groups = n3000_nios_groups,
> +	},
> +	.id_table = n3000_nios_ids,
> +	.probe   = n3000_nios_probe,
> +	.remove  = n3000_nios_remove,
> +};
> +
> +module_dfl_driver(n3000_nios_driver);
> +
> +MODULE_DEVICE_TABLE(dfl, n3000_nios_ids);
> +MODULE_DESCRIPTION("Driver for Nios private feature on Intel PAC N3000");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0855AAA4
	for <lists+linux-fpga@lfdr.de>; Sat, 25 Jun 2022 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiFYNxH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 25 Jun 2022 09:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiFYNxF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 25 Jun 2022 09:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C0152628
        for <linux-fpga@vger.kernel.org>; Sat, 25 Jun 2022 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656165182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rvu93raFsgqMA3Oz8RIRGJEJjMaDWvslTsDOt1yfG7k=;
        b=Lo2wnEv5dbykvMAmq/5FDvvEfG9Fj824E2tPTC5W+f48m9t2V4GKHLF1tKfLB6CcTdKgLT
        dUIY0N0I1eUAyjyF4ORpkxO+K4jG6yLzKpfngk/puOlVgk1bS5awhzGd2oAdcdL3q5wVhW
        paG/IpOqJVSieOedv3doWDcfcyJXHGI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-NSyhzFhQOCiEZsy7GbK2OA-1; Sat, 25 Jun 2022 09:53:01 -0400
X-MC-Unique: NSyhzFhQOCiEZsy7GbK2OA-1
Received: by mail-qv1-f69.google.com with SMTP id q36-20020a0c9127000000b00461e3828064so5270696qvq.12
        for <linux-fpga@vger.kernel.org>; Sat, 25 Jun 2022 06:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Rvu93raFsgqMA3Oz8RIRGJEJjMaDWvslTsDOt1yfG7k=;
        b=GmYqzxypNQZmtNrWyURmqGFPgE4hzCAkBf56OJLJBWkfjqd/BhHMW6LizUAJsbuTCs
         7FhvtRktAC6uZ2OfxS8FqGb5zO452o4begB2tjkojixqWT0ucwR/Fwwiu01ohockO8nn
         V9Z5CGwjinzgHfB4G7JlM5NTNHvG8E5Sg0deBrMhiXR1RXtfZ3HwMTV+uZJQ1fGT40vY
         FRXQeS0laAkiK30FxZ6pG1jLEmoFAbySoqNv8MsI47eOtNe+mlPEvxkjVSzMClXggzaa
         KSHkklCGxK6MOgxsE9I35e/ItcjG++MZGMHgXF7W8PR9ugvm9dpBwauIBfaeX4PXKo4B
         gUkw==
X-Gm-Message-State: AJIora9PW2Zx3wMLvWd7TQcep7ze33syZLg70zUSMcdo/3+FvTsqpBdI
        Ph1DyBy5QQvcNkucaFVYHEqOTu+xkTJF+33gse3nOdB2pMOcwi+x98v/QV+y7GxFxlJhAL8bmIJ
        skqg4Xe4xtRpw2wkyXR95IQ==
X-Received: by 2002:a05:622a:c8:b0:305:2072:ed36 with SMTP id p8-20020a05622a00c800b003052072ed36mr3195095qtw.182.1656165180940;
        Sat, 25 Jun 2022 06:53:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u+cC1LVRmkd3E1UcYt7Afy/sH6U6I3/iuEKJn3BBXZR9CM8BbRugIZUkpM50SqkGP2scNGFw==
X-Received: by 2002:a05:622a:c8:b0:305:2072:ed36 with SMTP id p8-20020a05622a00c800b003052072ed36mr3195074qtw.182.1656165180620;
        Sat, 25 Jun 2022 06:53:00 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bm9-20020a05620a198900b006a73ad95d40sm3985614qkb.55.2022.06.25.06.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 06:53:00 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] mfd: intel-m10-bmc: add PMCI driver
To:     Tianfei Zhang <tianfei.zhang@intel.com>, yilun.xu@intel.com,
        lee.jones@linaro.org
Cc:     hao.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com
References: <20220624092229.45854-1-tianfei.zhang@intel.com>
 <20220624092229.45854-3-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b3ab1b27-648b-9a0a-b613-980c37db0ae9@redhat.com>
Date:   Sat, 25 Jun 2022 06:52:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220624092229.45854-3-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/24/22 2:22 AM, Tianfei Zhang wrote:
> Adding a driver for the PMCI-base interface of Intel MAX10
> BMC controller.
>
> PMCI(Platform Management Control Interface) is a software-visible
> interface, connected to card BMC which provided the basic functionality
> of read/write BMC register. On the other hand, this driver leverages
> the regmap APIs to support Intel specific Indirect Register Interface
> for register read/write on PMCI.
>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v3:
>     - create a new driver for intel-m10-bmc-pmci driver
>     - remove the regmap_access_table
>     - create a new file for sysfs-driver-intel-m10-bmc-pmci ABI
> v2:
>     - fix compile warning reported by lkp
>     - use regmap API for Indirect Register Interface.
> ---
>   .../testing/sysfs-driver-intel-m10-bmc-pmci   |  36 +++
>   drivers/mfd/Kconfig                           |  10 +
>   drivers/mfd/Makefile                          |   1 +
>   drivers/mfd/intel-m10-bmc-pmci.c              | 277 ++++++++++++++++++
>   include/linux/mfd/intel-m10-bmc.h             |   8 +
>   5 files changed, 332 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
>   create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
> new file mode 100644
> index 000000000000..03371b8022ae
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
> @@ -0,0 +1,36 @@
> +What:		/sys/bus/dfl/drivers/dfl-pmci-bmc/dfl_dev.X/bmc_version
> +Date:		June 2022
> +KernelVersion:	5.19
> +Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
> +Description:	Read only. Returns the hardware build version of Intel
> +		MAX10 BMC chip.
> +		Format: "0x%x".
> +
> +What:		/sys/bus/dfl/drivers/dfl-pmci-bmc/dfl_dev.X/bmcfw_version
> +Date:		June 2022
> +KernelVersion:	5.19
> +Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
> +Description:	Read only. Returns the firmware version of Intel MAX10
> +		BMC chip.
> +		Format: "0x%x".
> +
> +What:		/sys/bus/dfl/drivers/dfl-pmci-bmc/dfl_dev.X/mac_address
> +Date:		June 2022
> +KernelVersion:  5.19
> +Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
> +Description:	Read only. Returns the first MAC address in a block
> +		of sequential MAC addresses assigned to the board
> +		that is managed by the Intel MAX10 BMC. It is stored in
> +		FLASH storage and is mirrored in the MAX10 BMC register
> +		space.
> +		Format: "%02x:%02x:%02x:%02x:%02x:%02x".
> +
> +What:		/sys/bus/dfl/drivers/dfl-pmci-bmc/dfl_dev.X/mac_count
> +Date:		June 2022
> +KernelVersion:  5.19
> +Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
> +Description:	Read only. Returns the number of sequential MAC
> +		addresses assigned to the board managed by the Intel
> +		MAX10 BMC. This value is stored in FLASH and is mirrored
> +		in the MAX10 BMC register space.
> +		Format: "%u".

This file looks like a duplicate at sys-driver-intel-m10-bmc.

So the show commands below are duplicates.

Refactoring is necessary.

My recommendation is the existing intel-m10-bmc.c hold the common parts.

intel-m10-bmc.c is spi, so the spi specific bits be split to new 
intel-m10-bmc-spi.c

Tom

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3b59456f5545..ee196c41a9db 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2171,6 +2171,16 @@ config MFD_INTEL_M10_BMC
>   	  additional drivers must be enabled in order to use the functionality
>   	  of the device.
>   
> +config MFD_INTEL_M10_BMC_PMCI
> +	tristate "Intel MAX 10 Board Management Controller with PMCI"
> +	depends on FPGA_DFL
> +	help
> +	  Support for the Intel MAX 10 board management controller via PMCI.
> +
> +	  This driver provides common support for accessing the device,
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>   config MFD_RSMU_I2C
>   	tristate "Renesas Synchronization Management Unit with I2C"
>   	depends on I2C && OF
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 858cacf659d6..f737bd7b7d98 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -267,6 +267,7 @@ obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
>   obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>   obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
>   obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> +obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   += intel-m10-bmc-pmci.o
>   
>   obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
>   obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
> diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
> new file mode 100644
> index 000000000000..93eca4483ac7
> --- /dev/null
> +++ b/drivers/mfd/intel-m10-bmc-pmci.c
> @@ -0,0 +1,277 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PMCI-based interface to MAX10 BMC
> + *
> + * Copyright (C) 2020-2022 Intel Corporation, Inc.
> + *
> + */
> +#include <linux/bitfield.h>
> +#include <linux/dfl.h>
> +#include <linux/mfd/intel-m10-bmc.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/core.h>
> +
> +#define M10BMC_PMCI_INDIRECT_BASE 0x400
> +#define INDIRECT_INT_US        1
> +#define INDIRECT_TIMEOUT_US    10000
> +
> +#define INDIRECT_CMD_OFF	0x0
> +#define INDIRECT_CMD_RD	BIT(0)
> +#define INDIRECT_CMD_WR	BIT(1)
> +#define INDIRECT_CMD_ACK	BIT(2)
> +
> +#define INDIRECT_ADDR_OFF	0x4
> +#define INDIRECT_RD_OFF	0x8
> +#define INDIRECT_WR_OFF	0xc
> +
> +struct indirect_ctx {
> +	void __iomem *base;
> +	struct device *dev;
> +	unsigned long sleep_us;
> +	unsigned long timeout_us;
> +};
> +
> +struct pmci_device {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct intel_m10bmc m10bmc;
> +	struct indirect_ctx ctx;
> +};
> +
> +static int pmci_indirect_bus_clr_cmd(struct indirect_ctx *ctx)
> +{
> +	unsigned int cmd;
> +	int ret;
> +
> +	writel(0, ctx->base + INDIRECT_CMD_OFF);
> +	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> +				 (!cmd), ctx->sleep_us, ctx->timeout_us);
> +	if (ret)
> +		dev_err(ctx->dev, "%s timed out on clearing cmd 0x%xn", __func__, cmd);
> +
> +	return ret;
> +}
> +
> +static int pmci_indirect_bus_reg_read(void *context, unsigned int reg,
> +				      unsigned int *val)
> +{
> +	struct indirect_ctx *ctx = context;
> +	unsigned int cmd;
> +	int ret;
> +
> +	cmd = readl(ctx->base + INDIRECT_CMD_OFF);
> +	if (cmd)
> +		dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__, cmd);
> +
> +	writel(reg, ctx->base + INDIRECT_ADDR_OFF);
> +	writel(INDIRECT_CMD_RD, ctx->base + INDIRECT_CMD_OFF);
> +	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> +				 (cmd & INDIRECT_CMD_ACK), ctx->sleep_us,
> +				 ctx->timeout_us);
> +	if (ret) {
> +		dev_err(ctx->dev, "%s timed out on reg 0x%x cmd 0x%x\n", __func__, reg, cmd);
> +		goto out;
> +	}
> +
> +	*val = readl(ctx->base + INDIRECT_RD_OFF);
> +
> +	if (pmci_indirect_bus_clr_cmd(ctx))
> +		ret = -ETIMEDOUT;
> +
> +out:
> +	return ret;
> +}
> +
> +static int pmci_indirect_bus_reg_write(void *context, unsigned int reg,
> +				       unsigned int val)
> +{
> +	struct indirect_ctx *ctx = context;
> +	unsigned int cmd;
> +	int ret;
> +
> +	cmd = readl(ctx->base + INDIRECT_CMD_OFF);
> +	if (cmd)
> +		dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__, cmd);
> +
> +	writel(val, ctx->base + INDIRECT_WR_OFF);
> +	writel(reg, ctx->base + INDIRECT_ADDR_OFF);
> +	writel(INDIRECT_CMD_WR, ctx->base + INDIRECT_CMD_OFF);
> +	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> +				 (cmd & INDIRECT_CMD_ACK), ctx->sleep_us,
> +				 ctx->timeout_us);
> +	if (ret) {
> +		dev_err(ctx->dev, "%s timed out on reg 0x%x cmd 0x%x\n", __func__, reg, cmd);
> +		goto out;
> +	}
> +
> +	if (pmci_indirect_bus_clr_cmd(ctx))
> +		ret = -ETIMEDOUT;
> +
> +out:
> +	return ret;
> +}
> +
> +static const struct regmap_bus pmci_indirect_bus = {
> +	.reg_write = pmci_indirect_bus_reg_write,
> +	.reg_read =  pmci_indirect_bus_reg_read,
> +};
> +
> +static struct mfd_cell m10bmc_n6000_bmc_subdevs[] = {
> +	{ .name = "n6000bmc-hwmon" },
> +	{ .name = "n6000bmc-sec-update" }
> +};
> +
> +static struct regmap_config m10bmc_pmci_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = M10BMC_PMCI_SYS_END,
> +};
> +
> +static ssize_t bmc_version_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(ddata, M10BMC_PMCI_BUILD_VER, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "0x%x\n", val);
> +}
> +static DEVICE_ATTR_RO(bmc_version);
> +
> +static ssize_t bmcfw_version_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(ddata, NIOS2_PMCI_FW_VERSION, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "0x%x\n", val);
> +}
> +static DEVICE_ATTR_RO(bmcfw_version);
> +
> +static ssize_t mac_address_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> +	unsigned int macaddr_low, macaddr_high;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(max10, M10BMC_PMCI_MAC_LOW, &macaddr_low);
> +	if (ret)
> +		return ret;
> +
> +	ret = m10bmc_sys_read(max10, M10BMC_PMCI_MAC_HIGH, &macaddr_high);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE1, macaddr_low),
> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE2, macaddr_low),
> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE3, macaddr_low),
> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE4, macaddr_low),
> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE5, macaddr_high),
> +			  (u8)FIELD_GET(M10BMC_MAC_BYTE6, macaddr_high));
> +}
> +static DEVICE_ATTR_RO(mac_address);
> +
> +static ssize_t mac_count_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> +	unsigned int macaddr_high;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(max10, M10BMC_PMCI_MAC_HIGH, &macaddr_high);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n",
> +			  (u8)FIELD_GET(M10BMC_MAC_COUNT, macaddr_high));
> +}
> +static DEVICE_ATTR_RO(mac_count);
> +
> +static struct attribute *m10bmc_attrs[] = {
> +	&dev_attr_bmc_version.attr,
> +	&dev_attr_bmcfw_version.attr,
> +	&dev_attr_mac_address.attr,
> +	&dev_attr_mac_count.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(m10bmc);
> +
> +static int pmci_probe(struct dfl_device *ddev)
> +{
> +	struct device *dev = &ddev->dev;
> +	struct mfd_cell *cells;
> +	struct pmci_device *pmci;
> +	int ret, n_cell;
> +
> +	pmci = devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
> +	if (!pmci)
> +		return -ENOMEM;
> +
> +	pmci->m10bmc.dev = dev;
> +	pmci->dev = dev;
> +
> +	pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
> +	if (IS_ERR(pmci->base))
> +		return PTR_ERR(pmci->base);
> +
> +	dev_set_drvdata(dev, &pmci->m10bmc);
> +
> +	pmci->ctx.base = pmci->base + M10BMC_PMCI_INDIRECT_BASE;
> +	pmci->ctx.sleep_us = INDIRECT_INT_US;
> +	pmci->ctx.timeout_us = INDIRECT_TIMEOUT_US;
> +	pmci->ctx.dev = dev;
> +	pmci->m10bmc.regmap =
> +		devm_regmap_init(dev,
> +				 &pmci_indirect_bus,
> +				 &pmci->ctx,
> +				 &m10bmc_pmci_regmap_config);
> +	if (IS_ERR(pmci->m10bmc.regmap))
> +		return PTR_ERR(pmci->m10bmc.regmap);
> +
> +	cells = m10bmc_n6000_bmc_subdevs;
> +	n_cell = ARRAY_SIZE(m10bmc_n6000_bmc_subdevs);
> +
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> +				   cells, n_cell, NULL, 0, NULL);
> +	if (ret)
> +		dev_err(dev, "Failed to register sub-devices: %d\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +#define FME_FEATURE_ID_PMCI_BMC	0x12
> +
> +static const struct dfl_device_id pmci_ids[] = {
> +	{ FME_ID, FME_FEATURE_ID_PMCI_BMC },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(dfl, pmci_ids);
> +
> +static struct dfl_driver pmci_driver = {
> +	.drv	= {
> +		.name       = "dfl-pmci-bmc",
> +		.dev_groups = m10bmc_groups,
> +	},
> +	.id_table = pmci_ids,
> +	.probe    = pmci_probe,
> +};
> +
> +module_dfl_driver(pmci_driver);
> +
> +MODULE_DESCRIPTION("MAX10 BMC PMCI-based interface");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index f0044b14136e..7b58af207b72 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -118,6 +118,14 @@
>   /* Address of 4KB inverted bit vector containing staging area FLASH count */
>   #define STAGING_FLASH_COUNT	0x17ffb000
>   
> +#define M10BMC_PMCI_SYS_BASE 0x0
> +#define M10BMC_PMCI_SYS_END  0xfff
> +
> +#define M10BMC_PMCI_BUILD_VER   0x0
> +#define NIOS2_PMCI_FW_VERSION   0x4
> +#define M10BMC_PMCI_MAC_LOW     0x20
> +#define M10BMC_PMCI_MAC_HIGH    0x24
> +
>   /**
>    * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
>    * @dev: this device


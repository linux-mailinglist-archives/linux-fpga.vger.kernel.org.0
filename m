Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A65488C8F
	for <lists+linux-fpga@lfdr.de>; Sun,  9 Jan 2022 22:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbiAIVeg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 9 Jan 2022 16:34:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237114AbiAIVeg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 9 Jan 2022 16:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641764075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZo/mS1YRUkF0P0IR1ox6IJGta7I0Xu80Y6iLk/SeCY=;
        b=hWYQaF0wF1AElLW/5ZY03uVNvB6Ko4dG7PsSL7bOHnj4JZ81REEr/O9sJjQOLcR+x8wP+n
        ad5lyFr4N51sZWg3k74TEPrxuZzxueheRHNlFnTEdkPwIsvwlGa0mkEnHz77mtXDKYfQHN
        Ji87t6+N0L5i5K68K1XLqvODab4+Uv0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-kjVvSEfdMSOIovnZNfxN8Q-1; Sun, 09 Jan 2022 16:34:34 -0500
X-MC-Unique: kjVvSEfdMSOIovnZNfxN8Q-1
Received: by mail-ot1-f72.google.com with SMTP id w8-20020a9d3608000000b0058f5caabe0dso2270493otb.21
        for <linux-fpga@vger.kernel.org>; Sun, 09 Jan 2022 13:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RZo/mS1YRUkF0P0IR1ox6IJGta7I0Xu80Y6iLk/SeCY=;
        b=y+nNl8QQebfpgZgqNed4kzNNuEOnQIExJgK4c7BGeQc9szYLNAtXH19PuMMK0E9w/X
         NoDkLmc2LqWRVqzzyqP0WXgbRbufnBccKdOSWFBpbAx8l1CFqE4RcqbgcjzbtpVZojzw
         U0eBQ+TzJveE6LcMYxe2qpeBN6GofwnvcRUVCwS6L1Mqn1zOmZ6OcFennLsksERAnwCx
         JkSq8VIkvFp6GiG3tgEkTvmEDGJpjzBxqFZX4t7THIZGeIXatKOtd2hKRaQhThahcEiW
         4nNrlDcHbRQzNnfN49Yi67PlRBKkOehSgC2joph0YIvp1qw3c71lCwkP8fDGz369gWeX
         KnRA==
X-Gm-Message-State: AOAM532RLdqNxkEPNPMxjMzyKL7IK7j1mQRlN6REd93z1zchai7dD4zJ
        Oqha0DPDFQV1x1jO50VmrG3M5e56FP4XQzaO2mlJ4RCzohx2phLb+6y5kaBXPzD3Gx0eVV3tV6N
        x8dqWijaf2B40QP3B8ibg+Q==
X-Received: by 2002:a05:6808:4d0:: with SMTP id a16mr17025213oie.93.1641764073389;
        Sun, 09 Jan 2022 13:34:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6flItpOqFgKh/7DikndT5+yS3dj5mWAEWfeDZYr73HFd7brf1kqyWY3TBUMmvjXi142tYnQ==
X-Received: by 2002:a05:6808:4d0:: with SMTP id a16mr17025202oie.93.1641764073176;
        Sun, 09 Jan 2022 13:34:33 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id i2sm786529oii.55.2022.01.09.13.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 13:34:32 -0800 (PST)
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 5/5] fpga: xrt: management
 physical function driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, dwmw2@infradead.org,
        Max Zhen <max.zhen@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-6-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <bb959aab-4de0-3e47-8ed8-761ae80e8ec0@redhat.com>
Date:   Sun, 9 Jan 2022 13:34:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220105225013.1567871-6-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/5/22 2:50 PM, Lizhi Hou wrote:
> The PCIE device driver which attaches to management function on Alveo
> devices. It instantiates one or more partition. Each partition consists
> a set of hardward endpoints. A flat device tree is associated with each
> partition. The first version of this driver uses test version flat device
> tree and call xrt lib API to unflatten it.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   drivers/fpga/Makefile             |   1 +
>   drivers/fpga/xrt/Kconfig          |   1 +
>   drivers/fpga/xrt/mgmt/Kconfig     |  14 +++
>   drivers/fpga/xrt/mgmt/Makefile    |  16 +++
>   drivers/fpga/xrt/mgmt/dt-test.dts |  12 +++
>   drivers/fpga/xrt/mgmt/dt-test.h   |  15 +++
>   drivers/fpga/xrt/mgmt/xmgmt-drv.c | 158 ++++++++++++++++++++++++++++++
>   7 files changed, 217 insertions(+)
>   create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>   create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>   create mode 100644 drivers/fpga/xrt/mgmt/dt-test.dts
>   create mode 100644 drivers/fpga/xrt/mgmt/dt-test.h
>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-drv.c
>
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 5bd41cf4c7ec..544e2144878f 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -52,3 +52,4 @@ obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
>   
>   # XRT drivers for Alveo
>   obj-$(CONFIG_FPGA_XRT_LIB)		+= xrt/lib/
> +obj-$(CONFIG_FPGA_XRT_XMGMT)		+= xrt/mgmt/
> diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
> index 04c3bb5aaf4f..50422f77c6df 100644
> --- a/drivers/fpga/xrt/Kconfig
> +++ b/drivers/fpga/xrt/Kconfig
> @@ -4,3 +4,4 @@
>   #
>   
>   source "drivers/fpga/xrt/lib/Kconfig"
> +source "drivers/fpga/xrt/mgmt/Kconfig"
> diff --git a/drivers/fpga/xrt/mgmt/Kconfig b/drivers/fpga/xrt/mgmt/Kconfig
> new file mode 100644
> index 000000000000..a978747482be
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgmt/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Xilinx XRT FPGA device configuration
> +#
> +
> +config FPGA_XRT_XMGMT
> +	tristate "Xilinx Alveo Management Driver"
> +	depends on FPGA_XRT_LIB
> +	select FPGA_BRIDGE
> +	select FPGA_REGION
> +	help
> +	  Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
> +	  This driver provides interfaces for userspace application to access
> +	  Alveo FPGA device.
> diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
> new file mode 100644
> index 000000000000..c5134bf71cca
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgmt/Makefile
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
> +#
> +# Authors: Sonal.Santan@xilinx.com
> +#
> +
> +FULL_XRT_PATH=$(srctree)/$(src)/..
> +
> +obj-$(CONFIG_FPGA_XRT_LIB) += xrt-mgmt.o
> +
> +xrt-mgmt-objs :=		\
> +	xmgmt-drv.o		\
> +	dt-test.dtb.o
> +
> +ccflags-y := -I$(FULL_XRT_PATH)/include
> diff --git a/drivers/fpga/xrt/mgmt/dt-test.dts b/drivers/fpga/xrt/mgmt/dt-test.dts
> new file mode 100644
> index 000000000000..68dbcb7fd79d
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgmt/dt-test.dts
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +
> +/ {
> +	compatible = "xlnx,alveo-partition", "simple-bus";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	pr_isolate_ulp@0,41000 {
> +		compatible = "xlnx,alveo-pr-isolation";
> +		reg = <0x0 0x41000 0x0 0x1000>;
> +	};
> +};
> diff --git a/drivers/fpga/xrt/mgmt/dt-test.h b/drivers/fpga/xrt/mgmt/dt-test.h
> new file mode 100644
> index 000000000000..6ec4203afbd2
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgmt/dt-test.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Xilinx, Inc.
> + *
> + * Authors:
> + *	Lizhi Hou <lizhih@xilinx.com>
> + */
> +
> +#ifndef _DT_TEST_H_
> +#define _DT_TEST_H_
> +
> +extern u8 __dtb_dt_test_begin[];
> +extern u8 __dtb_dt_test_end[];
these externs are also in lib-drv.h, this could be a duplicate file
> +
> +#endif	/* _DT_TEST_H_ */
> diff --git a/drivers/fpga/xrt/mgmt/xmgmt-drv.c b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
> new file mode 100644
> index 000000000000..87abe5b86e0b
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo Management Function Driver
> + *
> + * Copyright (C) 2020-2022 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + *	Lizhi Hou <lizhih@xilinx.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/aer.h>
> +#include <linux/vmalloc.h>
> +#include <linux/delay.h>
> +#include "xpartition.h"
> +#include "dt-test.h"
> +
> +#define XMGMT_MODULE_NAME	"xrt-mgmt"
> +
> +#define XMGMT_PDEV(xm)		((xm)->pdev)
> +#define XMGMT_DEV(xm)		(&(XMGMT_PDEV(xm)->dev))
> +#define xmgmt_err(xm, fmt, args...)	\
> +	dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> +#define xmgmt_warn(xm, fmt, args...)	\
> +	dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> +#define xmgmt_info(xm, fmt, args...)	\
> +	dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> +#define xmgmt_dbg(xm, fmt, args...)	\
> +	dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> +#define XMGMT_DEV_ID(_pcidev)			\
> +	({ typeof(_pcidev) (pcidev) = (_pcidev);	\
> +	((pci_domain_nr((pcidev)->bus) << 16) |	\
> +	PCI_DEVID((pcidev)->bus->number, (pcidev)->devfn)); })
> +
> +#define XRT_MAX_READRQ		512
> +
> +/* PCI Device IDs */
> +#define PCI_DEVICE_ID_U50		0x5020
> +static const struct pci_device_id xmgmt_pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50), }, /* Alveo U50 */
> +	{ 0, }
> +};
> +
> +struct xmgmt {
> +	struct pci_dev *pdev;
> +	void *base_partition;
> +
remove empty nl
> +	bool ready;
> +};
> +
> +static int xmgmt_config_pci(struct xmgmt *xm)
> +{
> +	struct pci_dev *pdev = XMGMT_PDEV(xm);
> +	int rc;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc < 0) {
> +		xmgmt_err(xm, "failed to enable device: %d", rc);
> +		return rc;
> +	}
> +
> +	rc = pci_enable_pcie_error_reporting(pdev);
> +	if (rc)
> +		xmgmt_warn(xm, "failed to enable AER: %d", rc);
> +
> +	pci_set_master(pdev);
> +
> +	rc = pcie_get_readrq(pdev);
> +	if (rc > XRT_MAX_READRQ)
> +		pcie_set_readrq(pdev, XRT_MAX_READRQ);
> +	return 0;
> +}
> +
> +static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct xrt_partition_range ranges[PCI_NUM_RESOURCES];
> +	struct xrt_partition_info xp_info = { 0 };
> +	struct device *dev = &pdev->dev;
> +	int ret, i, idx = 0;
> +	struct xmgmt *xm;
> +
> +	xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
> +	if (!xm)
> +		return -ENOMEM;
> +	xm->pdev = pdev;
> +	pci_set_drvdata(pdev, xm);
> +
> +	ret = xmgmt_config_pci(xm);
> +	if (ret)
> +		goto failed;
> +
> +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +		if (pci_resource_len(pdev, i) > 0) {
> +			ranges[idx].bar_idx = i;
> +			ranges[idx].base = pci_resource_start(pdev, i);
> +			ranges[idx].size = pci_resource_len(pdev, i);
> +			idx++;
> +		}
> +	}
> +	xp_info.num_range = idx;
> +	xp_info.ranges = ranges;
> +	xp_info.fdt = __dtb_dt_test_begin;
> +	xp_info.fdt_len = (u32)(__dtb_dt_test_end - __dtb_dt_test_begin);
> +	ret = xrt_partition_create(&pdev->dev, &xp_info, &xm->base_partition);
> +	if (ret)
> +		goto failed;
> +
> +	xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
> +	return 0;
> +
> +failed:
> +	if (xm->base_partition)

This if-check and xrt_partition can be removed.

xm->base_partition is only set when xrt_partition_create is successful

> +		xrt_partition_destroy(xm->base_partition);
> +	pci_set_drvdata(pdev, NULL);
> +	return ret;
> +}
> +
> +static void xmgmt_remove(struct pci_dev *pdev)
> +{
> +	struct xmgmt *xm = pci_get_drvdata(pdev);
> +
> +	xrt_partition_destroy(xm->base_partition);
> +	pci_disable_pcie_error_reporting(xm->pdev);
> +	xmgmt_info(xm, "%s cleaned up successfully", XMGMT_MODULE_NAME);
> +}
> +
> +static struct pci_driver xmgmt_driver = {
> +	.name = XMGMT_MODULE_NAME,
> +	.id_table = xmgmt_pci_ids,
> +	.probe = xmgmt_probe,
> +	.remove = xmgmt_remove,
> +};
> +
> +static int __init xmgmt_init(void)
> +{
> +	int res = 0;

This is a dead assignment, keep if you want.

Tom

> +
> +	res = pci_register_driver(&xmgmt_driver);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static __exit void xmgmt_exit(void)
> +{
> +	pci_unregister_driver(&xmgmt_driver);
> +}
> +
> +module_init(xmgmt_init);
> +module_exit(xmgmt_exit);
> +
> +MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
> +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
> +MODULE_DESCRIPTION("Xilinx Alveo management function driver");
> +MODULE_LICENSE("GPL v2");


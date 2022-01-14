Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D279F48E244
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Jan 2022 02:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiANBvm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 Jan 2022 20:51:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:37984 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbiANBvm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 13 Jan 2022 20:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642125102; x=1673661102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I0rV+m3SXQmnCzoLGgxAJ4/jDS7auTkv43r0uFtWwmo=;
  b=XrSiVhmQ5mcIpQJHFoE8SmX7Vg8utZsy64/QOkJ/dXwqnDwRRR3cCneu
   aF5u9YJja7ru8jKw9PNTft7UlSSALNitWcdEZdl3RJ6VJwioXoxQqcdd4
   lmTD6ifX6v8cil3fvoblio1PN09Y33awUeOsTFW8pAs7XM8DG8Sv4muCn
   qX3DeTX/0oTJpdWlw+sySv6+0yBSf/roJS0JWW3SuRSqm+3DxSIgZyhzK
   BjIj0xqDlx1+32m7xyGA+8qMW5ICl8b91GP3Z5lBHT0fb/BaqZRVC/E4+
   RyvHpqfe2MZ1kp4Y6lwEVcN67PfzTLHLibTQs8GrqZfyicOe0xSvcAbi2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="243959145"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="243959145"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 17:51:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="692027939"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2022 17:51:36 -0800
Date:   Fri, 14 Jan 2022 09:43:39 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, yliu@xilinx.com,
        michal.simek@xilinx.com, stefanos@xilinx.com,
        devicetree@vger.kernel.org, trix@redhat.com, mdf@kernel.org,
        robh@kernel.org, dwmw2@infradead.org,
        Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 5/5] fpga: xrt: management
  physical function driver
Message-ID: <20220114014339.GA1027147@yilunxu-OptiPlex-7050>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-6-lizhi.hou@xilinx.com>
 <20220111070000.GC979169@yilunxu-OptiPlex-7050>
 <446d9abb-b1ee-b0e7-9c48-aa7e960ec1e9@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <446d9abb-b1ee-b0e7-9c48-aa7e960ec1e9@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jan 13, 2022 at 03:41:47PM -0800, Lizhi Hou wrote:
> 
> On 1/10/22 11:00 PM, Xu Yilun wrote:
> > =
> > 
> > On Wed, Jan 05, 2022 at 02:50:13PM -0800, Lizhi Hou wrote:
> > > The PCIE device driver which attaches to management function on Alveo
> > > devices. It instantiates one or more partition. Each partition consists
> > > a set of hardward endpoints. A flat device tree is associated with each
> > > partition. The first version of this driver uses test version flat device
> > > tree and call xrt lib API to unflatten it.
> > > 
> > > Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> > > Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> > > Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> > > ---
> > >   drivers/fpga/Makefile             |   1 +
> > >   drivers/fpga/xrt/Kconfig          |   1 +
> > >   drivers/fpga/xrt/mgmt/Kconfig     |  14 +++
> > >   drivers/fpga/xrt/mgmt/Makefile    |  16 +++
> > >   drivers/fpga/xrt/mgmt/dt-test.dts |  12 +++
> > >   drivers/fpga/xrt/mgmt/dt-test.h   |  15 +++
> > >   drivers/fpga/xrt/mgmt/xmgmt-drv.c | 158 ++++++++++++++++++++++++++++++
> > >   7 files changed, 217 insertions(+)
> > >   create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
> > >   create mode 100644 drivers/fpga/xrt/mgmt/Makefile
> > >   create mode 100644 drivers/fpga/xrt/mgmt/dt-test.dts
> > >   create mode 100644 drivers/fpga/xrt/mgmt/dt-test.h
> > >   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-drv.c
> > > 
> > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > index 5bd41cf4c7ec..544e2144878f 100644
> > > --- a/drivers/fpga/Makefile
> > > +++ b/drivers/fpga/Makefile
> > > @@ -52,3 +52,4 @@ obj-$(CONFIG_FPGA_DFL_PCI)          += dfl-pci.o
> > > 
> > >   # XRT drivers for Alveo
> > >   obj-$(CONFIG_FPGA_XRT_LIB)           += xrt/lib/
> > > +obj-$(CONFIG_FPGA_XRT_XMGMT)         += xrt/mgmt/
> > > diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
> > > index 04c3bb5aaf4f..50422f77c6df 100644
> > > --- a/drivers/fpga/xrt/Kconfig
> > > +++ b/drivers/fpga/xrt/Kconfig
> > > @@ -4,3 +4,4 @@
> > >   #
> > > 
> > >   source "drivers/fpga/xrt/lib/Kconfig"
> > > +source "drivers/fpga/xrt/mgmt/Kconfig"
> > > diff --git a/drivers/fpga/xrt/mgmt/Kconfig b/drivers/fpga/xrt/mgmt/Kconfig
> > > new file mode 100644
> > > index 000000000000..a978747482be
> > > --- /dev/null
> > > +++ b/drivers/fpga/xrt/mgmt/Kconfig
> > > @@ -0,0 +1,14 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +#
> > > +# Xilinx XRT FPGA device configuration
> > > +#
> > > +
> > > +config FPGA_XRT_XMGMT
> > > +     tristate "Xilinx Alveo Management Driver"
> > > +     depends on FPGA_XRT_LIB
> > > +     select FPGA_BRIDGE
> > > +     select FPGA_REGION
> > > +     help
> > > +       Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
> > > +       This driver provides interfaces for userspace application to access
> > > +       Alveo FPGA device.
> > > diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
> > > new file mode 100644
> > > index 000000000000..c5134bf71cca
> > > --- /dev/null
> > > +++ b/drivers/fpga/xrt/mgmt/Makefile
> > > @@ -0,0 +1,16 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
> > > +#
> > > +# Authors: Sonal.Santan@xilinx.com
> > > +#
> > > +
> > > +FULL_XRT_PATH=$(srctree)/$(src)/..
> > > +
> > > +obj-$(CONFIG_FPGA_XRT_LIB) += xrt-mgmt.o
> > > +
> > > +xrt-mgmt-objs :=             \
> > > +     xmgmt-drv.o             \
> > > +     dt-test.dtb.o
> > > +
> > > +ccflags-y := -I$(FULL_XRT_PATH)/include
> > > diff --git a/drivers/fpga/xrt/mgmt/dt-test.dts b/drivers/fpga/xrt/mgmt/dt-test.dts
> > > new file mode 100644
> > > index 000000000000..68dbcb7fd79d
> > > --- /dev/null
> > > +++ b/drivers/fpga/xrt/mgmt/dt-test.dts
> > > @@ -0,0 +1,12 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/dts-v1/;
> > > +
> > > +/ {
> > > +     compatible = "xlnx,alveo-partition", "simple-bus";
> > > +     #address-cells = <2>;
> > > +     #size-cells = <2>;
> > > +     pr_isolate_ulp@0,41000 {
> > > +             compatible = "xlnx,alveo-pr-isolation";
> > > +             reg = <0x0 0x41000 0x0 0x1000>;
> > > +     };
> > > +};
> > I remember Rob's comments:
> > 
> > "we'd need to create a base tree (if there isn't one) with nodes
> > for the USB or PCI device(s) and then an overlay for the device can be
> > applied to those nodes."
> > 
> > https://lore.kernel.org/linux-fpga/CAL_JsqJfyRymB=VxLuQqLpep+Q1Eie48dobv9sC5OizDz0d2DQ@mail.gmail.com/
> > 
> > So could we firstly create a pci device node under the of_root when
> > the driver probing, then add the partition DTs under the pci device node
> > by overlay machenism.
> > 
> > I'm considering if finally we could leverage the existing of-fpga-region
> > that reprograms and enumerates FPGA sub devices by overlay.
> > 
> > Open for discussion.
> 
> I would list the main ideas of our implementation
> 
> 1. “alveo-partition (simple-bus)” node is created under of_root in xmgmt
> probe function. “simple-bus” is used as it fits well and we can modify it to
> “fpga-region” when we refactor fpga-mgr/region/bridge part.

OK. "fpga-region" for an independent reprogramable region. And
"simple-bus" for static board components.

> 2. we are the first pcie device using flatten device tree to describe sub
> devices. Adding device tree nodes for all pcie device sounds intrusive. We
> can expend to all pcie device when we have another user of this feature.

I don't mean we create DT nodes for all pcie devices in system, it is the
device driver's choice to create the node for DT style enumeration of its
sub devices. This is mainly for pcie based fpga cards. Now there exsits
plenty of these cards in the world, and the enumeration of their sub
devices could be a common concern. I think it's good we have a clear
design at the beginning.

> 
> 3. of_overlay_fdt_apply() does not support overlaying to a dynamic generated

Yes that's the problem we have.

> parent node. Thus, we use of_dynamic functions of_changeset_attach_node()
> instead. (similar to drivers/pci/hotplug/pnv_php.c,) . If needed ,we can
> consider to add parameter “parent node” to of_overlay_fdt_apply() to support
> dynamical overlay case.

I agree we do some investigation for this.

Thanks,
Yilun

> 
> 
> Thanks,
> 
> Lizhi
> 
> > 
> > Thanks,
> > Yilun
> > 
> > > diff --git a/drivers/fpga/xrt/mgmt/dt-test.h b/drivers/fpga/xrt/mgmt/dt-test.h
> > > new file mode 100644
> > > index 000000000000..6ec4203afbd2
> > > --- /dev/null
> > > +++ b/drivers/fpga/xrt/mgmt/dt-test.h
> > > @@ -0,0 +1,15 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2020-2022 Xilinx, Inc.
> > > + *
> > > + * Authors:
> > > + *   Lizhi Hou <lizhih@xilinx.com>
> > > + */
> > > +
> > > +#ifndef _DT_TEST_H_
> > > +#define _DT_TEST_H_
> > > +
> > > +extern u8 __dtb_dt_test_begin[];
> > > +extern u8 __dtb_dt_test_end[];
> > > +
> > > +#endif       /* _DT_TEST_H_ */
> > > diff --git a/drivers/fpga/xrt/mgmt/xmgmt-drv.c b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
> > > new file mode 100644
> > > index 000000000000..87abe5b86e0b
> > > --- /dev/null
> > > +++ b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
> > > @@ -0,0 +1,158 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Xilinx Alveo Management Function Driver
> > > + *
> > > + * Copyright (C) 2020-2022 Xilinx, Inc.
> > > + *
> > > + * Authors:
> > > + *   Cheng Zhen <maxz@xilinx.com>
> > > + *   Lizhi Hou <lizhih@xilinx.com>
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/aer.h>
> > > +#include <linux/vmalloc.h>
> > > +#include <linux/delay.h>
> > > +#include "xpartition.h"
> > > +#include "dt-test.h"
> > > +
> > > +#define XMGMT_MODULE_NAME    "xrt-mgmt"
> > > +
> > > +#define XMGMT_PDEV(xm)               ((xm)->pdev)
> > > +#define XMGMT_DEV(xm)                (&(XMGMT_PDEV(xm)->dev))
> > > +#define xmgmt_err(xm, fmt, args...)  \
> > > +     dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> > > +#define xmgmt_warn(xm, fmt, args...) \
> > > +     dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> > > +#define xmgmt_info(xm, fmt, args...) \
> > > +     dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> > > +#define xmgmt_dbg(xm, fmt, args...)  \
> > > +     dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
> > > +#define XMGMT_DEV_ID(_pcidev)                        \
> > > +     ({ typeof(_pcidev) (pcidev) = (_pcidev);        \
> > > +     ((pci_domain_nr((pcidev)->bus) << 16) | \
> > > +     PCI_DEVID((pcidev)->bus->number, (pcidev)->devfn)); })
> > > +
> > > +#define XRT_MAX_READRQ               512
> > > +
> > > +/* PCI Device IDs */
> > > +#define PCI_DEVICE_ID_U50            0x5020
> > > +static const struct pci_device_id xmgmt_pci_ids[] = {
> > > +     { PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50), }, /* Alveo U50 */
> > > +     { 0, }
> > > +};
> > > +
> > > +struct xmgmt {
> > > +     struct pci_dev *pdev;
> > > +     void *base_partition;
> > > +
> > > +     bool ready;
> > > +};
> > > +
> > > +static int xmgmt_config_pci(struct xmgmt *xm)
> > > +{
> > > +     struct pci_dev *pdev = XMGMT_PDEV(xm);
> > > +     int rc;
> > > +
> > > +     rc = pcim_enable_device(pdev);
> > > +     if (rc < 0) {
> > > +             xmgmt_err(xm, "failed to enable device: %d", rc);
> > > +             return rc;
> > > +     }
> > > +
> > > +     rc = pci_enable_pcie_error_reporting(pdev);
> > > +     if (rc)
> > > +             xmgmt_warn(xm, "failed to enable AER: %d", rc);
> > > +
> > > +     pci_set_master(pdev);
> > > +
> > > +     rc = pcie_get_readrq(pdev);
> > > +     if (rc > XRT_MAX_READRQ)
> > > +             pcie_set_readrq(pdev, XRT_MAX_READRQ);
> > > +     return 0;
> > > +}
> > > +
> > > +static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > +{
> > > +     struct xrt_partition_range ranges[PCI_NUM_RESOURCES];
> > > +     struct xrt_partition_info xp_info = { 0 };
> > > +     struct device *dev = &pdev->dev;
> > > +     int ret, i, idx = 0;
> > > +     struct xmgmt *xm;
> > > +
> > > +     xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
> > > +     if (!xm)
> > > +             return -ENOMEM;
> > > +     xm->pdev = pdev;
> > > +     pci_set_drvdata(pdev, xm);
> > > +
> > > +     ret = xmgmt_config_pci(xm);
> > > +     if (ret)
> > > +             goto failed;
> > > +
> > > +     for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> > > +             if (pci_resource_len(pdev, i) > 0) {
> > > +                     ranges[idx].bar_idx = i;
> > > +                     ranges[idx].base = pci_resource_start(pdev, i);
> > > +                     ranges[idx].size = pci_resource_len(pdev, i);
> > > +                     idx++;
> > > +             }
> > > +     }
> > > +     xp_info.num_range = idx;
> > > +     xp_info.ranges = ranges;
> > > +     xp_info.fdt = __dtb_dt_test_begin;
> > > +     xp_info.fdt_len = (u32)(__dtb_dt_test_end - __dtb_dt_test_begin);
> > > +     ret = xrt_partition_create(&pdev->dev, &xp_info, &xm->base_partition);
> > > +     if (ret)
> > > +             goto failed;
> > > +
> > > +     xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
> > > +     return 0;
> > > +
> > > +failed:
> > > +     if (xm->base_partition)
> > > +             xrt_partition_destroy(xm->base_partition);
> > > +     pci_set_drvdata(pdev, NULL);
> > > +     return ret;
> > > +}
> > > +
> > > +static void xmgmt_remove(struct pci_dev *pdev)
> > > +{
> > > +     struct xmgmt *xm = pci_get_drvdata(pdev);
> > > +
> > > +     xrt_partition_destroy(xm->base_partition);
> > > +     pci_disable_pcie_error_reporting(xm->pdev);
> > > +     xmgmt_info(xm, "%s cleaned up successfully", XMGMT_MODULE_NAME);
> > > +}
> > > +
> > > +static struct pci_driver xmgmt_driver = {
> > > +     .name = XMGMT_MODULE_NAME,
> > > +     .id_table = xmgmt_pci_ids,
> > > +     .probe = xmgmt_probe,
> > > +     .remove = xmgmt_remove,
> > > +};
> > > +
> > > +static int __init xmgmt_init(void)
> > > +{
> > > +     int res = 0;
> > > +
> > > +     res = pci_register_driver(&xmgmt_driver);
> > > +     if (res)
> > > +             return res;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static __exit void xmgmt_exit(void)
> > > +{
> > > +     pci_unregister_driver(&xmgmt_driver);
> > > +}
> > > +
> > > +module_init(xmgmt_init);
> > > +module_exit(xmgmt_exit);
> > > +
> > > +MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
> > > +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
> > > +MODULE_DESCRIPTION("Xilinx Alveo management function driver");
> > > +MODULE_LICENSE("GPL v2");
> > > --
> > > 2.27.0

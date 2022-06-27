Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0102855C5FB
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Jun 2022 14:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiF0Qki (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Jun 2022 12:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiF0Qki (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 Jun 2022 12:40:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEDD1AD89;
        Mon, 27 Jun 2022 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656348036; x=1687884036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UWotUSA1vQeN8mldYLyovqHVp06oigEb8xiCelj2mco=;
  b=MRugcb5I3aeQUN09MvyF6mm2J304wO4WW1QV+wyRT4q0GweMLm3J3oTp
   E4XH48jXOCxdFAqT4TcWHi2nnf93BOFeOjJtgy5qLfF7oM1l1KvItn11A
   sfOXpj+8wN0+TUQoCHKUo9pDgE2SHv0bw2BnzYatb/Dny7GZcdLXpzdYC
   fHpJ9Iwd+4UirX/HX5MgBeoTDi/f2MmtaKtKNUATaK6grooAmLg1SR2St
   Omd0JFDb1A3lR3nf/ijcHjRIfcY2OUfn8BDXeUzH/2Zb0yJ49xslfWNwy
   dQhEVx11QYRhbNZkOh5ohpVFqM9w/T6ZdT4A0piSucnsRU7+HSsF8GLyv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="306968783"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="306968783"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 09:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="594373549"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jun 2022 09:39:02 -0700
Date:   Tue, 28 Jun 2022 00:30:48 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>
Cc:     Tom Rix <trix@redhat.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Wu, Hao" <hao.wu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 2/3] mfd: intel-m10-bmc: add PMCI driver
Message-ID: <20220627163048.GA2311255@yilunxu-OptiPlex-7050>
References: <20220624092229.45854-1-tianfei.zhang@intel.com>
 <20220624092229.45854-3-tianfei.zhang@intel.com>
 <b3ab1b27-648b-9a0a-b613-980c37db0ae9@redhat.com>
 <BN9PR11MB54839B9631B5DC1EE13404DEE3B99@BN9PR11MB5483.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB54839B9631B5DC1EE13404DEE3B99@BN9PR11MB5483.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 27, 2022 at 10:03:35PM +0800, Zhang, Tianfei wrote:
> 
> 
> > -----Original Message-----
> > From: Tom Rix <trix@redhat.com>
> > Sent: Saturday, June 25, 2022 9:53 PM
> > To: Zhang, Tianfei <tianfei.zhang@intel.com>; Xu, Yilun <yilun.xu@intel.com>;
> > lee.jones@linaro.org
> > Cc: Wu, Hao <hao.wu@intel.com>; linux-kernel@vger.kernel.org; linux-
> > fpga@vger.kernel.org; Weight, Russell H <russell.h.weight@intel.com>;
> > matthew.gerlach@linux.intel.com
> > Subject: Re: [PATCH v3 2/3] mfd: intel-m10-bmc: add PMCI driver
> >
> >
> > On 6/24/22 2:22 AM, Tianfei Zhang wrote:
> > > Adding a driver for the PMCI-base interface of Intel MAX10 BMC
> > > controller.
> > >
> > > PMCI(Platform Management Control Interface) is a software-visible
> > > interface, connected to card BMC which provided the basic
> > > functionality of read/write BMC register. On the other hand, this
> > > driver leverages the regmap APIs to support Intel specific Indirect
> > > Register Interface for register read/write on PMCI.
> > >
> > > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > ---
> > > v3:
> > >     - create a new driver for intel-m10-bmc-pmci driver
> > >     - remove the regmap_access_table
> > >     - create a new file for sysfs-driver-intel-m10-bmc-pmci ABI
> > > v2:
> > >     - fix compile warning reported by lkp
> > >     - use regmap API for Indirect Register Interface.
> > > ---
> > >   .../testing/sysfs-driver-intel-m10-bmc-pmci   |  36 +++
> > >   drivers/mfd/Kconfig                           |  10 +
> > >   drivers/mfd/Makefile                          |   1 +
> > >   drivers/mfd/intel-m10-bmc-pmci.c              | 277 ++++++++++++++++++
> > >   include/linux/mfd/intel-m10-bmc.h             |   8 +
> > >   5 files changed, 332 insertions(+)
> > >   create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-
> > pmci
> > >   create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
> > > b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
> > > new file mode 100644
> > > index 000000000000..03371b8022ae
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
> > > @@ -0,0 +1,36 @@
> > > +What:              /sys/bus/dfl/drivers/dfl-pmci-
> > bmc/dfl_dev.X/bmc_version
> > > +Date:              June 2022
> > > +KernelVersion:     5.19
> > > +Contact:   Tianfei Zhang <tianfei.zhang@intel.com>
> > > +Description:       Read only. Returns the hardware build version of Intel
> > > +           MAX10 BMC chip.
> > > +           Format: "0x%x".
> > > +
> > > +What:              /sys/bus/dfl/drivers/dfl-pmci-
> > bmc/dfl_dev.X/bmcfw_version
> > > +Date:              June 2022
> > > +KernelVersion:     5.19
> > > +Contact:   Tianfei Zhang <tianfei.zhang@intel.com>
> > > +Description:       Read only. Returns the firmware version of Intel MAX10
> > > +           BMC chip.
> > > +           Format: "0x%x".
> > > +
> > > +What:              /sys/bus/dfl/drivers/dfl-pmci-
> > bmc/dfl_dev.X/mac_address
> > > +Date:              June 2022
> > > +KernelVersion:  5.19
> > > +Contact:   Tianfei Zhang <tianfei.zhang@intel.com>
> > > +Description:       Read only. Returns the first MAC address in a block
> > > +           of sequential MAC addresses assigned to the board
> > > +           that is managed by the Intel MAX10 BMC. It is stored in
> > > +           FLASH storage and is mirrored in the MAX10 BMC register
> > > +           space.
> > > +           Format: "%02x:%02x:%02x:%02x:%02x:%02x".
> > > +
> > > +What:              /sys/bus/dfl/drivers/dfl-pmci-
> > bmc/dfl_dev.X/mac_count
> > > +Date:              June 2022
> > > +KernelVersion:  5.19
> > > +Contact:   Tianfei Zhang <tianfei.zhang@intel.com>
> > > +Description:       Read only. Returns the number of sequential MAC
> > > +           addresses assigned to the board managed by the Intel
> > > +           MAX10 BMC. This value is stored in FLASH and is mirrored
> > > +           in the MAX10 BMC register space.
> > > +           Format: "%u".
> >
> > This file looks like a duplicate at sys-driver-intel-m10-bmc.
> >
> > So the show commands below are duplicates.
> 
> Yes, I agree that the file " sysfs-driver-intel-m10-bmc" and " sysfs-driver-intel-m10-bmc-pmci" are duplicates, I will combine those into one.
> >
> > Refactoring is necessary.
> >
> > My recommendation is the existing intel-m10-bmc.c hold the common parts.
> >
> > intel-m10-bmc.c is spi, so the spi specific bits be split to new intel-m10-bmc-spi.c
> 
> In my V2 patch, I split the intel-m10-bmc.c into intel-m10-bmc-core.c and intel-m10-bmc-pmci.c, intel-m10-bmc-core.c hold the command parts.
> But Yilun suggested that it is only 40~50 line codes are duplicates, it is no necessary to hold the common parts. In V3 patch, I directly write a separate
> driver for intel-m10-bmc-pmci driver.

Hi tianfei:

I see the driver still includes intel-m10-bmc.h, and uses
struct intel_m10bmc. So I don't think this is a separate driver.

I think to be a separate driver, it should remove the dependency
to intel_m10bmc. The subdevice drivers should also remove the dependency
to intel_m10bmc. So maybe you need to estimate whether to make the
separate driver or still reuse the intel-m10-bmc.

Thanks,
Yilun

> 
> >
> > Tom
> >
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig index
> > > 3b59456f5545..ee196c41a9db 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -2171,6 +2171,16 @@ config MFD_INTEL_M10_BMC
> > >       additional drivers must be enabled in order to use the functionality
> > >       of the device.
> > >
> > > +config MFD_INTEL_M10_BMC_PMCI
> > > +   tristate "Intel MAX 10 Board Management Controller with PMCI"
> > > +   depends on FPGA_DFL
> > > +   help
> > > +     Support for the Intel MAX 10 board management controller via PMCI.
> > > +
> > > +     This driver provides common support for accessing the device,
> > > +     additional drivers must be enabled in order to use the functionality
> > > +     of the device.
> > > +
> > >   config MFD_RSMU_I2C
> > >     tristate "Renesas Synchronization Management Unit with I2C"
> > >     depends on I2C && OF
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile index
> > > 858cacf659d6..f737bd7b7d98 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -267,6 +267,7 @@ obj-$(CONFIG_MFD_QCOM_PM8008)   += qcom-
> > pm8008.o
> > >   obj-$(CONFIG_SGI_MFD_IOC3)        += ioc3.o
> > >   obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)  += simple-mfd-i2c.o
> > >   obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> > > +obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   += intel-m10-bmc-pmci.o
> > >
> > >   obj-$(CONFIG_MFD_ATC260X) += atc260x-core.o
> > >   obj-$(CONFIG_MFD_ATC260X_I2C)     += atc260x-i2c.o
> > > diff --git a/drivers/mfd/intel-m10-bmc-pmci.c
> > > b/drivers/mfd/intel-m10-bmc-pmci.c
> > > new file mode 100644
> > > index 000000000000..93eca4483ac7
> > > --- /dev/null
> > > +++ b/drivers/mfd/intel-m10-bmc-pmci.c
> > > @@ -0,0 +1,277 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PMCI-based interface to MAX10 BMC
> > > + *
> > > + * Copyright (C) 2020-2022 Intel Corporation, Inc.
> > > + *
> > > + */
> > > +#include <linux/bitfield.h>
> > > +#include <linux/dfl.h>
> > > +#include <linux/mfd/intel-m10-bmc.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/mfd/core.h>
> > > +
> > > +#define M10BMC_PMCI_INDIRECT_BASE 0x400
> > > +#define INDIRECT_INT_US        1
> > > +#define INDIRECT_TIMEOUT_US    10000
> > > +
> > > +#define INDIRECT_CMD_OFF   0x0
> > > +#define INDIRECT_CMD_RD    BIT(0)
> > > +#define INDIRECT_CMD_WR    BIT(1)
> > > +#define INDIRECT_CMD_ACK   BIT(2)
> > > +
> > > +#define INDIRECT_ADDR_OFF  0x4
> > > +#define INDIRECT_RD_OFF    0x8
> > > +#define INDIRECT_WR_OFF    0xc
> > > +
> > > +struct indirect_ctx {
> > > +   void __iomem *base;
> > > +   struct device *dev;
> > > +   unsigned long sleep_us;
> > > +   unsigned long timeout_us;
> > > +};
> > > +
> > > +struct pmci_device {
> > > +   void __iomem *base;
> > > +   struct device *dev;
> > > +   struct intel_m10bmc m10bmc;
> > > +   struct indirect_ctx ctx;
> > > +};
> > > +
> > > +static int pmci_indirect_bus_clr_cmd(struct indirect_ctx *ctx) {
> > > +   unsigned int cmd;
> > > +   int ret;
> > > +
> > > +   writel(0, ctx->base + INDIRECT_CMD_OFF);
> > > +   ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> > > +                            (!cmd), ctx->sleep_us, ctx->timeout_us);
> > > +   if (ret)
> > > +           dev_err(ctx->dev, "%s timed out on clearing cmd 0x%xn",
> > __func__,
> > > +cmd);
> > > +
> > > +   return ret;
> > > +}
> > > +
> > > +static int pmci_indirect_bus_reg_read(void *context, unsigned int reg,
> > > +                                 unsigned int *val)
> > > +{
> > > +   struct indirect_ctx *ctx = context;
> > > +   unsigned int cmd;
> > > +   int ret;
> > > +
> > > +   cmd = readl(ctx->base + INDIRECT_CMD_OFF);
> > > +   if (cmd)
> > > +           dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__,
> > cmd);
> > > +
> > > +   writel(reg, ctx->base + INDIRECT_ADDR_OFF);
> > > +   writel(INDIRECT_CMD_RD, ctx->base + INDIRECT_CMD_OFF);
> > > +   ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> > > +                            (cmd & INDIRECT_CMD_ACK), ctx->sleep_us,
> > > +                            ctx->timeout_us);
> > > +   if (ret) {
> > > +           dev_err(ctx->dev, "%s timed out on reg 0x%x cmd 0x%x\n",
> > __func__, reg, cmd);
> > > +           goto out;
> > > +   }
> > > +
> > > +   *val = readl(ctx->base + INDIRECT_RD_OFF);
> > > +
> > > +   if (pmci_indirect_bus_clr_cmd(ctx))
> > > +           ret = -ETIMEDOUT;
> > > +
> > > +out:
> > > +   return ret;
> > > +}
> > > +
> > > +static int pmci_indirect_bus_reg_write(void *context, unsigned int reg,
> > > +                                  unsigned int val)
> > > +{
> > > +   struct indirect_ctx *ctx = context;
> > > +   unsigned int cmd;
> > > +   int ret;
> > > +
> > > +   cmd = readl(ctx->base + INDIRECT_CMD_OFF);
> > > +   if (cmd)
> > > +           dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__,
> > cmd);
> > > +
> > > +   writel(val, ctx->base + INDIRECT_WR_OFF);
> > > +   writel(reg, ctx->base + INDIRECT_ADDR_OFF);
> > > +   writel(INDIRECT_CMD_WR, ctx->base + INDIRECT_CMD_OFF);
> > > +   ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> > > +                            (cmd & INDIRECT_CMD_ACK), ctx->sleep_us,
> > > +                            ctx->timeout_us);
> > > +   if (ret) {
> > > +           dev_err(ctx->dev, "%s timed out on reg 0x%x cmd 0x%x\n",
> > __func__, reg, cmd);
> > > +           goto out;
> > > +   }
> > > +
> > > +   if (pmci_indirect_bus_clr_cmd(ctx))
> > > +           ret = -ETIMEDOUT;
> > > +
> > > +out:
> > > +   return ret;
> > > +}
> > > +
> > > +static const struct regmap_bus pmci_indirect_bus = {
> > > +   .reg_write = pmci_indirect_bus_reg_write,
> > > +   .reg_read =  pmci_indirect_bus_reg_read, };
> > > +
> > > +static struct mfd_cell m10bmc_n6000_bmc_subdevs[] = {
> > > +   { .name = "n6000bmc-hwmon" },
> > > +   { .name = "n6000bmc-sec-update" }
> > > +};
> > > +
> > > +static struct regmap_config m10bmc_pmci_regmap_config = {
> > > +   .reg_bits = 32,
> > > +   .reg_stride = 4,
> > > +   .val_bits = 32,
> > > +   .max_register = M10BMC_PMCI_SYS_END, };
> > > +
> > > +static ssize_t bmc_version_show(struct device *dev,
> > > +                           struct device_attribute *attr, char *buf) {
> > > +   struct intel_m10bmc *ddata = dev_get_drvdata(dev);
> > > +   unsigned int val;
> > > +   int ret;
> > > +
> > > +   ret = m10bmc_sys_read(ddata, M10BMC_PMCI_BUILD_VER, &val);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   return sprintf(buf, "0x%x\n", val);
> > > +}
> > > +static DEVICE_ATTR_RO(bmc_version);
> > > +
> > > +static ssize_t bmcfw_version_show(struct device *dev,
> > > +                             struct device_attribute *attr, char *buf) {
> > > +   struct intel_m10bmc *ddata = dev_get_drvdata(dev);
> > > +   unsigned int val;
> > > +   int ret;
> > > +
> > > +   ret = m10bmc_sys_read(ddata, NIOS2_PMCI_FW_VERSION, &val);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   return sprintf(buf, "0x%x\n", val);
> > > +}
> > > +static DEVICE_ATTR_RO(bmcfw_version);
> > > +
> > > +static ssize_t mac_address_show(struct device *dev,
> > > +                           struct device_attribute *attr, char *buf) {
> > > +   struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> > > +   unsigned int macaddr_low, macaddr_high;
> > > +   int ret;
> > > +
> > > +   ret = m10bmc_sys_read(max10, M10BMC_PMCI_MAC_LOW,
> > &macaddr_low);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   ret = m10bmc_sys_read(max10, M10BMC_PMCI_MAC_HIGH,
> > &macaddr_high);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   return sysfs_emit(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
> > > +                     (u8)FIELD_GET(M10BMC_MAC_BYTE1, macaddr_low),
> > > +                     (u8)FIELD_GET(M10BMC_MAC_BYTE2, macaddr_low),
> > > +                     (u8)FIELD_GET(M10BMC_MAC_BYTE3, macaddr_low),
> > > +                     (u8)FIELD_GET(M10BMC_MAC_BYTE4, macaddr_low),
> > > +                     (u8)FIELD_GET(M10BMC_MAC_BYTE5,
> > macaddr_high),
> > > +                     (u8)FIELD_GET(M10BMC_MAC_BYTE6,
> > macaddr_high)); } static
> > > +DEVICE_ATTR_RO(mac_address);
> > > +
> > > +static ssize_t mac_count_show(struct device *dev,
> > > +                         struct device_attribute *attr, char *buf) {
> > > +   struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> > > +   unsigned int macaddr_high;
> > > +   int ret;
> > > +
> > > +   ret = m10bmc_sys_read(max10, M10BMC_PMCI_MAC_HIGH,
> > &macaddr_high);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   return sysfs_emit(buf, "%u\n",
> > > +                     (u8)FIELD_GET(M10BMC_MAC_COUNT,
> > macaddr_high)); } static
> > > +DEVICE_ATTR_RO(mac_count);
> > > +
> > > +static struct attribute *m10bmc_attrs[] = {
> > > +   &dev_attr_bmc_version.attr,
> > > +   &dev_attr_bmcfw_version.attr,
> > > +   &dev_attr_mac_address.attr,
> > > +   &dev_attr_mac_count.attr,
> > > +   NULL,
> > > +};
> > > +ATTRIBUTE_GROUPS(m10bmc);
> > > +
> > > +static int pmci_probe(struct dfl_device *ddev) {
> > > +   struct device *dev = &ddev->dev;
> > > +   struct mfd_cell *cells;
> > > +   struct pmci_device *pmci;
> > > +   int ret, n_cell;
> > > +
> > > +   pmci = devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
> > > +   if (!pmci)
> > > +           return -ENOMEM;
> > > +
> > > +   pmci->m10bmc.dev = dev;
> > > +   pmci->dev = dev;
> > > +
> > > +   pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
> > > +   if (IS_ERR(pmci->base))
> > > +           return PTR_ERR(pmci->base);
> > > +
> > > +   dev_set_drvdata(dev, &pmci->m10bmc);
> > > +
> > > +   pmci->ctx.base = pmci->base + M10BMC_PMCI_INDIRECT_BASE;
> > > +   pmci->ctx.sleep_us = INDIRECT_INT_US;
> > > +   pmci->ctx.timeout_us = INDIRECT_TIMEOUT_US;
> > > +   pmci->ctx.dev = dev;
> > > +   pmci->m10bmc.regmap =
> > > +           devm_regmap_init(dev,
> > > +                            &pmci_indirect_bus,
> > > +                            &pmci->ctx,
> > > +                            &m10bmc_pmci_regmap_config);
> > > +   if (IS_ERR(pmci->m10bmc.regmap))
> > > +           return PTR_ERR(pmci->m10bmc.regmap);
> > > +
> > > +   cells = m10bmc_n6000_bmc_subdevs;
> > > +   n_cell = ARRAY_SIZE(m10bmc_n6000_bmc_subdevs);
> > > +
> > > +   ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > > +                              cells, n_cell, NULL, 0, NULL);
> > > +   if (ret)
> > > +           dev_err(dev, "Failed to register sub-devices: %d\n",
> > > +                   ret);
> > > +
> > > +   return ret;
> > > +}
> > > +
> > > +#define FME_FEATURE_ID_PMCI_BMC    0x12
> > > +
> > > +static const struct dfl_device_id pmci_ids[] = {
> > > +   { FME_ID, FME_FEATURE_ID_PMCI_BMC },
> > > +   { }
> > > +};
> > > +MODULE_DEVICE_TABLE(dfl, pmci_ids);
> > > +
> > > +static struct dfl_driver pmci_driver = {
> > > +   .drv    = {
> > > +           .name       = "dfl-pmci-bmc",
> > > +           .dev_groups = m10bmc_groups,
> > > +   },
> > > +   .id_table = pmci_ids,
> > > +   .probe    = pmci_probe,
> > > +};
> > > +
> > > +module_dfl_driver(pmci_driver);
> > > +
> > > +MODULE_DESCRIPTION("MAX10 BMC PMCI-based interface");
> > > +MODULE_AUTHOR("Intel Corporation"); MODULE_LICENSE("GPL");
> > > diff --git a/include/linux/mfd/intel-m10-bmc.h
> > > b/include/linux/mfd/intel-m10-bmc.h
> > > index f0044b14136e..7b58af207b72 100644
> > > --- a/include/linux/mfd/intel-m10-bmc.h
> > > +++ b/include/linux/mfd/intel-m10-bmc.h
> > > @@ -118,6 +118,14 @@
> > >   /* Address of 4KB inverted bit vector containing staging area FLASH count */
> > >   #define STAGING_FLASH_COUNT       0x17ffb000
> > >
> > > +#define M10BMC_PMCI_SYS_BASE 0x0
> > > +#define M10BMC_PMCI_SYS_END  0xfff
> > > +
> > > +#define M10BMC_PMCI_BUILD_VER   0x0
> > > +#define NIOS2_PMCI_FW_VERSION   0x4
> > > +#define M10BMC_PMCI_MAC_LOW     0x20
> > > +#define M10BMC_PMCI_MAC_HIGH    0x24
> > > +
> > >   /**
> > >    * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
> > >    * @dev: this device
> 

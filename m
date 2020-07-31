Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437122341B4
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jul 2020 10:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbgGaI7f (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 31 Jul 2020 04:59:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:42284 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbgGaI7f (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 31 Jul 2020 04:59:35 -0400
IronPort-SDR: StyKbkGhsK3sB5vyT8qvrMjv8EFxGtC0YTx47QdHHyNKK18JOm7CZ58M2be8RjdrpjPyjl73ID
 uqNsERbsUFuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="169860176"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="169860176"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 01:59:33 -0700
IronPort-SDR: uHs9itkuZ489gC8gpf/vSJlhHoX4Wkg7mT0r4QlLXH6Xpc5HVVC7Hi6E47MDb1MZlJERRuDU5u
 jODi8zoV0mPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="287123883"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2020 01:59:31 -0700
Date:   Fri, 31 Jul 2020 16:56:09 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2 4/4] fpga: dfl: add support for N3000 nios private
  feature
Message-ID: <20200731085609.GF1781@yilunxu-OptiPlex-7050>
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
 <1595556555-9903-5-git-send-email-yilun.xu@intel.com>
 <f666ab1c-6d7c-c24a-6efa-50d24bde5231@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f666ab1c-6d7c-c24a-6efa-50d24bde5231@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Jul 25, 2020 at 07:53:59AM -0700, Tom Rix wrote:
> Mostly little stuff.
> 
> The polling on the int in ns_bus_poll_stat_timeout should be refactored.
> 
> Tom
> 
> On 7/23/20 7:09 PM, Xu Yilun wrote:
> > This patch adds support for the nios handshake private feature on Intel
> > N3000 FPGA Card. This private feature provides a handshake interface to
> > FPGA NIOS firmware, which receives retimer configuration command from host
> > and executes via an internal SPI master. When nios finished the
> > configuration, host takes over the ownership of the SPI master to control
> > an Intel MAX10 BMC Chip on the SPI bus.
> >
> > For NIOS firmware handshake part, this driver requests the retimer
> > configuration for NIOS with parameters from module param, and adds some
> > sysfs nodes for user to query NIOS state.
> >
> > For SPI part, this driver adds a spi-altera platform device as well as
> > the MAX10 BMC spi slave info. A spi-altera driver will be matched to
> > handle following the SPI work.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > ---
> >  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  16 +
> >  drivers/fpga/Kconfig                               |  12 +
> >  drivers/fpga/Makefile                              |   2 +
> >  drivers/fpga/dfl-n3000-nios.c                      | 483 +++++++++++++++++++++
> >  4 files changed, 513 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> >  create mode 100644 drivers/fpga/dfl-n3000-nios.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> > new file mode 100644
> > index 0000000..8346b74
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> > @@ -0,0 +1,16 @@
> > +What:		/sys/bus/dfl/devices/dfl-fme.X.X/fec_mode
> > +Date:		July 2020
> > +KernelVersion:	5.9
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Read-only. It returns the FEC mode of the ethernet retimer
> > +		configured by NIOS firmware. "rs" for RS FEC mode, "kr" for
> > +		KR FEC mode, "no" FOR NO FEC mode.
> > +		Format: string
> > +
> > +What:		/sys/bus/dfl/devices/dfl-fme.X.X/nios_fw_version
> > +Date:		July 2020
> > +KernelVersion:	5.9
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Read-only. It returns the NIOS firmware version in FPGA. Its
> > +		format is "major.minor.patch".
> > +		Format: %x.%x.%x
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index b2408a7..fa5f3ab 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -191,6 +191,18 @@ config FPGA_DFL_AFU
> >  	  to the FPGA infrastructure via a Port. There may be more than one
> >  	  Port/AFU per DFL based FPGA device.
> >  
> > +config FPGA_DFL_N3000_NIOS
> > +        tristate "FPGA DFL N3000 NIOS Driver"
> > +        depends on FPGA_DFL
> > +        select REGMAP
> depends on SPI_MASTER ?

I think we don't have to add this. The driver doesn't call any API
provided by SPI core, just fills the spi_board_info structure.

> > +        help
> > +	  This is the driver for the nios handshake private feature on Intel
> > +	  N3000 FPGA Card. This private feature provides a handshake interface
> > +	  to FPGA NIOS firmware, which receives retimer configuration command
> > +	  from host and executes via an internal SPI master. When nios finished
> > +	  the configuration, host takes over the ownership of the SPI master to
> > +	  control an Intel MAX10 BMC Chip on the SPI bus.
> > +
> >  config FPGA_DFL_PCI
> >  	tristate "FPGA DFL PCIe Device Driver"
> >  	depends on PCI && FPGA_DFL
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index d8e21df..27f20f2 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -44,5 +44,7 @@ dfl-fme-objs += dfl-fme-perf.o
> >  dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
> >  dfl-afu-objs += dfl-afu-error.o
> >  
> > +obj-$(CONFIG_FPGA_DFL_N3000_NIOS)      += dfl-n3000-nios.o
> > +
> >  # Drivers for FPGAs which implement DFL
> >  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> > diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
> > new file mode 100644
> > index 0000000..d098a10
> > --- /dev/null
> > +++ b/drivers/fpga/dfl-n3000-nios.c
> > @@ -0,0 +1,483 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for DFL N3000 NIOS private feature
> > + *
> > + * Copyright (C) 2019-2020 Intel Corporation, Inc.
> > + *
> > + * Authors:
> > + *   Wu Hao <hao.wu@intel.com>
> > + *   Xu Yilun <yilun.xu@intel.com>
> > + */
> > +#include <linux/bitfield.h>
> > +#include <linux/errno.h>
> > +#include <linux/io.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/stddef.h>
> > +#include <linux/spi/altera.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/types.h>
> > +
> > +#include "dfl.h"
> > +
> > +static char *fec_mode = "rs";
> > +module_param(fec_mode, charp, 0444);
> > +MODULE_PARM_DESC(child, "FEC mode");
> 
> Should document what the valid values are and what they mean.
> 
> ex/ what is 'rs' ?
> 
> Maybe append something in the sysfs doc about fec_mode being settable.

Yes, I'll add the documents.

> 
> > +
> > +/* N3000 NIOS private feature registers */
> > +#define NIOS_SPI_PARAM		0x8
> > +#define SHIFT_MODE		BIT_ULL(1)
> > +#define SHIFT_MODE_MSB		0
> > +#define SHIFT_MODE_LSB		1
> > +#define DATA_WIDTH		GENMASK_ULL(7, 2)
> > +#define NUM_CHIPSELECT		GENMASK_ULL(13, 8)
> > +#define CLK_POLARITY		BIT_ULL(14)
> > +#define CLK_PHASE		BIT_ULL(15)
> > +#define PERIPHERAL_ID		GENMASK_ULL(47, 32)
> > +
> > +#define NIOS_SPI_CTRL		0x10
> > +#define CTRL_WR_DATA		GENMASK_ULL(31, 0)
> > +#define CTRL_ADDR		GENMASK_ULL(44, 32)
> > +#define CTRL_CMD		GENMASK_ULL(63, 62)
> > +#define CMD_NOP			0
> > +#define CMD_RD			1
> > +#define CMD_WR			2
> These are fairly generic #define names, consider adding a prefix.

Yes.

> > +
> > +#define NIOS_SPI_STAT		0x18
> > +#define STAT_RD_DATA		GENMASK_ULL(31, 0)
> > +#define STAT_RW_VAL		BIT_ULL(32)
> > +
> > +/* nios handshake registers, indirect access */
> > +#define NIOS_INIT		0x1000
> > +#define NIOS_INIT_DONE		BIT(0)
> > +#define NIOS_INIT_START		BIT(1)
> > +/* Mode for PKVL A, link 0, the same below */
> > +#define REQ_FEC_MODE_A0		GENMASK(9, 8)
> > +#define REQ_FEC_MODE_A1		GENMASK(11, 10)
> > +#define REQ_FEC_MODE_A2		GENMASK(13, 12)
> > +#define REQ_FEC_MODE_A3		GENMASK(15, 14)
> > +#define REQ_FEC_MODE_B0		GENMASK(17, 16)
> > +#define REQ_FEC_MODE_B1		GENMASK(19, 18)
> > +#define REQ_FEC_MODE_B2		GENMASK(21, 20)
> > +#define REQ_FEC_MODE_B3		GENMASK(23, 22)
> > +#define FEC_MODE_NO		0x0
> > +#define FEC_MODE_KR		0x1
> > +#define FEC_MODE_RS		0x2
> > +
> > +#define NIOS_FW_VERSION		0x1004
> > +#define NIOS_FW_VERSION_PATCH	GENMASK(23, 20)
> > +#define NIOS_FW_VERSION_MINOR	GENMASK(27, 24)
> > +#define NIOS_FW_VERSION_MAJOR	GENMASK(31, 28)
> > +
> > +#define PKVL_A_MODE_STS		0x1020
> > +#define PKVL_B_MODE_STS		0x1024
> > +
> > +#define NS_REGBUS_WAIT_TIMEOUT	10000		/* loop count */
> > +#define NIOS_INIT_TIMEOUT	10000000	/* usec */
> > +#define NIOS_INIT_TIME_INTV	100000		/* usec */
> > +
> > +struct dfl_n3000_nios {
> > +	void __iomem *base;
> > +	struct regmap *regmap;
> > +	struct device *dev;
> > +	struct platform_device *altr_spi;
> Make this element more meaningful, expand to 'altera_spi'

Yes.

> > +};
> > +
> > +static int n3000_nios_writel(struct dfl_n3000_nios *ns, unsigned int reg,
> > +			     unsigned int val)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_write(ns->regmap, reg, val);
> > +	if (ret)
> > +		dev_err(ns->dev, "fail to write reg 0x%x val 0x%x: %d\n",
> > +			reg, val, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int n3000_nios_readl(struct dfl_n3000_nios *ns, unsigned int reg,
> > +			    unsigned int *val)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_read(ns->regmap, reg, val);
> > +	if (ret)
> > +		dev_err(ns->dev, "fail to read reg 0x%x: %d\n", reg, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static ssize_t nios_fw_version_show(struct device *dev,
> > +				    struct device_attribute *attr, char *buf)
> > +{
> > +	struct dfl_n3000_nios *ns = dev_get_drvdata(dev);
> > +	unsigned int val;
> > +	int ret;
> 
> This and similar could be
> 
> ssize_t ret.

I think it may not be necessary. It is not reasonable n3000_nios_readl()
has the return type ssize_t. So no matter how you define the ret, the
cast is always needed.

I see the general handling of this case in drivers is "int ret".

> 
> > +
> > +	ret = n3000_nios_readl(ns, NIOS_FW_VERSION, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return sprintf(buf, "%x.%x.%x\n",
> > +		       (u8)FIELD_GET(NIOS_FW_VERSION_MAJOR, val),
> > +		       (u8)FIELD_GET(NIOS_FW_VERSION_MINOR, val),
> > +		       (u8)FIELD_GET(NIOS_FW_VERSION_PATCH, val));
> > +}
> > +static DEVICE_ATTR_RO(nios_fw_version);
> > +
> > +static ssize_t fec_mode_show(struct device *dev,
> > +			     struct device_attribute *attr, char *buf)
> > +{
> > +	struct dfl_n3000_nios *ns = dev_get_drvdata(dev);
> > +	unsigned int val, mode;
> > +	int ret;
> > +
> > +	ret = n3000_nios_readl(ns, NIOS_INIT, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * FEC mode should always be the same for all links, as we set them
> > +	 * in this way.
> > +	 */
> > +	mode = FIELD_GET(REQ_FEC_MODE_A0, val);
> > +	if (mode != FIELD_GET(REQ_FEC_MODE_A1, val) ||
> > +	    mode != FIELD_GET(REQ_FEC_MODE_A2, val) ||
> > +	    mode != FIELD_GET(REQ_FEC_MODE_A3, val) ||
> > +	    mode != FIELD_GET(REQ_FEC_MODE_B0, val) ||
> > +	    mode != FIELD_GET(REQ_FEC_MODE_B1, val) ||
> > +	    mode != FIELD_GET(REQ_FEC_MODE_B2, val) ||
> > +	    mode != FIELD_GET(REQ_FEC_MODE_B3, val))
> > +		return -EFAULT;
> > +
> > +	switch (mode) {
> > +	case FEC_MODE_NO:
> > +		return sprintf(buf, "no\n");
> > +	case FEC_MODE_KR:
> > +		return sprintf(buf, "kr\n");
> > +	case FEC_MODE_RS:
> > +		return sprintf(buf, "rs\n");
> > +	}
> > +
> > +	return -EFAULT;
> > +}
> > +static DEVICE_ATTR_RO(fec_mode);
> > +
> > +static struct attribute *n3000_nios_attrs[] = {
> > +	&dev_attr_nios_fw_version.attr,
> > +	&dev_attr_fec_mode.attr,
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(n3000_nios);
> > +
> > +static int init_error_detected(struct dfl_n3000_nios *ns)
> returning true/false, the return type should be boolean

Yes.

> > +{
> > +	unsigned int val;
> > +
> > +	if (n3000_nios_readl(ns, PKVL_A_MODE_STS, &val))
> > +		return true;
> > +
> > +	if (val >= 0x100)
> 
> A magic number like 0x100 should be #define-ed.
> 
> similar below

Yes, I could improve this.

> 
> > +		return true;
> > +
> > +	if (n3000_nios_readl(ns, PKVL_B_MODE_STS, &val))
> > +		return true;
> > +
> > +	if (val >= 0x100)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static void dump_error_stat(struct dfl_n3000_nios *ns)
> > +{
> > +	unsigned int val;
> > +
> > +	if (n3000_nios_readl(ns, PKVL_A_MODE_STS, &val))
> > +		return;
> 
> Not being able to read the register is itself and error.
> 
> Should add something like 'Could not read register PKVL_A_MODE_STS'
> 
> similar below

Yes, I could add the error log.

> 
> > +
> > +	dev_info(ns->dev, "PKVL_A_MODE_STS %x\n", val);
> > +
> > +	if (n3000_nios_readl(ns, PKVL_B_MODE_STS, &val))
> > +		return;
> > +
> > +	dev_info(ns->dev, "PKVL_B_MODE_STS %x\n", val);
> > +}
> > +
> > +static int n3000_nios_init_done_check(struct dfl_n3000_nios *ns)
> > +{
> > +	struct device *dev = ns->dev;
> > +	unsigned int val, mode;
> > +	int ret;
> > +
> > +	/*
> > +	 * this SPI is shared by NIOS core inside FPGA, NIOS will use this SPI
> > +	 * master to do some one time initialization after power up, and then
> > +	 * release the control to OS. driver needs to poll on INIT_DONE to
> > +	 * see when driver could take the control.
> > +	 *
> > +	 * Please note that after 3.x.x version, INIT_START is introduced, so
> > +	 * driver needs to trigger START firstly and then check INIT_DONE.
> > +	 */
> > +
> > +	ret = n3000_nios_readl(ns, NIOS_FW_VERSION, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * If NIOS version register is totally uninitialized(== 0x0), then the
> > +	 * NIOS firmware is missing. So host could take control of SPI master
> > +	 * safely, but initialization work for NIOS is not done. This is an
> > +	 * issue of FPGA image. We didn't error out because we need SPI master
> > +	 * to reprogram a new image.
> > +	 */
> > +	if (val == 0) {
> > +		dev_warn(dev, "NIOS version reg = 0x%x, skip INIT_DONE check, but PKVL may be uninitialized\n",
> > +			 val);
> > +		return 0;
> > +	}
> > +
> > +	if (FIELD_GET(NIOS_FW_VERSION_MAJOR, val) >= 3) {
> > +		/* read NIOS_INIT to check if PKVL INIT done or not */
> > +		ret = n3000_nios_readl(ns, NIOS_INIT, &val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* check if PKVLs are initialized already */
> > +		if (val & NIOS_INIT_DONE || val & NIOS_INIT_START)
> > +			goto nios_init_done;
> > +
> > +		/* configure FEC mode per module param */
> > +		val = NIOS_INIT_START;
> > +
> > +		/* FEC mode will be ignored by hardware in 10G mode */
> > +		if (!strcmp(fec_mode, "no"))
> strncmp is safer but would lead to 'no123' being valid.

We do use strcmp here, so are we OK here?

> > +			mode = FEC_MODE_NO;
> > +		else if (!strcmp(fec_mode, "kr"))
> > +			mode = FEC_MODE_KR;
> > +		else if (!strcmp(fec_mode, "rs"))
> > +			mode = FEC_MODE_RS;
> > +		else
> > +			return -EINVAL;
> > +
> > +		/* set the same FEC mode for all links */
> > +		val |= FIELD_PREP(REQ_FEC_MODE_A0, mode) |
> > +		       FIELD_PREP(REQ_FEC_MODE_A1, mode) |
> > +		       FIELD_PREP(REQ_FEC_MODE_A2, mode) |
> > +		       FIELD_PREP(REQ_FEC_MODE_A3, mode) |
> > +		       FIELD_PREP(REQ_FEC_MODE_B0, mode) |
> > +		       FIELD_PREP(REQ_FEC_MODE_B1, mode) |
> > +		       FIELD_PREP(REQ_FEC_MODE_B2, mode) |
> > +		       FIELD_PREP(REQ_FEC_MODE_B3, mode);
> > +
> > +		ret = n3000_nios_writel(ns, NIOS_INIT, val);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +nios_init_done:
> > +	/* polls on NIOS_INIT_DONE */
> > +	ret = regmap_read_poll_timeout(ns->regmap, NIOS_INIT, val,
> > +				       val & NIOS_INIT_DONE,
> > +				       NIOS_INIT_TIME_INTV,
> > +				       NIOS_INIT_TIMEOUT);
> > +	if (ret) {
> > +		dev_err(dev, "NIOS_INIT_DONE %s\n",
> > +			(ret == -ETIMEDOUT) ? "timed out" : "check error");
> > +		goto dump_sts;
> > +	}
> > +
> > +	/*
> > +	 * after INIT_DONE is detected, it still needs to check if any ERR
> > +	 * detected.
> > +	 * We won't error out here even if error detected. Nios will release
> > +	 * spi controller when INIT_DONE is set, so driver could continue to
> > +	 * initialize spi controller device.
> > +	 */
> > +	if (init_error_detected(ns)) {
> > +		dev_warn(dev, "NIOS_INIT_DONE OK, but err found during init\n");
> > +		goto dump_sts;
> > +	}
> > +	return 0;
> > +
> > +dump_sts:
> > +	dump_error_stat(ns);
> > +
> > +	return ret;
> > +}
> > +
> > +struct spi_board_info m10_n3000_info = {
> > +	.modalias = "m10-n3000",
> > +	.max_speed_hz = 12500000,
> > +	.bus_num = 0,
> > +	.chip_select = 0,
> > +};
> > +
> > +static int create_altr_spi_controller(struct dfl_n3000_nios *ns)
> Also here, altr -> altera

Yes

> > +{
> > +	struct altera_spi_platform_data pdata = { 0 };
> > +	struct platform_device_info pdevinfo = { 0 };
> > +	void __iomem *base = ns->base;
> > +	u64 v;
> > +
> > +	v = readq(base + NIOS_SPI_PARAM);
> > +
> > +	pdata.mode_bits = SPI_CS_HIGH;
> > +	if (FIELD_GET(CLK_POLARITY, v))
> > +		pdata.mode_bits |= SPI_CPOL;
> > +	if (FIELD_GET(CLK_PHASE, v))
> > +		pdata.mode_bits |= SPI_CPHA;
> > +
> > +	pdata.num_chipselect = FIELD_GET(NUM_CHIPSELECT, v);
> > +	pdata.bits_per_word_mask =
> > +		SPI_BPW_RANGE_MASK(1, FIELD_GET(DATA_WIDTH, v));
> > +
> > +	pdata.num_devices = 1;
> > +	pdata.devices = &m10_n3000_info;
> > +
> > +	dev_dbg(ns->dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
> > +		pdata.num_chipselect, pdata.bits_per_word_mask,
> > +		pdata.mode_bits);
> > +
> > +	pdevinfo.name = "subdev_spi_altera";
> > +	pdevinfo.id = PLATFORM_DEVID_AUTO;
> > +	pdevinfo.parent = ns->dev;
> > +	pdevinfo.data = &pdata;
> > +	pdevinfo.size_data = sizeof(pdata);
> > +
> > +	ns->altr_spi = platform_device_register_full(&pdevinfo);
> > +	return PTR_ERR_OR_ZERO(ns->altr_spi);
> > +}
> > +
> > +static void destroy_altr_spi_controller(struct dfl_n3000_nios *ns)
> > +{
> > +	platform_device_unregister(ns->altr_spi);
> > +}
> > +
> > +static int ns_bus_poll_stat_timeout(void __iomem *base, u64 *v)
> > +{
> > +	int loops = NS_REGBUS_WAIT_TIMEOUT;
> 
> Would not this be better as time based timeout ?
> 
> Looping over int is only good if you know the clock freq etc.

Time based timeout is more reasonable, but it will drop the performance:
1. The indirect bus is accessed so frequently. It is on the critical
   path of FPGA image flashing.
2. The state change time is very short, usually in 1 or 2 loops.

We've profiled that if we add time check here then, FPGA image flash
time would be several minutes longer.

Anyway, 10000 times loop is large enough.

> 
> Could this polling be switch to interrupt ?

We don't have interrupt source here.

> 
> > +
> > +	/*
> > +	 * Usually the state changes in few loops, so we try to be simple here
> > +	 * for performance.
> > +	 */
> > +	do {
> > +		*v = readq(base + NIOS_SPI_STAT);
> > +		if (*v & STAT_RW_VAL)
> > +			break;
> > +		cpu_relax();
> > +	} while (--loops);
> > +
> > +	return loops ? 0 : -ETIMEDOUT;
> > +}
> > +
> > +static int ns_bus_reg_write(void *context, unsigned int reg, unsigned int val)
> 
> what is 'ns_' ?

It is the abbreviation of nios_spi, is that OK?
I don't want a long prefix for everything, but still want a namespace.

> 
> Maybe this should be 'nios_spi' or just drop the prefix.
> 
> > +{
> > +	void __iomem *base = context;
> > +	u64 v = 0;
> > +
> > +	v |= FIELD_PREP(CTRL_CMD, CMD_WR);
> > +	v |= FIELD_PREP(CTRL_ADDR, reg);
> > +	v |= FIELD_PREP(CTRL_WR_DATA, val);
> > +	writeq(v, base + NIOS_SPI_CTRL);
> > +
> > +	return ns_bus_poll_stat_timeout(base, &v);
> > +}
> > +
> > +static int ns_bus_reg_read(void *context, unsigned int reg, unsigned int *val)
> > +{
> > +	void __iomem *base = context;
> > +	u64 v = 0;
> > +	int ret;
> > +
> > +	v |= FIELD_PREP(CTRL_CMD, CMD_RD);
> > +	v |= FIELD_PREP(CTRL_ADDR, reg);
> > +	writeq(v, base + NIOS_SPI_CTRL);
> > +
> > +	ret = ns_bus_poll_stat_timeout(base, &v);
> > +	if (!ret)
> > +		*val = FIELD_GET(STAT_RD_DATA, v);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct regmap_config ns_regbus_cfg = {
> > +	.reg_bits = 32,
> > +	.reg_stride = 4,
> > +	.val_bits = 32,
> > +	.fast_io = true,
> > +
> > +	.reg_write = ns_bus_reg_write,
> > +	.reg_read = ns_bus_reg_read,
> > +};
> > +
> > +static int dfl_n3000_nios_probe(struct dfl_device *dfl_dev)
> > +{
> > +	struct device *dev = &dfl_dev->dev;
> > +	struct dfl_n3000_nios *ns;
> > +	int ret;
> > +
> > +	ns = devm_kzalloc(dev, sizeof(*ns), GFP_KERNEL);
> > +	if (!ns)
> > +		return -ENOMEM;
> > +
> > +	dev_set_drvdata(&dfl_dev->dev, ns);
> > +
> > +	ns->dev = dev;
> > +
> > +	ns->base = devm_ioremap_resource(&dfl_dev->dev, &dfl_dev->mmio_res);
> > +	if (IS_ERR(ns->base)) {
> > +		dev_err(dev, "get mem resource fail!\n");
> > +		return PTR_ERR(ns->base);
> > +	}
> > +
> > +	ns->regmap = devm_regmap_init(dev, NULL, ns->base, &ns_regbus_cfg);
> > +	if (IS_ERR(ns->regmap))
> > +		return PTR_ERR(ns->regmap);
> > +
> > +	ret = n3000_nios_init_done_check(ns);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = create_altr_spi_controller(ns);
> > +	if (ret)
> > +		dev_err(dev, "altr spi controller create failed: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static void dfl_n3000_nios_remove(struct dfl_device *dfl_dev)
> > +{
> > +	struct dfl_n3000_nios *ns = dev_get_drvdata(&dfl_dev->dev);
> > +
> > +	destroy_altr_spi_controller(ns);
> > +}
> > +
> > +#define FME_FEATURE_ID_N3000_NIOS	0xd
> 
> To minimize collisions, maybe collect these to a new common header like 'dfl-features-ids.h' or just add to some other visible existing header.

I'm going to abstract the dfl-bus related stuff in a new head file,
maybe we could change it when more dfl devices are added.

Thanks,
Yilun.

> 
> > +
> > +static const struct dfl_device_id dfl_n3000_nios_ids[] = {
> > +	{ FME_ID, FME_FEATURE_ID_N3000_NIOS },
> > +	{ }
> > +};
> > +
> > +static struct dfl_driver dfl_n3000_nios_driver = {
> > +	.drv	= {
> > +		.name       = "dfl-n3000-nios",
> > +		.dev_groups = n3000_nios_groups,
> > +	},
> > +	.id_table = dfl_n3000_nios_ids,
> > +	.probe   = dfl_n3000_nios_probe,
> > +	.remove  = dfl_n3000_nios_remove,
> > +};
> > +
> > +module_dfl_driver(dfl_n3000_nios_driver);
> > +
> > +MODULE_DEVICE_TABLE(dfl, dfl_n3000_nios_ids);
> > +MODULE_DESCRIPTION("DFL N3000 NIOS driver");
> > +MODULE_AUTHOR("Intel Corporation");
> > +MODULE_LICENSE("GPL v2");

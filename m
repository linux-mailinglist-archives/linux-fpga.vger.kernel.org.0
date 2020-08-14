Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C110C2444B6
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Aug 2020 07:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgHNF7N (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Aug 2020 01:59:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:62787 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgHNF7N (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 14 Aug 2020 01:59:13 -0400
IronPort-SDR: 7Sb7+Bx+uH/2m8h2uoP7tbPRBaTYXXOoWy+C2iA231jwkN2JtbdiLZ0npBc8NM/Gj3hpKjXA/l
 t8DI792IOIaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="218693511"
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; 
   d="scan'208";a="218693511"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 22:59:10 -0700
IronPort-SDR: aaW9vSeXr9sS/4oR0VMb5ZV8CaHQXrJittqy5Qptp4+uoi5TOC+rlptuNBOr93ME5i6B4mgqsG
 lc12pa+ZJxjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,311,1592895600"; 
   d="scan'208";a="470485147"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 13 Aug 2020 22:59:07 -0700
Date:   Fri, 14 Aug 2020 13:55:28 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH v5 3/3] fpga: dfl: add support for N3000 Nios private
  feature
Message-ID: <20200814055527.GA20337@yilunxu-OptiPlex-7050>
References: <1597303080-30640-1-git-send-email-yilun.xu@intel.com>
 <1597303080-30640-4-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819557E133CABA89288F2E085430@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819557E133CABA89288F2E085430@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Aug 13, 2020 at 04:43:33PM +0800, Wu, Hao wrote:
> > Subject: [PATCH v5 3/3] fpga: dfl: add support for N3000 Nios private feature
> >
> > This patch adds support for the Nios handshake private feature on Intel
> > PAC (Programmable Acceleration Card) N3000.
> >
> > The Nios is the embedded processor on the FPGA card. This private feature
> > provides a handshake interface to FPGA Nois firmware, which receives
> > retimer configuration command from host and executes via an internal SPI
> > master (spi-altera). When Nios finishes the configuration, host takes over
> > the ownership of the SPI master to control an Intel MAX10 BMC (Board
> > Management Controller) Chip on the SPI bus.
> >
> > For Nios firmware handshake part, this driver requests the retimer
> > configuration for Nios with parameters from module param, and adds some
> > sysfs nodes for user to query the onboard retimer's working mode and
> > Nios firmware version.
> >
> > For SPI part, this driver adds a spi-altera platform device as well as
> > the MAX10 BMC spi slave info. A spi-altera driver will be matched to
> > handle the following SPI work.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > ---
> > v3: Add the doc for this driver
> >     Minor fixes for comments from Tom
> > v4: Move the err log in regmap implementation, and delete
> >      n3000_nios_writel/readl(), they have nothing to wrapper now.
> >     Some minor fixes and comments improvement.
> > v5: Fix the output of fec_mode sysfs inf to "no" on 10G configuration,
> >     cause no FEC mode could be configured for 10G.
> >     Rename the dfl_n3000_nios_* to n3000_nios_*
> >     Improves comments.
> > ---
> >  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  18 +
> >  Documentation/fpga/dfl-n3000-nios.rst              |  45 ++
> >  Documentation/fpga/index.rst                       |   1 +
> >  drivers/fpga/Kconfig                               |  11 +
> >  drivers/fpga/Makefile                              |   2 +
> >  drivers/fpga/dfl-n3000-nios.c                      | 528 +++++++++++++++++++++
> >  6 files changed, 605 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-
> > n3000-nios
> >  create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
> >  create mode 100644 drivers/fpga/dfl-n3000-nios.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> > b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> > new file mode 100644
> > index 0000000..221d635
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> > @@ -0,0 +1,18 @@
> > +What:/sys/bus/dfl/devices/dfl_dev.X/fec_mode
> > +Date:Aug 2020
> > +KernelVersion:5.10
> > +Contact:Xu Yilun <yilun.xu@intel.com>
> > +Description:Read-only. It returns the FEC mode of the ethernet retimer
> > +configured by NIOS firmware. "rs" for Reed Solomon FEC,
> > "kr"
> > +for Fire Code FEC, "no" FOR NO FEC. The FEC mode could be
> > set
> > +by module parameters, but it could only be set once after the
> > +board powers up.
> > +Format: string
> > +
> > +What:/sys/bus/dfl/devices/dfl_dev.X/nios_fw_version
> > +Date:Aug 2020
> > +KernelVersion:5.10
> > +Contact:Xu Yilun <yilun.xu@intel.com>
> > +Description:Read-only. It returns the NIOS firmware version in FPGA. Its
> > +format is "major.minor.patch".
> > +Format: %x.%x.%x
> > diff --git a/Documentation/fpga/dfl-n3000-nios.rst
> > b/Documentation/fpga/dfl-n3000-nios.rst
> > new file mode 100644
> > index 0000000..c562aab
> > --- /dev/null
> > +++ b/Documentation/fpga/dfl-n3000-nios.rst
> > @@ -0,0 +1,45 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=================================
> > +N3000 Nios Private Feature Driver
> > +=================================
> > +
> > +The N3000 Nios driver supports for the Nios handshake private feature on
> > Intel
> > +PAC (Programmable Acceleration Card) N3000.
> > +
> > +The Nios is the embedded processor on the FPGA card. This private feature
> > +provides a handshake interface to FPGA Nios firmware, which receives the
> > +ethernet retimer configuration command from host and does the
> > configuration via
> > +an internal SPI master (spi-altera). When Nios finishes the configuration,
> > host
> > +takes over the ownership of the SPI master to control an Intel MAX10 BMC
> > (Board
> > +Management Controller) Chip on the SPI bus.
> > +
> > +So the driver does 2 major tasks on probe, uses the Nios firmware to
> > configure
> > +the ethernet retimer, and then creates a spi master platform device with
> > the
> > +MAX10 device info in spi_board_info.
> > +
> > +Module Parameters
> > +=================
> > +
> > +The N3000 Nios driver supports the following module parameters:
> > +
> > +* fec_mode: string
> > +  Require the Nios firmware to set the FEC (Forward Error Correction) mode
> > of
> > +  the ethernet retimer on the Intel PAC N3000. The possible values could be:
> > +
> > +  - "rs": Reed Solomon FEC (default)
> > +  - "kr": Fire Code FEC
> > +  - "no": No FEC
> > +
> > +  The configuration can only be set once after the board powers up, the
> > +  firmware will not accept second configuration afterward. So it is not
> > proper
> > +  to have a RW sysfs node for the FEC mode. A better way is that we set the
> > FEC
> > +  mode on driver probe according to the module parameter from user, and
> > create
> > +  a RO sysfs node for the FEC mode query.
> > +
> > +  Besides, the fec mode will not be changed if the module is reloaded with a
> > +  different param value.
> 
> And it won't work on hardware doesn't support this feature, e.g. 10G based
> Hardware as you mentioned.
> 
> And to be clear, it's better to mention that, on N3000, there are 2 retimer chips,
> each chip supports 4 links, which matches the code below, It configures all links
> of the retimers to the same FEC mode.

Yes I'll improve the comments.

> 
> > +
> > +  The configured value of the fec mode could be queried from sysfs node:
> > +
> > +  /sys/bus/dfl/devices/dfl_dev.X/fec_mode
> > diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
> > index f80f956..5fd3c37 100644
> > --- a/Documentation/fpga/index.rst
> > +++ b/Documentation/fpga/index.rst
> > @@ -8,6 +8,7 @@ fpga
> >      :maxdepth: 1
> >
> >      dfl
> > +    dfl-n3000-nios
> >
> >  .. only::  subproject and html
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 7cd5a29..f6252cd 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -191,6 +191,17 @@ config FPGA_DFL_AFU
> >    to the FPGA infrastructure via a Port. There may be more than one
> >    Port/AFU per DFL based FPGA device.
> >
> > +config FPGA_DFL_N3000_NIOS
> 
> FPGA_DFL_NIOS_INTEL_PAC_N3000

Why we need to be that specific? I think we don't have to add so many
info for the naming. dfl N3000 nios is unique and aligned with the file
name and driver name.

> 
> > +        tristate "FPGA DFL N3000 NIOS Driver"
> 
> FPGA DFL NIOS Driver for Intel PAC N3000
> 
> > +        depends on FPGA_DFL
> > +        select REGMAP
> > +        help
> > +  This is the driver for the N3000 Nios private feature on Intel
> > +  PAC (Programmable Acceleration Card) N3000. It communicates
> > +  with the embedded Nios processor to configure the retimers on
> > +  the card. It also instantiates the SPI master (spi-altera) for
> > +  the card's BMC (Board Management Controller) control.
> > +
> >  config FPGA_DFL_PCI
> >  tristate "FPGA DFL PCIe Device Driver"
> >  depends on PCI && FPGA_DFL
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
> >  obj-$(CONFIG_FPGA_DFL_PCI)+= dfl-pci.o
> > diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
> > new file mode 100644
> > index 0000000..aeac224
> > --- /dev/null
> > +++ b/drivers/fpga/dfl-n3000-nios.c
> > @@ -0,0 +1,528 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * DFL device driver for Nios private feature on Intel PAC (Programmable
> > + * Acceleration Card) N3000
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
> > +MODULE_PARM_DESC(fec_mode, "FEC mode of the ethernet retimer on
> > Intel PAC N3000");
> > +
> > +/* N3000 Nios private feature registers */
> > +#define NIOS_SPI_PARAM0x8
> > +#define PARAM_SHIFT_MODE_MSKBIT_ULL(1)
> > +#define PARAM_SHIFT_MODE_MSB0
> > +#define PARAM_SHIFT_MODE_LSB1
> > +#define PARAM_DATA_WIDTHGENMASK_ULL(7, 2)
> > +#define PARAM_NUM_CSGENMASK_ULL(13, 8)
> > +#define PARAM_CLK_POLBIT_ULL(14)
> > +#define PARAM_CLK_PHASEBIT_ULL(15)
> > +#define PARAM_PERIPHERAL_IDGENMASK_ULL(47, 32)
> > +
> > +#define NIOS_SPI_CTRL0x10
> > +#define CTRL_WR_DATAGENMASK_ULL(31, 0)
> > +#define CTRL_ADDRGENMASK_ULL(44, 32)
> > +#define CTRL_CMD_MSKGENMASK_ULL(63, 62)
> > +#define CTRL_CMD_NOP0
> > +#define CTRL_CMD_RD1
> > +#define CTRL_CMD_WR2
> > +
> > +#define NIOS_SPI_STAT0x18
> > +#define STAT_RD_DATAGENMASK_ULL(31, 0)
> > +#define STAT_RW_VALBIT_ULL(32)
> > +
> > +/* Nios handshake registers, indirect access */
> > +#define NIOS_INIT0x1000
> > +#define NIOS_INIT_DONEBIT(0)
> > +#define NIOS_INIT_STARTBIT(1)
> > +/* Mode for PKVL A, link 0, the same below */
> > +#define REQ_FEC_MODE_A0_MSKGENMASK(9, 8)
> > +#define REQ_FEC_MODE_A1_MSKGENMASK(11, 10)
> > +#define REQ_FEC_MODE_A2_MSKGENMASK(13, 12)
> > +#define REQ_FEC_MODE_A3_MSKGENMASK(15, 14)
> > +#define REQ_FEC_MODE_B0_MSKGENMASK(17, 16)
> > +#define REQ_FEC_MODE_B1_MSKGENMASK(19, 18)
> > +#define REQ_FEC_MODE_B2_MSKGENMASK(21, 20)
> > +#define REQ_FEC_MODE_B3_MSKGENMASK(23, 22)
> > +#define REQ_FEC_MODE_NO0x0
> > +#define REQ_FEC_MODE_KR0x1
> > +#define REQ_FEC_MODE_RS0x2
> > +
> > +#define NIOS_FW_VERSION0x1004
> > +#define NIOS_FW_VERSION_PATCHGENMASK(23, 20)
> > +#define NIOS_FW_VERSION_MINORGENMASK(27, 24)
> > +#define NIOS_FW_VERSION_MAJORGENMASK(31, 28)
> > +
> > +#define PKVL_A_MODE_STS0x1020
> > +#define PKVL_B_MODE_STS0x1024
> > +#define PKVL_MODE_STS_GROUP_MSKGENMASK(15, 8)
> > +#define PKVL_MODE_STS_GROUP_OK0x0
> > +#define PKVL_MODE_STS_ID_MSKGENMASK(7, 0)
> > +/* When GROUP MASK field == GROUP_OK  */
> > +#define PKVL_MODE_ID_RESET0x0
> > +#define PKVL_MODE_ID_4X10G0x1
> > +#define PKVL_MODE_ID_4X25G0x2
> > +#define PKVL_MODE_ID_2X25G0x3
> > +#define PKVL_MODE_ID_2X25G_2X10G0x4
> > +#define PKVL_MODE_ID_1X25G0x5
> > +
> > +#define NS_REGBUS_WAIT_TIMEOUT10000/* loop count */
> > +#define NIOS_INIT_TIMEOUT10000000/* usec */
> > +#define NIOS_INIT_TIME_INTV100000/* usec */
> > +
> > +struct n3000_nios {
> > +void __iomem *base;
> > +struct regmap *regmap;
> > +struct device *dev;
> > +struct platform_device *altera_spi;
> > +};
> > +
> > +static ssize_t nios_fw_version_show(struct device *dev,
> > +    struct device_attribute *attr, char *buf)
> > +{
> > +struct n3000_nios *ns = dev_get_drvdata(dev);
> > +unsigned int val;
> > +int ret;
> > +
> > +ret = regmap_read(ns->regmap, NIOS_FW_VERSION, &val);
> > +if (ret)
> > +return ret;
> > +
> > +return sprintf(buf, "%x.%x.%x\n",
> > +       (u8)FIELD_GET(NIOS_FW_VERSION_MAJOR, val),
> > +       (u8)FIELD_GET(NIOS_FW_VERSION_MINOR, val),
> > +       (u8)FIELD_GET(NIOS_FW_VERSION_PATCH, val));
> > +}
> > +static DEVICE_ATTR_RO(nios_fw_version);
> > +
> > +#define IS_MODE_STATUS_OK(mode_stat)\
> > +(FIELD_GET(PKVL_MODE_STS_GROUP_MSK, (mode_stat)) ==\
> > + PKVL_MODE_STS_GROUP_OK)
> > +
> > +#define IS_RETIMER_FEC_CONFIGURABLE(retimer_mode)\
> > +((retimer_mode) != PKVL_MODE_ID_RESET &&\
> > + (retimer_mode) != PKVL_MODE_ID_4X10G)
> > +
> > +static int get_retimer_mode(struct n3000_nios *ns, unsigned int
> > mode_stat_reg,
> > +    unsigned int *retimer_mode)
> > +{
> > +unsigned int val;
> > +int ret;
> > +
> > +ret = regmap_read(ns->regmap, mode_stat_reg, &val);
> > +if (ret)
> > +return ret;
> > +
> > +if (!IS_MODE_STATUS_OK(val))
> > +return -EFAULT;
> > +
> > +*retimer_mode = FIELD_GET(PKVL_MODE_STS_ID_MSK, val);
> > +
> > +return 0;
> > +}
> > +
> > +static ssize_t fec_mode_show(struct device *dev,
> > +     struct device_attribute *attr, char *buf)
> > +{
> > +struct n3000_nios *ns = dev_get_drvdata(dev);
> > +unsigned int val, retimer_a_mode, retimer_b_mode, fec_mode;
> > +int ret;
> > +
> > +ret = get_retimer_mode(ns, PKVL_A_MODE_STS, &retimer_a_mode);
> > +if (ret)
> > +return ret;
> > +
> > +ret = get_retimer_mode(ns, PKVL_B_MODE_STS, &retimer_b_mode);
> > +if (ret)
> > +return ret;
> > +
> > +if (!IS_RETIMER_FEC_CONFIGURABLE(retimer_a_mode) &&
> > +    !IS_RETIMER_FEC_CONFIGURABLE(retimer_b_mode))
> > +return sprintf(buf, "no\n");
> 
> It needs to be defined clearly, configurable seems a little confusing.
> It seems that hardware supports FEC mode but software can't change it.

So let's name it IS_RETIMER_FEC_SUPPORTED(), is that OK?

> Is that true? If it's in some hardware version doesn't support FEC, then
> We can make this sysfs not visible, right?

Since now we always accepts the Module Parameter regardless the FW
version, I think it would be reasonable we always have the sysfs to
feedback the result of configuration.

How do you think about it?

> 
> > +
> > +ret = regmap_read(ns->regmap, NIOS_INIT, &val);
> > +if (ret)
> > +return ret;
> > +
> > +/*
> > + * FEC mode should always be the same for all links, as we set them
> > + * in this way.
> > + */
> > +fec_mode = FIELD_GET(REQ_FEC_MODE_A0_MSK, val);
> > +if (fec_mode != FIELD_GET(REQ_FEC_MODE_A1_MSK, val) ||
> > +    fec_mode != FIELD_GET(REQ_FEC_MODE_A2_MSK, val) ||
> > +    fec_mode != FIELD_GET(REQ_FEC_MODE_A3_MSK, val) ||
> > +    fec_mode != FIELD_GET(REQ_FEC_MODE_B0_MSK, val) ||
> > +    fec_mode != FIELD_GET(REQ_FEC_MODE_B1_MSK, val) ||
> > +    fec_mode != FIELD_GET(REQ_FEC_MODE_B2_MSK, val) ||
> > +    fec_mode != FIELD_GET(REQ_FEC_MODE_B3_MSK, val))
> > +return -EFAULT;
> > +
> > +switch (fec_mode) {
> > +case REQ_FEC_MODE_NO:
> > +return sprintf(buf, "no\n");
> > +case REQ_FEC_MODE_KR:
> > +return sprintf(buf, "kr\n");
> > +case REQ_FEC_MODE_RS:
> > +return sprintf(buf, "rs\n");
> > +}
> > +
> > +return -EFAULT;
> > +}
> > +static DEVICE_ATTR_RO(fec_mode);
> > +
> > +static struct attribute *n3000_nios_attrs[] = {
> > +&dev_attr_nios_fw_version.attr,
> > +&dev_attr_fec_mode.attr,
> > +NULL,
> > +};
> > +ATTRIBUTE_GROUPS(n3000_nios);
> > +
> > +static int init_error_detected(struct n3000_nios *ns)
> > +{
> > +unsigned int val;
> > +
> > +if (regmap_read(ns->regmap, PKVL_A_MODE_STS, &val))
> > +return true;
> > +
> > +if (!IS_MODE_STATUS_OK(val))
> > +return true;
> > +
> > +if (regmap_read(ns->regmap, PKVL_B_MODE_STS, &val))
> > +return true;
> > +
> > +if (!IS_MODE_STATUS_OK(val))
> > +return true;
> > +
> > +return false;
> > +}
> > +
> > +static void dump_error_stat(struct n3000_nios *ns)
> > +{
> > +unsigned int val;
> > +
> > +if (regmap_read(ns->regmap, PKVL_A_MODE_STS, &val))
> > +return;
> > +
> > +dev_info(ns->dev, "PKVL_A_MODE_STS 0x%x\n", val);
> 
> dev_err is better?

The logs will be printed out when the retimer configuration fails, in
this case the module load will still success. Would it be confusing that
driver prints error level msg but it doesn't fail out.

> 
> > +
> > +if (regmap_read(ns->regmap, PKVL_B_MODE_STS, &val))
> > +return;
> > +
> > +dev_info(ns->dev, "PKVL_B_MODE_STS 0x%x\n", val);
> > +}
> > +
> > +static int n3000_nios_init_done_check(struct n3000_nios *ns)
> > +{
> > +struct device *dev = ns->dev;
> > +unsigned int val, mode;
> > +int ret;
> > +
> > +/*
> > + * this SPI is shared by Nios core inside FPGA, Nios will use this SPI
> > + * master to do some one time initialization after power up, and then
> > + * release the control to OS. driver needs to poll on INIT_DONE to
> > + * see when driver could take the control.
> > + *
> > + * Please note that after 3.x.x version, INIT_START is introduced, so
> > + * driver needs to trigger START firstly and then check INIT_DONE.
> > + */
> > +
> > +ret = regmap_read(ns->regmap, NIOS_FW_VERSION, &val);
> > +if (ret)
> > +return ret;
> > +
> > +/*
> > + * If Nios version register is totally uninitialized(== 0x0), then the
> > + * Nios firmware is missing. So host could take control of SPI master
> > + * safely, but initialization work for Nios is not done. This is an
> > + * issue of FPGA image. We didn't error out because we need SPI
> > master
> > + * to reprogram a new image.
> 
> New Nios firmware

Yes

> 
> > + */
> > +if (val == 0) {
> > +dev_warn(dev, "Nios version reg = 0x%x, skip INIT_DONE
> > check, but the retimer may be uninitialized\n",
> > + val);
> > +return 0;
> > +}
> > +
> > +if (FIELD_GET(NIOS_FW_VERSION_MAJOR, val) >= 3) {
> > +/* read NIOS_INIT to check if PKVL INIT done or not */
> 
> Use retimers here instead of PKVLs? Or explain what's the PKVL.

Yes I'll change them.

> 
> > +ret = regmap_read(ns->regmap, NIOS_INIT, &val);
> > +if (ret)
> > +return ret;
> > +
> > +/* check if PKVLs are initialized already */
> 
> Same
> 
> > +if (val & NIOS_INIT_DONE || val & NIOS_INIT_START)
> > +goto nios_init_done;
> > +
> > +/* configure FEC mode per module param */
> > +val = NIOS_INIT_START;
> > +
> > +/*
> > + * When the retimer is to be set to 10G mode, there is no FEC
> > + * mode setting, so the REQ_FEC_MODE field will be ignored
> > by
> > + * Nios firmware in this case. But we should still fill the FEC
> > + * mode field cause host could not get the retimer working
> > mode
> > + * until the Nios init is done.
> 
> So you mean hardware will ignore this request in configuration which doesn't
> support FEC mode.

Yes.

Thanks,
Yilun

> 
> Hao
> 

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FBA3AFC95
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Jun 2021 07:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFVF3i (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Jun 2021 01:29:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:24990 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhFVF3f (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Jun 2021 01:29:35 -0400
IronPort-SDR: hAH6aLrurFUg+Mj4DoO9/ITZbMGk2EHCg/CzIeIFuI3OiJUg/RT/N5Xjkk6qzLjCWHnFEGHtLc
 faTbdCcZfHVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="203976666"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="203976666"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 22:27:20 -0700
IronPort-SDR: Eein6gq+WwphYO3lRDJN6Tz5dpVCVPFMJ5DQ//wVQiKMNfW63K4ZC0OgQ5KHi57UlVzyXwEYeS
 D2yAeIXa5Cag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="490149543"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2021 22:27:17 -0700
Date:   Tue, 22 Jun 2021 13:22:05 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@geanix.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Debarati Biswas <debaratix.biswas@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
  linux/dfl.h
Message-ID: <20210622052205.GB27046@yilunxu-OptiPlex-7050>
References: <20210621070621.431482-1-mhu@silicom.dk>
 <20210621070621.431482-3-mhu@silicom.dk>
 <DM6PR11MB3819FE54D2C399DDBBC38FBA850A9@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR11MB3819FE54D2C399DDBBC38FBA850A9@DM6PR11MB3819.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 21, 2021 at 06:19:15PM +0800, Wu, Hao wrote:
> > Subject: [PATCH 2/4] fpga: dfl: Move DFH header register macros to linux/dfl.h
> >
> > From: Debarati Biswas <debaratix.biswas@intel.com>
> >
> > Device Feature List (DFL) drivers may be defined in subdirectories other
> > than drivers/fpga, and each DFL driver should have access to the Device
> > Feature Header (DFH) register, which contains revision and type
> > information. This change moves the macros specific to the DFH register
> > from drivers/fpga/dfl.h to include/linux/dfl.h.
> 
> Looks like it requires to access the revision info in the next patch, because
> current dfl_device doesn't expose related information.
> 
> @Yilun, do you have any concern to expose those info via dfl_device?

Exposing these header register definitions are good to me. These registers
are in DFL device's MMIO region, so it is good to share these info with
all DFL drivers.

Thanks,
Yilun

> 
> Thanks
> Hao
> 
> >
> > Signed-off-by: Debarati Biswas <debaratix.biswas@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> > ---
> >  drivers/fpga/dfl.h  | 48 +----------------------------------------
> >  include/linux/dfl.h | 52 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 53 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 2b82c96ba56c..6ed0353e9a99 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -17,6 +17,7 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/cdev.h>
> >  #include <linux/delay.h>
> > +#include <linux/dfl.h>
> >  #include <linux/eventfd.h>
> >  #include <linux/fs.h>
> >  #include <linux/interrupt.h>
> > @@ -53,32 +54,6 @@
> >  #define PORT_FEATURE_ID_UINT         0x12
> >  #define PORT_FEATURE_ID_STP          0x13
> >
> > -/*
> > - * Device Feature Header Register Set
> > - *
> > - * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
> > - * For AFUs, they have DFH + GUID as common header registers.
> > - * For private features, they only have DFH register as common header.
> > - */
> > -#define DFH                  0x0
> > -#define GUID_L                       0x8
> > -#define GUID_H                       0x10
> > -#define NEXT_AFU             0x18
> > -
> > -#define DFH_SIZE             0x8
> > -
> > -/* Device Feature Header Register Bitfield */
> > -#define DFH_ID                       GENMASK_ULL(11, 0)      /* Feature ID
> > */
> > -#define DFH_ID_FIU_FME               0
> > -#define DFH_ID_FIU_PORT              1
> > -#define DFH_REVISION         GENMASK_ULL(15, 12)     /* Feature revision */
> > -#define DFH_NEXT_HDR_OFST    GENMASK_ULL(39, 16)     /* Offset to next DFH
> > */
> > -#define DFH_EOL                      BIT_ULL(40)             /* End of list
> > */
> > -#define DFH_TYPE             GENMASK_ULL(63, 60)     /* Feature type */
> > -#define DFH_TYPE_AFU         1
> > -#define DFH_TYPE_PRIVATE     3
> > -#define DFH_TYPE_FIU         4
> > -
> >  /* Next AFU Register Bitfield */
> >  #define NEXT_AFU_NEXT_DFH_OFST       GENMASK_ULL(23, 0)      /* Offset to
> > next AFU */
> >
> > @@ -403,27 +378,6 @@ struct device *dfl_fpga_pdata_to_parent(struct
> > dfl_feature_platform_data *pdata)
> >       return pdata->dev->dev.parent->parent;
> >  }
> >
> > -static inline bool dfl_feature_is_fme(void __iomem *base)
> > -{
> > -     u64 v = readq(base + DFH);
> > -
> > -     return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
> > -             (FIELD_GET(DFH_ID, v) == DFH_ID_FIU_FME);
> > -}
> > -
> > -static inline bool dfl_feature_is_port(void __iomem *base)
> > -{
> > -     u64 v = readq(base + DFH);
> > -
> > -     return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
> > -             (FIELD_GET(DFH_ID, v) == DFH_ID_FIU_PORT);
> > -}
> > -
> > -static inline u8 dfl_feature_revision(void __iomem *base)
> > -{
> > -     return (u8)FIELD_GET(DFH_REVISION, readq(base + DFH));
> > -}
> > -
> >  /**
> >   * struct dfl_fpga_enum_info - DFL FPGA enumeration information
> >   *
> > diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> > index 6cc10982351a..1cd86b2e7cb1 100644
> > --- a/include/linux/dfl.h
> > +++ b/include/linux/dfl.h
> > @@ -8,7 +8,9 @@
> >  #ifndef __LINUX_DFL_H
> >  #define __LINUX_DFL_H
> >
> > +#include <linux/bitfield.h>
> >  #include <linux/device.h>
> > +#include <linux/io.h>
> >  #include <linux/mod_devicetable.h>

The <linux/io-64-nonatomic-lo-hi.h> is needed here, or readq/writeq
definitions may be missing on some platform, as the kernel test robot
says.

Thanks,
Yilun

> >
> >  /**
> > @@ -83,4 +85,54 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> >       module_driver(__dfl_driver, dfl_driver_register, \
> >                     dfl_driver_unregister)
> >
> > +/*
> > + * Device Feature Header Register Set
> > + *
> > + * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
> > + * For AFUs, they have DFH + GUID as common header registers.
> > + * For private features, they only have DFH register as common header.
> > + */
> > +#define DFH                     0x0
> > +#define GUID_L                  0x8
> > +#define GUID_H                  0x10
> > +#define NEXT_AFU                0x18
> > +
> > +#define DFH_SIZE                0x8
> > +
> > +/* Device Feature Header Register Bitfield */
> > +#define DFH_ID                  GENMASK_ULL(11, 0)      /* Feature ID */
> > +#define DFH_ID_FIU_FME          0
> > +#define DFH_ID_FIU_PORT         1
> > +#define DFH_REVISION            GENMASK_ULL(15, 12)
> > +#define DFH_NEXT_HDR_OFST       GENMASK_ULL(39, 16)     /* Offset to next
> > DFH */
> > +#define DFH_EOL                 BIT_ULL(40)             /* End of list */
> > +#define DFH_TYPE                GENMASK_ULL(63, 60)     /* Feature type */
> > +#define DFH_TYPE_AFU            1
> > +#define DFH_TYPE_PRIVATE        3
> > +#define DFH_TYPE_FIU            4
> > +
> > +/* Function to read from DFH and check if the Feature type is FME */
> > +static inline bool dfl_feature_is_fme(void __iomem *base)
> > +{
> > +     u64 v = readq(base + DFH);
> > +
> > +     return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
> > +             (FIELD_GET(DFH_ID, v) == DFH_ID_FIU_FME);
> > +}
> > +
> > +/* Function to read from DFH and check if the Feature type is port*/
> > +static inline bool dfl_feature_is_port(void __iomem *base)
> > +{
> > +     u64 v = readq(base + DFH);
> > +
> > +     return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
> > +              (FIELD_GET(DFH_ID, v) == DFH_ID_FIU_PORT);
> > +}
> > +
> > +/* Function to read feature revision from DFH */
> > +static inline u8 dfl_feature_revision(void __iomem *base)
> > +{
> > +     return (u8)FIELD_GET(DFH_REVISION, readq(base + DFH));
> > +}
> > +
> >  #endif /* __LINUX_DFL_H */
> > --
> > 2.31.0
> 

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87383AFC51
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Jun 2021 07:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhFVFDn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Jun 2021 01:03:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:64130 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhFVFDn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Jun 2021 01:03:43 -0400
IronPort-SDR: qgUW0q/nbFwDy6bzBGbdyjMuT4vvVf3W+ewHMsJCSzN9h35WtspVhpe8g7O+F8PVCQGDnPK46K
 0VgGmfWoXJiw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="292613738"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="292613738"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 22:01:28 -0700
IronPort-SDR: mCKdZRLs24tuDHga2SekjGIxPKx/yBaACQ/9sqj0089hKaRxhPpzbOTVSMmH882+B239h/XgQs
 MG+PhLI7BpcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="556493720"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jun 2021 22:01:24 -0700
Date:   Tue, 22 Jun 2021 12:56:13 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@geanix.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org,
        Debarati Biswas <debaratix.biswas@intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
  linux/dfl.h
Message-ID: <20210622045613.GA27046@yilunxu-OptiPlex-7050>
References: <20210621070621.431482-1-mhu@silicom.dk>
 <20210621070621.431482-3-mhu@silicom.dk>
 <81975a85-e9d6-bd4b-7666-56d1d1d581bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81975a85-e9d6-bd4b-7666-56d1d1d581bc@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 21, 2021 at 06:56:28AM -0700, Tom Rix wrote:
> 
> On 6/21/21 12:06 AM, Martin Hundebøll wrote:
> > From: Debarati Biswas <debaratix.biswas@intel.com>
> > 
> > Device Feature List (DFL) drivers may be defined in subdirectories other
> > than drivers/fpga, and each DFL driver should have access to the Device
> > Feature Header (DFH) register, which contains revision and type
> > information. This change moves the macros specific to the DFH register
> > from drivers/fpga/dfl.h to include/linux/dfl.h.
> > 
> > Signed-off-by: Debarati Biswas <debaratix.biswas@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> > ---
> >   drivers/fpga/dfl.h  | 48 +----------------------------------------
> >   include/linux/dfl.h | 52 +++++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 53 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 2b82c96ba56c..6ed0353e9a99 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -17,6 +17,7 @@
> >   #include <linux/bitfield.h>
> 
> bitfield.h was added to linux/dfl.h
> 
> Likely both aren't needed, try removing this one.

The DFL register definitions are in dfl.h, and Source files which include
dfl.h are likely to use bitfield ops for DFL register access, so could we
keep it here?

Thanks,
Yilun

> 
> Tom
> 
> >   #include <linux/cdev.h>
> >   #include <linux/delay.h>
> > +#include <linux/dfl.h>
> >   #include <linux/eventfd.h>
> >   #include <linux/fs.h>
> >   #include <linux/interrupt.h>
> > @@ -53,32 +54,6 @@
> >   #define PORT_FEATURE_ID_UINT		0x12
> >   #define PORT_FEATURE_ID_STP		0x13
> > -/*
> > - * Device Feature Header Register Set
> > - *
> > - * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
> > - * For AFUs, they have DFH + GUID as common header registers.
> > - * For private features, they only have DFH register as common header.
> > - */
> > -#define DFH			0x0
> > -#define GUID_L			0x8
> > -#define GUID_H			0x10
> > -#define NEXT_AFU		0x18
> > -
> > -#define DFH_SIZE		0x8
> > -
> > -/* Device Feature Header Register Bitfield */
> > -#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
> > -#define DFH_ID_FIU_FME		0
> > -#define DFH_ID_FIU_PORT		1
> > -#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
> > -#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
> > -#define DFH_EOL			BIT_ULL(40)		/* End of list */
> > -#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
> > -#define DFH_TYPE_AFU		1
> > -#define DFH_TYPE_PRIVATE	3
> > -#define DFH_TYPE_FIU		4
> > -
> >   /* Next AFU Register Bitfield */
> >   #define NEXT_AFU_NEXT_DFH_OFST	GENMASK_ULL(23, 0)	/* Offset to next AFU */
> > @@ -403,27 +378,6 @@ struct device *dfl_fpga_pdata_to_parent(struct dfl_feature_platform_data *pdata)
> >   	return pdata->dev->dev.parent->parent;
> >   }
> > -static inline bool dfl_feature_is_fme(void __iomem *base)
> > -{
> > -	u64 v = readq(base + DFH);
> > -
> > -	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
> > -		(FIELD_GET(DFH_ID, v) == DFH_ID_FIU_FME);
> > -}
> > -
> > -static inline bool dfl_feature_is_port(void __iomem *base)
> > -{
> > -	u64 v = readq(base + DFH);
> > -
> > -	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
> > -		(FIELD_GET(DFH_ID, v) == DFH_ID_FIU_PORT);
> > -}
> > -
> > -static inline u8 dfl_feature_revision(void __iomem *base)
> > -{
> > -	return (u8)FIELD_GET(DFH_REVISION, readq(base + DFH));
> > -}
> > -
> >   /**
> >    * struct dfl_fpga_enum_info - DFL FPGA enumeration information
> >    *
> > diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> > index 6cc10982351a..1cd86b2e7cb1 100644
> > --- a/include/linux/dfl.h
> > +++ b/include/linux/dfl.h
> > @@ -8,7 +8,9 @@
> >   #ifndef __LINUX_DFL_H
> >   #define __LINUX_DFL_H
> > +#include <linux/bitfield.h>
> >   #include <linux/device.h>
> > +#include <linux/io.h>
> >   #include <linux/mod_devicetable.h>
> >   /**
> > @@ -83,4 +85,54 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv);
> >   	module_driver(__dfl_driver, dfl_driver_register, \
> >   		      dfl_driver_unregister)
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
> > +#define DFH_NEXT_HDR_OFST       GENMASK_ULL(39, 16)     /* Offset to next DFH */
> > +#define DFH_EOL                 BIT_ULL(40)             /* End of list */
> > +#define DFH_TYPE                GENMASK_ULL(63, 60)     /* Feature type */
> > +#define DFH_TYPE_AFU            1
> > +#define DFH_TYPE_PRIVATE        3
> > +#define DFH_TYPE_FIU            4
> > +
> > +/* Function to read from DFH and check if the Feature type is FME */
> > +static inline bool dfl_feature_is_fme(void __iomem *base)
> > +{
> > +	u64 v = readq(base + DFH);
> > +
> > +	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
> > +		(FIELD_GET(DFH_ID, v) == DFH_ID_FIU_FME);
> > +}
> > +
> > +/* Function to read from DFH and check if the Feature type is port*/
> > +static inline bool dfl_feature_is_port(void __iomem *base)
> > +{
> > +	u64 v = readq(base + DFH);
> > +
> > +	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_FIU) &&
> > +		 (FIELD_GET(DFH_ID, v) == DFH_ID_FIU_PORT);
> > +}
> > +
> > +/* Function to read feature revision from DFH */
> > +static inline u8 dfl_feature_revision(void __iomem *base)
> > +{
> > +	return (u8)FIELD_GET(DFH_REVISION, readq(base + DFH));
> > +}
> > +
> >   #endif /* __LINUX_DFL_H */

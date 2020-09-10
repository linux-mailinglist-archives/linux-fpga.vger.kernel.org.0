Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D31264051
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Sep 2020 10:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgIJIqQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Sep 2020 04:46:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:12816 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730077AbgIJIpZ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Sep 2020 04:45:25 -0400
IronPort-SDR: +SAY9a30C7N5311mbKCJ+fr/1gPJY4FoEJFZGAq6BLhuHDwmbsPuwXcLpsJtZm05AgVyE12+I7
 VQhic4MT9/VQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="243310048"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="243310048"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 01:45:24 -0700
IronPort-SDR: ErUPBrPQIPAp8qnsEykBXGR/atSeeL4VciSJhRKcapa0y7p/v4iNRlCMvQmRhLGzCOgHptsQTC
 +4Isk07Gc28w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="300474111"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 10 Sep 2020 01:45:22 -0700
Date:   Thu, 10 Sep 2020 16:41:06 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 1/3] fpga: dfl: move dfl_device_id to mod_devicetable.h
Message-ID: <20200910084106.GB16318@yilunxu-OptiPlex-7050>
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
 <1599544129-17594-2-git-send-email-yilun.xu@intel.com>
 <aaa2d9a5-f5ae-d026-91c9-730403f04050@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaa2d9a5-f5ae-d026-91c9-730403f04050@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Sep 09, 2020 at 05:55:33AM -0700, Tom Rix wrote:
> 
> On 9/7/20 10:48 PM, Xu Yilun wrote:
> > In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
> > patch moves struct dfl_device_id to mod_devicetable.h
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > ---
> >  drivers/fpga/dfl.h              | 13 +------------
> >  include/linux/mod_devicetable.h | 12 ++++++++++++
> >  2 files changed, 13 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 5dc758f..d5b0760 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -26,6 +26,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/uuid.h>
> >  #include <linux/fpga/fpga-region.h>
> > +#include <linux/mod_devicetable.h>
> >  
> >  /* maximum supported number of ports */
> >  #define MAX_DFL_FPGA_PORT_NUM 4
> > @@ -526,18 +527,6 @@ enum dfl_id_type {
> >  };
> >  
> >  /**
> > - * struct dfl_device_id -  dfl device identifier
> > - * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> > - * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> > - * @driver_data: driver specific data.
> > - */
> > -struct dfl_device_id {
> > -	u8 type;
> > -	u16 feature_id;
> > -	unsigned long driver_data;
> > -};
> > -
> > -/**
> >   * struct dfl_device - represent an dfl device on dfl bus
> >   *
> >   * @dev: generic device interface.
> > diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> > index 5b08a47..407d8dc 100644
> > --- a/include/linux/mod_devicetable.h
> > +++ b/include/linux/mod_devicetable.h
> > @@ -838,4 +838,16 @@ struct mhi_device_id {
> >  	kernel_ulong_t driver_data;
> >  };
> >  
> > +/**
> > + * struct dfl_device_id -  dfl device identifier
> > + * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> > + * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> > + * @driver_data: driver specific data.
> > + */
> > +struct dfl_device_id {
> > +	__u8 type;
> > +	__u16 feature_id;
> 
> I thought i saw feature id's going to 64 bit, does this type need to expand ?

Feature id is a 12bit field in DFL spec. Previously we define it u64
cause we are considering it may expand sometime. But now seems GUID will
be used in future design.

And the header file will be used by modpost, which is not supporting u64
now. So it is not necessary we use u64 for extra work. A patch is
already applied for this change - "change data type of feature id to u16"

Thanks,
Yilun

> 
> Tom 
> 
> > +	kernel_ulong_t driver_data;
> > +};
> > +
> >  #endif /* LINUX_MOD_DEVICETABLE_H */

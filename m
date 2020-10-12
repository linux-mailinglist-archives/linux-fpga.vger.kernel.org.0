Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6780628AC28
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Oct 2020 04:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgJLCcV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Oct 2020 22:32:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:24922 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgJLCcV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Oct 2020 22:32:21 -0400
IronPort-SDR: Polbi1UUtNV5LOW1tHg+Bl5Yccsq3NaZArSQHvSCt6VFTw/nntv8FHgPJZWfGQQY+wPqFSzyeA
 ACf3/tR2gGyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="229863974"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="229863974"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 19:32:16 -0700
IronPort-SDR: ORoCtKE2bFn//79vZKuNhfc/Zdt5Een3SjpE0zLqU33gXUFBI/4asv1mdCBEocCIZgRbS70Tdg
 bXtsblAAfA8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="389817073"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga001.jf.intel.com with ESMTP; 11 Oct 2020 19:32:13 -0700
Date:   Mon, 12 Oct 2020 10:27:15 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, krzk@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>, yilun.xu@intel.com
Subject: Re: [PATCH v9 2/6] fpga: dfl: move dfl_device_id to mod_devicetable.h
Message-ID: <20201012022715.GA29436@yilunxu-OptiPlex-7050>
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
 <1602313793-21421-3-git-send-email-yilun.xu@intel.com>
 <20201011144351.GA271501@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011144351.GA271501@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Oct 11, 2020 at 04:43:51PM +0200, Greg KH wrote:
> On Sat, Oct 10, 2020 at 03:09:49PM +0800, Xu Yilun wrote:
> > In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
> > patch moves struct dfl_device_id to mod_devicetable.h
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > Acked-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > v2: fix the order for the header file
> > v3: rebase the patch for dfl bus name change
> > v9: rebase the patch for dfl bus name changes back to "dfl"
> > ---
> >  drivers/fpga/dfl.h              | 13 +------------
> >  include/linux/mod_devicetable.h | 12 ++++++++++++
> >  2 files changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index ac373b1..549c790 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -22,6 +22,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/uuid.h>
> > @@ -526,18 +527,6 @@ enum dfl_id_type {
> >  };
> >  
> >  /**
> > - * struct dfl_device_id -  dfl device identifier
> > - * @type: DFL FIU type of the device. See enum dfl_id_type.
> > - * @feature_id: feature identifier local to its DFL FIU type.
> > - * @driver_data: driver specific data.
> > - */
> > -struct dfl_device_id {
> > -	u16 type;
> > -	u16 feature_id;
> > -	unsigned long driver_data;
> > -};
> > -
> > -/**
> >   * struct dfl_device - represent an dfl device on dfl bus
> >   *
> >   * @dev: generic device interface.
> > diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> > index 5b08a47..66e1405 100644
> > --- a/include/linux/mod_devicetable.h
> > +++ b/include/linux/mod_devicetable.h
> > @@ -838,4 +838,16 @@ struct mhi_device_id {
> >  	kernel_ulong_t driver_data;
> >  };
> >  
> > +/**
> > + * struct dfl_device_id -  dfl device identifier
> 
> I still have no idea what "dfl" means.  Please at the very least,
> explain it here.

Yes, I will add the comments here.

Thanks,
Yilun

> 
> thanks,
> 
> greg k-h

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A502A3F82
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 09:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgKCI77 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 03:59:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:6065 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgKCI77 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Nov 2020 03:59:59 -0500
IronPort-SDR: wv4dwMhW2zFpYbUKvMh8ikkBtnicnelhDFezV8yBuEVrsl53D6ZBhxY+N2Uas/x8r8KW1Oo/qU
 I0/0EoEezEWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="148876678"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="148876678"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 00:59:57 -0800
IronPort-SDR: M5CJS8T9+kEF+NP3kq8plz/Am0mQGqrMXHIA1SLbH0zG2c0HanRWTFjgWKr06ss1u7I6xL2InX
 tSCQFlgM7DXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="527062337"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 03 Nov 2020 00:59:55 -0800
Date:   Tue, 3 Nov 2020 16:54:27 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>, yilun.xu@intel.com
Subject: Re: [PATCH 2/4] fpga: dfl: move dfl_device_id to mod_devicetable.h
Message-ID: <20201103085427.GC10673@yilunxu-OptiPlex-7050>
References: <20201103072104.12361-1-mdf@kernel.org>
 <20201103072104.12361-3-mdf@kernel.org>
 <20201103074053.GC2500572@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103074053.GC2500572@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 03, 2020 at 08:40:53AM +0100, Greg KH wrote:
> On Mon, Nov 02, 2020 at 11:21:02PM -0800, Moritz Fischer wrote:
> > From: Xu Yilun <yilun.xu@intel.com>
> > 
> > In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
> > patch moves struct dfl_device_id to mod_devicetable.h
> > 
> > Some brief description for DFL (Device Feature List) is added to make
> > the DFL known to the whole kernel.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > Acked-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/fpga/dfl.h              | 13 +------------
> >  include/linux/mod_devicetable.h | 24 ++++++++++++++++++++++++
> >  2 files changed, 25 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index ac373b1fcff9..549c7900dcfd 100644
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
> > @@ -525,18 +526,6 @@ enum dfl_id_type {
> >  	DFL_ID_MAX,
> >  };
> >  
> > -/**
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
> >  /**
> >   * struct dfl_device - represent an dfl device on dfl bus
> >   *
> > diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> > index 5b08a473cdba..e4870e5d3ea8 100644
> > --- a/include/linux/mod_devicetable.h
> > +++ b/include/linux/mod_devicetable.h
> > @@ -838,4 +838,28 @@ struct mhi_device_id {
> >  	kernel_ulong_t driver_data;
> >  };
> >  
> > +/*
> > + * DFL (Device Feature List)
> > + *
> > + * DFL defines a linked list of feature headers within the device MMIO space to
> > + * provide an extensible way of adding features. Software can walk through these
> > + * predefined data structures to enumerate features. It is now used in the FPGA.
> > + * See Documentation/fpga/dfl.rst for more information.
> > + *
> > + * The dfl bus type is introduced to match the individual feature devices (dfl
> > + * devices) for specific dfl drivers.
> > + */
> > +
> > +/**
> > + * struct dfl_device_id -  dfl device identifier
> > + * @type: DFL FIU type of the device. See enum dfl_id_type.
> > + * @feature_id: feature identifier local to its DFL FIU type.
> > + * @driver_data: driver specific data.
> > + */
> > +struct dfl_device_id {
> > +	__u16 type;
> > +	__u16 feature_id;
> > +	unsigned long driver_data;
> 
> This is the wrong type for driver_data now that it goes to userspace :(
> 
> {sigh}

Thanks for the catching, I should change it to kernel_ulong_t.

Thanks,
Yilun

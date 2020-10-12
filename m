Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030F628AC46
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Oct 2020 04:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgJLCqC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Oct 2020 22:46:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:59575 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgJLCqC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Oct 2020 22:46:02 -0400
IronPort-SDR: +RHDE0ClzKoPSPv62NE0pBUIDj3qmDdUEELEOrz0KYDYgtVU5xfU6HXDy2wrSGaLFFuKnn8Q/V
 SVFs/M0/LBTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="145002787"
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="145002787"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 19:46:01 -0700
IronPort-SDR: pqtrKKIQB/Y0bo3tr4jguTlRbWSSgC/KtZDbP+DtUKPs7Rw+OSvc7BVZy0hLmJtfKA8xGHJ+l9
 vqkce2C9prdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,365,1596524400"; 
   d="scan'208";a="529767360"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 11 Oct 2020 19:45:58 -0700
Date:   Mon, 12 Oct 2020 10:41:00 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, krzk@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v9 1/6] fpga: dfl: fix the definitions of type &
  feature_id for dfl devices
Message-ID: <20201012024100.GC29436@yilunxu-OptiPlex-7050>
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
 <1602313793-21421-2-git-send-email-yilun.xu@intel.com>
 <8786ca8f-7edd-d7b1-7eca-6447814c6e5e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8786ca8f-7edd-d7b1-7eca-6447814c6e5e@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Oct 10, 2020 at 08:07:07AM -0700, Tom Rix wrote:
> 
> On 10/10/20 12:09 AM, Xu Yilun wrote:
> > The value of the field dfl_device.type comes from the 12 bits register
> > field DFH_ID according to DFL spec. So this patch changes the definition
> > of the type field to u16.
> >
> > Also it is not necessary to illustrate the valid bits of the type field
> > in comments. Instead we should explicitly define the possible values in
> > the enumeration type for it, because they are shared by hardware spec.
> > We should not let the compiler decide these values.
> >
> > Similar changes are also applied to dfl_device.feature_id.
> >
> > This patch also fixed the MODALIAS format according to the changes
> > above.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> > v9: no change
> > ---
> >  drivers/fpga/dfl.c |  3 +--
> >  drivers/fpga/dfl.h | 14 +++++++-------
> >  2 files changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index b450870..5a6ba3b 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -298,8 +298,7 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> >  {
> >  	struct dfl_device *ddev = to_dfl_dev(dev);
> >  
> > -	/* The type has 4 valid bits and feature_id has 12 valid bits */
> > -	return add_uevent_var(env, "MODALIAS=dfl:t%01Xf%03X",
> > +	return add_uevent_var(env, "MODALIAS=dfl:t%04Xf%04X",
> >  			      ddev->type, ddev->feature_id);
> >  }
> >  
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 5dc758f..ac373b1 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -520,19 +520,19 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
> >   * enum dfl_id_type - define the DFL FIU types
> >   */
> >  enum dfl_id_type {
> > -	FME_ID,
> > -	PORT_ID,
> > +	FME_ID = 0,
> > +	PORT_ID = 1,
> 
> This is redundant, why make this change ?

These values are shared by hardware spec, so it is suggested that the
values of the enum type should be explicitly set, otherwise the compiler
is in its right to do whatever it wants with them (within reason...)

Please see the original discussion:
https://lore.kernel.org/linux-fpga/20200923055436.GA2629915@kroah.com/

Thanks,
Yilun

> 
> Tom
> 
> >  	DFL_ID_MAX,
> >  };
> >  
> >  /**
> >   * struct dfl_device_id -  dfl device identifier
> > - * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> > - * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> > + * @type: DFL FIU type of the device. See enum dfl_id_type.
> > + * @feature_id: feature identifier local to its DFL FIU type.
> >   * @driver_data: driver specific data.
> >   */
> >  struct dfl_device_id {
> > -	u8 type;
> > +	u16 type;
> >  	u16 feature_id;
> >  	unsigned long driver_data;
> >  };
> > @@ -543,7 +543,7 @@ struct dfl_device_id {
> >   * @dev: generic device interface.
> >   * @id: id of the dfl device.
> >   * @type: type of DFL FIU of the device. See enum dfl_id_type.
> > - * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> > + * @feature_id: feature identifier local to its DFL FIU type.
> >   * @mmio_res: mmio resource of this dfl device.
> >   * @irqs: list of Linux IRQ numbers of this dfl device.
> >   * @num_irqs: number of IRQs supported by this dfl device.
> > @@ -553,7 +553,7 @@ struct dfl_device_id {
> >  struct dfl_device {
> >  	struct device dev;
> >  	int id;
> > -	u8 type;
> > +	u16 type;
> >  	u16 feature_id;
> >  	struct resource mmio_res;
> >  	int *irqs;

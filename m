Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7592F2A3F7F
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 09:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgKCI6u (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 03:58:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:5977 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgKCI6u (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Nov 2020 03:58:50 -0500
IronPort-SDR: 8fCFyrsVVGsGx+1e3QKT2ySUYtX7mHGoVT77g73lO98IL8HqZq/d0anKn5FxJxRbHHzELlpD/M
 iGhJwzY8t7nA==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="148876564"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="148876564"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 00:58:49 -0800
IronPort-SDR: 1Eu9zORKYbKZmErAdczd6MB4aQlj6z89aHC7+z2e6Vf3FRJ6hro+E/M3mjzpg6pJ81FfDjsHzx
 gKXFTP49LTdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="305983655"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga007.fm.intel.com with ESMTP; 03 Nov 2020 00:58:48 -0800
Date:   Tue, 3 Nov 2020 16:53:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Tom Rix <trix@redhat.com>, yilun.xu@intel.com
Subject: Re: [PATCH 1/4] fpga: dfl: fix the definitions of type & feature_id
  for dfl devices
Message-ID: <20201103085320.GB10673@yilunxu-OptiPlex-7050>
References: <20201103072104.12361-1-mdf@kernel.org>
 <20201103072104.12361-2-mdf@kernel.org>
 <20201103074452.GE2500572@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103074452.GE2500572@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg:

On Tue, Nov 03, 2020 at 08:44:52AM +0100, Greg KH wrote:
> On Mon, Nov 02, 2020 at 11:21:01PM -0800, Moritz Fischer wrote:
> > From: Xu Yilun <yilun.xu@intel.com>
> > 
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
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/fpga/dfl.c |  3 +--
> >  drivers/fpga/dfl.h | 14 +++++++-------
> >  2 files changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index b450870b75ed..5a6ba3b2fa05 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -298,8 +298,7 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> >  {
> >  	struct dfl_device *ddev = to_dfl_dev(dev);
> >  
> > -	/* The type has 4 valid bits and feature_id has 12 valid bits */
> > -	return add_uevent_var(env, "MODALIAS=dfl:t%01Xf%03X",
> > +	return add_uevent_var(env, "MODALIAS=dfl:t%04Xf%04X",
> 
> Why drop the comment and not just fix it up instead?

Previously in Pull request for 5.10, you suggested that don't care too much about
the exact data width.

 "Who cares it's only 4 bits, we have room in the kernel to have it be a full 8
  bits or 32 or whatever"

So I changed the type of 'type' & 'feature_id' all to u16 and deleted all the
comments about the width of them.

> 
> >  			      ddev->type, ddev->feature_id);
> >  }
> >  
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index 5dc758f655b7..ac373b1fcff9 100644
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
> 
> Why isn't this enum dfl_id_type?

We are going to move the two fields to mod_devicetable.h, they
will be eventually changed to __u16, so I use u16 here.

> 
> >  	u16 feature_id;
> >  	unsigned long driver_data;
> >  };
> > @@ -543,7 +543,7 @@ struct dfl_device_id {
> >   * @dev: generic device interface.
> >   * @id: id of the dfl device.
> >   * @type: type of DFL FIU of the device. See enum dfl_id_type.
> > - * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> > + * @feature_id: feature identifier local to its DFL FIU type.
> 
> But feature_id is still 16 bits, why change this?

As I mentioned before, I mean not to emphasize on the bitfield width.

> 
> 
> >   * @mmio_res: mmio resource of this dfl device.
> >   * @irqs: list of Linux IRQ numbers of this dfl device.
> >   * @num_irqs: number of IRQs supported by this dfl device.
> > @@ -553,7 +553,7 @@ struct dfl_device_id {
> >  struct dfl_device {
> >  	struct device dev;
> >  	int id;
> > -	u8 type;
> > +	u16 type;
> 
> why isn't this an enum as well?

Same as before, the 'type' should be sync with dfl_device_id.type.

Thanks,
Yilun

> 
> greg k-h

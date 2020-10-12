Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7452928BAE0
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Oct 2020 16:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbgJLObW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Oct 2020 10:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389080AbgJLObW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 12 Oct 2020 10:31:22 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ABEF20776;
        Mon, 12 Oct 2020 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602513081;
        bh=HoQ6jCcZERGyCgIF7IrKDgnBvt+I6UIdmddbNkeKkrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZbQUhaIACrhi1G1r0geY3IANqcCehdRVrfr3fRlqtX3tWibSGlRg7Yp18vfKFhu3
         Y4UQ8Wr118O9yNUO55R7BnGe/fiI2+z6X1KAAcp8bkdyLEwGGlVpXkyLZiMVwgyszF
         sqOhUi/kma12wQozL1yuVmUYG7pQ7EBC3ydsiQzY=
Date:   Mon, 12 Oct 2020 16:32:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, krzk@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v9 1/6] fpga: dfl: fix the definitions of type &
 feature_id for dfl devices
Message-ID: <20201012143200.GA1544154@kroah.com>
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
 <1602313793-21421-2-git-send-email-yilun.xu@intel.com>
 <8786ca8f-7edd-d7b1-7eca-6447814c6e5e@redhat.com>
 <20201012024100.GC29436@yilunxu-OptiPlex-7050>
 <440b7d06-426f-86c6-cf3f-396a9cc6bff7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440b7d06-426f-86c6-cf3f-396a9cc6bff7@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Oct 12, 2020 at 07:07:55AM -0700, Tom Rix wrote:
> 
> On 10/11/20 7:41 PM, Xu Yilun wrote:
> > On Sat, Oct 10, 2020 at 08:07:07AM -0700, Tom Rix wrote:
> >> On 10/10/20 12:09 AM, Xu Yilun wrote:
> >>> The value of the field dfl_device.type comes from the 12 bits register
> >>> field DFH_ID according to DFL spec. So this patch changes the definition
> >>> of the type field to u16.
> >>>
> >>> Also it is not necessary to illustrate the valid bits of the type field
> >>> in comments. Instead we should explicitly define the possible values in
> >>> the enumeration type for it, because they are shared by hardware spec.
> >>> We should not let the compiler decide these values.
> >>>
> >>> Similar changes are also applied to dfl_device.feature_id.
> >>>
> >>> This patch also fixed the MODALIAS format according to the changes
> >>> above.
> >>>
> >>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> >>> ---
> >>> v9: no change
> >>> ---
> >>>  drivers/fpga/dfl.c |  3 +--
> >>>  drivers/fpga/dfl.h | 14 +++++++-------
> >>>  2 files changed, 8 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> >>> index b450870..5a6ba3b 100644
> >>> --- a/drivers/fpga/dfl.c
> >>> +++ b/drivers/fpga/dfl.c
> >>> @@ -298,8 +298,7 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> >>>  {
> >>>  	struct dfl_device *ddev = to_dfl_dev(dev);
> >>>  
> >>> -	/* The type has 4 valid bits and feature_id has 12 valid bits */
> >>> -	return add_uevent_var(env, "MODALIAS=dfl:t%01Xf%03X",
> >>> +	return add_uevent_var(env, "MODALIAS=dfl:t%04Xf%04X",
> >>>  			      ddev->type, ddev->feature_id);
> >>>  }
> >>>  
> >>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> >>> index 5dc758f..ac373b1 100644
> >>> --- a/drivers/fpga/dfl.h
> >>> +++ b/drivers/fpga/dfl.h
> >>> @@ -520,19 +520,19 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
> >>>   * enum dfl_id_type - define the DFL FIU types
> >>>   */
> >>>  enum dfl_id_type {
> >>> -	FME_ID,
> >>> -	PORT_ID,
> >>> +	FME_ID = 0,
> >>> +	PORT_ID = 1,
> >> This is redundant, why make this change ?
> > These values are shared by hardware spec, so it is suggested that the
> > values of the enum type should be explicitly set, otherwise the compiler
> > is in its right to do whatever it wants with them (within reason...)
> >
> > Please see the original discussion:
> > https://lore.kernel.org/linux-fpga/20200923055436.GA2629915@kroah.com/
> 
> I don't believe this is undefined behavior for the compiler
> 
> from c11 6.7.2.2,3
> 
> The identifiers in an enumerator list are declared as constants that have type int and may appear wherever such are permitted.127) An enumerator with = defines its enumeration constant as the value of the constant expression. If the first enumerator has no =, the value of its enumeration constant is 0. Each subsequent enumerator with no = defines its enumeration constant as the value of the constant expression obtained by adding 1 to the value of the previous enumeration constant. (The use of enumerators with = may produce enumeration constants with values that duplicate other values in the same enumeration.) The enumerators of an enumeration are also known as its members.
> 
> setting them again has some use for documentation so this change is ok if you have strong feeling for it.

The kernel developer community has "strong feelings" for this, please be
specific and list the values when they matter.

thanks,

greg k-h

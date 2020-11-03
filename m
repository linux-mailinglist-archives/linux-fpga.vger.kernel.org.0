Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13B2A3DED
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgKCHn7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:43:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbgKCHn7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Nov 2020 02:43:59 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4152B2222B;
        Tue,  3 Nov 2020 07:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604389438;
        bh=uLtX3jy1chssOJmTaTj3uqjC7c7rWOYrTRxDnxFul0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3zqp8oBzkwL2awzaautiPZc2u6O81SG7W5KiH4Ce8flRgKIZSwQhYSTmSKWcIoLT
         Tr6H5cLE1lhd8vVW/0mtWEJMzJ/wuYG1zWCxbuGWP3wuQoCBYTJ3x0dvtoEpVlRenc
         +u02Tsov5Cnp2e/h22wMPs/KIEiLpJdjVCL/eX4k=
Date:   Tue, 3 Nov 2020 08:44:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH 1/4] fpga: dfl: fix the definitions of type & feature_id
 for dfl devices
Message-ID: <20201103074452.GE2500572@kroah.com>
References: <20201103072104.12361-1-mdf@kernel.org>
 <20201103072104.12361-2-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103072104.12361-2-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Nov 02, 2020 at 11:21:01PM -0800, Moritz Fischer wrote:
> From: Xu Yilun <yilun.xu@intel.com>
> 
> The value of the field dfl_device.type comes from the 12 bits register
> field DFH_ID according to DFL spec. So this patch changes the definition
> of the type field to u16.
> 
> Also it is not necessary to illustrate the valid bits of the type field
> in comments. Instead we should explicitly define the possible values in
> the enumeration type for it, because they are shared by hardware spec.
> We should not let the compiler decide these values.
> 
> Similar changes are also applied to dfl_device.feature_id.
> 
> This patch also fixed the MODALIAS format according to the changes
> above.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl.c |  3 +--
>  drivers/fpga/dfl.h | 14 +++++++-------
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b450870b75ed..5a6ba3b2fa05 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -298,8 +298,7 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	struct dfl_device *ddev = to_dfl_dev(dev);
>  
> -	/* The type has 4 valid bits and feature_id has 12 valid bits */
> -	return add_uevent_var(env, "MODALIAS=dfl:t%01Xf%03X",
> +	return add_uevent_var(env, "MODALIAS=dfl:t%04Xf%04X",

Why drop the comment and not just fix it up instead?

>  			      ddev->type, ddev->feature_id);
>  }
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 5dc758f655b7..ac373b1fcff9 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -520,19 +520,19 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>   * enum dfl_id_type - define the DFL FIU types
>   */
>  enum dfl_id_type {
> -	FME_ID,
> -	PORT_ID,
> +	FME_ID = 0,
> +	PORT_ID = 1,
>  	DFL_ID_MAX,
>  };
>  
>  /**
>   * struct dfl_device_id -  dfl device identifier
> - * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> - * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> + * @type: DFL FIU type of the device. See enum dfl_id_type.
> + * @feature_id: feature identifier local to its DFL FIU type.
>   * @driver_data: driver specific data.
>   */
>  struct dfl_device_id {
> -	u8 type;
> +	u16 type;

Why isn't this enum dfl_id_type?

>  	u16 feature_id;
>  	unsigned long driver_data;
>  };
> @@ -543,7 +543,7 @@ struct dfl_device_id {
>   * @dev: generic device interface.
>   * @id: id of the dfl device.
>   * @type: type of DFL FIU of the device. See enum dfl_id_type.
> - * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> + * @feature_id: feature identifier local to its DFL FIU type.

But feature_id is still 16 bits, why change this?


>   * @mmio_res: mmio resource of this dfl device.
>   * @irqs: list of Linux IRQ numbers of this dfl device.
>   * @num_irqs: number of IRQs supported by this dfl device.
> @@ -553,7 +553,7 @@ struct dfl_device_id {
>  struct dfl_device {
>  	struct device dev;
>  	int id;
> -	u8 type;
> +	u16 type;

why isn't this an enum as well?

greg k-h

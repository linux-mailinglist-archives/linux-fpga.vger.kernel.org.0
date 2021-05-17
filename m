Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB0382514
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 09:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhEQHLZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 May 2021 03:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhEQHLY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 May 2021 03:11:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9030F60E09;
        Mon, 17 May 2021 07:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621235409;
        bh=jrTHUzGNqrxv8lufgHRzIQS8dD5Gv0s5cLx7IjzXx80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yS7J605bZOhHHkWSihkk1TGaCR4L2ILn2xWmYy1MTJ9oeGXuD2wrPozxeACa085Lg
         1AqDBuX/5rpfR/jlARL6S5LBomLu8+TJfOxd+P5M6sc0BaESx65d9tFwwhzkyFmJJh
         6KZUTEB+LnzALwy7GtAC41quZEmJZh4h+7XSAvOA=
Date:   Mon, 17 May 2021 09:10:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH 07/12] fpga: sec-mgr: expose hardware error info
Message-ID: <YKIWzleL3KxjOsQ/@kroah.com>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-8-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517023200.52707-8-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, May 16, 2021 at 07:31:55PM -0700, Moritz Fischer wrote:
> From: Russ Weight <russell.h.weight@intel.com>
> 
> Extend the FPGA Security Manager class driver to include
> an optional update/hw_errinfo sysfs node that can be used
> to retrieve 64 bits of device specific error information
> following a secure update failure.
> 
> The underlying driver must provide a get_hw_errinfo() callback
> function to enable this feature. This data is treated as
> opaque by the class driver. It is left to user-space software
> or support personnel to interpret this data.

No, you don't provide "opaque" data to userspace, that's a sure way to
make it such that no one knows what this data is supposed to be, and so
it can not be maintained at all.


> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  .../ABI/testing/sysfs-class-fpga-sec-mgr      | 14 +++++++
>  drivers/fpga/fpga-sec-mgr.c                   | 38 +++++++++++++++++++
>  include/linux/fpga/fpga-sec-mgr.h             |  5 +++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> index 749f2d4c78d3..f1881ce39c63 100644
> --- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> @@ -65,3 +65,17 @@ Description:	Read-only. Returns a string describing the failure
>  		idle state. If this file is read while a secure
>  		update is in progress, then the read will fail with
>  		EBUSY.
> +
> +What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/hw_errinfo
> +Date:		June 2021
> +KernelVersion:	5.14
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. Returns a 64 bit error value providing
> +		hardware specific information that may be useful in
> +		debugging errors that occur during FPGA image updates.
> +		This file is only visible if the underlying device
> +		supports it. The hw_errinfo value is only accessible
> +		when the secure update engine is in the idle state.
> +		If this file is read while a secure update is in
> +		progress, then the read will fail with EBUSY.
> +		Format: "0x%llx".
> diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
> index 48950843c2b4..cefe9182c3c3 100644
> --- a/drivers/fpga/fpga-sec-mgr.c
> +++ b/drivers/fpga/fpga-sec-mgr.c
> @@ -36,10 +36,17 @@ static void fpga_sec_set_error(struct fpga_sec_mgr *smgr, enum fpga_sec_err err_
>  	smgr->err_code = err_code;
>  }
>  
> +static void fpga_sec_set_hw_errinfo(struct fpga_sec_mgr *smgr)
> +{
> +	if (smgr->sops->get_hw_errinfo)
> +		smgr->hw_errinfo = smgr->sops->get_hw_errinfo(smgr);
> +}
> +
>  static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
>  			       enum fpga_sec_err err_code)
>  {
>  	fpga_sec_set_error(smgr, err_code);
> +	fpga_sec_set_hw_errinfo(smgr);
>  	smgr->sops->cancel(smgr);
>  }
>  
> @@ -221,6 +228,23 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(error);
>  
> +static ssize_t
> +hw_errinfo_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
> +	int ret;
> +
> +	mutex_lock(&smgr->lock);
> +	if (smgr->progress != FPGA_SEC_PROG_IDLE)
> +		ret = -EBUSY;

Why does the state matter here?

greg k-h

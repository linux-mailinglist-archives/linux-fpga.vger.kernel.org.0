Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EDD379625
	for <lists+linux-fpga@lfdr.de>; Mon, 10 May 2021 19:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhEJRmN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 May 2021 13:42:13 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:34383 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhEJRmM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 May 2021 13:42:12 -0400
Received: by mail-pf1-f172.google.com with SMTP id 10so14262208pfl.1;
        Mon, 10 May 2021 10:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TtC2/PC3whRQKetIsmZTwC4pn8EfBCLL0ecqsUxZkNg=;
        b=M0jiohpyEFZBnv1PcE9M7+hdFF6T8tdiZw8PV3OpzVhD22rxIxQA5tH40pl7LiA8jc
         /9diPjnCMmASvz5loTx1GFaMGK73q6Y6ybLMcnwvPua3zZ+rcL2yhVHnsQ5eO55khDcp
         wIAe4exeqKsi9eDMWhdnZixesaJhZ9PfWytGlfSIdAOGyVKm87Yf4cVjghqFST4/VBiO
         7s9wVPIUvrFSgRwEg02tb4PJyVP4/gc7SSZA+edv/MnTgX09SPUFXSALzAtDdXuwnJS/
         iBkB6BDSBfsiJujrbHeC7FNOF3N3fgjuaUGvPkG5SMDLRHaZF5CIWhw6gPzpiJ2ZjUwy
         SXbg==
X-Gm-Message-State: AOAM531g9s01aloOw0+0Oe4AF7+t02ny6mLZ3Dup6YKeby4icI+imeiw
        MnQfK7Hxk0cyWYMHazUR3JQ=
X-Google-Smtp-Source: ABdhPJwuRVPJvXv/8EIvqnvkFYD66awMYxyWKpnRBhVQ/M8KT2nqjTKIBsGWQbyBC+NvXZ0/yDuWPQ==
X-Received: by 2002:a05:6a00:be5:b029:28e:d71b:5b5f with SMTP id x37-20020a056a000be5b029028ed71b5b5fmr25795691pfu.34.1620668466569;
        Mon, 10 May 2021 10:41:06 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id g84sm11684600pfb.198.2021.05.10.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:41:06 -0700 (PDT)
Date:   Mon, 10 May 2021 10:41:05 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v12 7/7] fpga: sec-mgr: expose hardware error info
Message-ID: <YJlwMfyORHT1DDDF@epycbox.lan>
References: <20210503213546.316439-1-russell.h.weight@intel.com>
 <20210503213546.316439-8-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503213546.316439-8-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 03, 2021 at 02:35:46PM -0700, Russ Weight wrote:
> Extend the FPGA Security Manager class driver to include
> an optional update/hw_errinfo sysfs node that can be used
> to retrieve 64 bits of device specific error information
> following a secure update failure.
> 
> The underlying driver must provide a get_hw_errinfo() callback
> function to enable this feature. This data is treated as
> opaque by the class driver. It is left to user-space software
> or support personnel to interpret this data.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
> v11:
>   - No change
> v10:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
> v9:
>   - Updated Date and KernelVersion in ABI documentation
> v8:
>   - No change
> v7:
>   - Changed Date in documentation file to December 2020
> v6:
>   - No change
> v5:
>   - No change
> v4:
>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>     and removed unnecessary references to "Intel".
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> v3:
>   - No change
> v2:
>   - Bumped documentation date and version
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
> index 35bd419bd3b9..3c59b142291d 100644
> --- a/drivers/fpga/fpga-sec-mgr.c
> +++ b/drivers/fpga/fpga-sec-mgr.c
> @@ -36,10 +36,17 @@ static void set_error(struct fpga_sec_mgr *smgr, enum fpga_sec_err err_code)
>  	smgr->err_code = err_code;
>  }
>  
> +static void set_hw_errinfo(struct fpga_sec_mgr *smgr)
> +{
> +	if (smgr->sops->get_hw_errinfo)
> +		smgr->hw_errinfo = smgr->sops->get_hw_errinfo(smgr);
> +}

Nit: fpga_sec_set_hw_errinfo() maybe?
> +
>  static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
>  			       enum fpga_sec_err err_code)
>  {
>  	set_error(smgr, err_code);
> +	set_hw_errinfo(smgr);
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
> +	else
> +		ret = sysfs_emit(buf, "0x%llx\n", smgr->hw_errinfo);
> +	mutex_unlock(&smgr->lock);
> +
> +	return ret;
> +}
> +static DEVICE_ATTR_RO(hw_errinfo);
> +
>  static ssize_t remaining_size_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -252,6 +276,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>  	}
>  
>  	smgr->err_code = FPGA_SEC_ERR_NONE;
> +	smgr->hw_errinfo = 0;
>  	smgr->request_cancel = false;
>  	smgr->progress = FPGA_SEC_PROG_READING;
>  	reinit_completion(&smgr->update_done);
> @@ -286,18 +311,31 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(cancel);
>  
> +static umode_t
> +sec_mgr_update_visible(struct kobject *kobj, struct attribute *attr, int n)
> +{
> +	struct fpga_sec_mgr *smgr = to_sec_mgr(kobj_to_dev(kobj));
> +
> +	if (attr == &dev_attr_hw_errinfo.attr && !smgr->sops->get_hw_errinfo)
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
>  static struct attribute *sec_mgr_update_attrs[] = {
>  	&dev_attr_filename.attr,
>  	&dev_attr_cancel.attr,
>  	&dev_attr_status.attr,
>  	&dev_attr_error.attr,
>  	&dev_attr_remaining_size.attr,
> +	&dev_attr_hw_errinfo.attr,
>  	NULL,
>  };
>  
>  static struct attribute_group sec_mgr_update_attr_group = {
>  	.name = "update",
>  	.attrs = sec_mgr_update_attrs,
> +	.is_visible = sec_mgr_update_visible,
>  };
>  
>  static ssize_t name_show(struct device *dev,
> diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
> index 0e1f50434024..a99bfd28f38c 100644
> --- a/include/linux/fpga/fpga-sec-mgr.h
> +++ b/include/linux/fpga/fpga-sec-mgr.h
> @@ -40,6 +40,9 @@ enum fpga_sec_err {
>   *			    function and is called at the completion
>   *			    of the update, whether success or failure,
>   *			    if the prepare function succeeded.
> + * @get_hw_errinfo:	    Optional: Return u64 hw specific error info.
> + *			    The software err_code may used to determine
> + *			    whether the hw error info is applicable.
>   */
>  struct fpga_sec_mgr_ops {
>  	enum fpga_sec_err (*prepare)(struct fpga_sec_mgr *smgr);
> @@ -47,6 +50,7 @@ struct fpga_sec_mgr_ops {
>  	enum fpga_sec_err (*poll_complete)(struct fpga_sec_mgr *smgr);
>  	enum fpga_sec_err (*cancel)(struct fpga_sec_mgr *smgr);
>  	void (*cleanup)(struct fpga_sec_mgr *smgr);
> +	u64 (*get_hw_errinfo)(struct fpga_sec_mgr *smgr);
>  };
>  
>  /* Update progress codes */
> @@ -72,6 +76,7 @@ struct fpga_sec_mgr {
>  	enum fpga_sec_prog progress;
>  	enum fpga_sec_prog err_state;	/* progress state at time of failure */
>  	enum fpga_sec_err err_code;	/* security manager error code */
> +	u64 hw_errinfo;			/* 64 bits of HW specific error info */
>  	bool request_cancel;
>  	bool driver_unload;
>  	void *priv;
> -- 
> 2.25.1
> 

Thanks,
Moritz
